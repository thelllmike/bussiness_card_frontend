import 'package:beehive/screen/viewall.dart';
import 'package:beehive/styles/typography.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unicons/unicons.dart'; // Import Unicons

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<bool> requestPermissions() async {
    final status = await [
      Permission.camera,
      Permission.storage,
    ].request();

    return status[Permission.camera]!.isGranted && status[Permission.storage]!.isGranted;
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      // Handle the picked image file (e.g., display it or upload it)
    } else {
      // User canceled the picker
    }
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    final granted = await requestPermissions();
    if (!granted) {
      // Show a message to the user explaining why the permissions are needed
      return;
    }

    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Add to New Card', style: AppTypography.viewAllText),
                  IconButton(
                    icon: const Icon(UniconsLine.times, color: Color(0xFF0B2A47)), // Use Unicons
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                leading: const Icon(UniconsLine.folder, color: Color(0xFF0B2A47)), // Use Unicons
                title: const Text('Choose from files', style: AppTypography.businessCardSubtitle),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery, context);
                },
              ),
              ListTile(
                leading: const Icon(UniconsLine.camera, color: Color(0xFF0B2A47)), // Use Unicons
                title: const Text('Take a Photo', style: AppTypography.businessCardSubtitle),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera, context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditCardDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Edit Card Details', style: AppTypography.viewAllText),
                    IconButton(
                      icon: const Icon(UniconsLine.times, color: Color(0xFF0B2A47)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const Divider(),
                _buildTextField(label: 'Name', initialValue: 'Jon Doe'),
                _buildTextField(label: 'Company Name', initialValue: 'ABC Company'),
                _buildTextField(label: 'Position', initialValue: 'CEO & Founder'),
                _buildTextField(label: 'Phone', initialValue: '011 234567'),
                _buildTextField(label: 'Phone', initialValue: '077 1234567'),
                _buildTextField(label: 'Email', initialValue: 'example@mail.com'),
                _buildTextField(label: 'Website', initialValue: 'example.com'),
                _buildTextField(label: 'Address', initialValue: '123, nowhere st, New York, US'),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF0B2A47),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () {
                    // Handle save action
                  },
                  child: const Text('Save', style: AppTypography.button),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({required String label, required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xFF0B2A47)),
          ),
        ),
        style: AppTypography.businessCardSubtitle,
        controller: TextEditingController(text: initialValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF69C2C), // button background color
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () => _showImageSourceDialog(context),
              icon: const Icon(UniconsLine.plus, color: Colors.white), // Use Unicons
              label: const Text('Add New', style: AppTypography.button),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // replace with your dynamic item count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/logo.png', width: 50, height: 50),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jon Doe', style: AppTypography.businessCardTitle),
                              Text('CEO & Founder - ABC Company', style: AppTypography.businessCardSubtitle),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          IconWrapper(icon: UniconsLine.phone),
                          SizedBox(width: 8),
                          Text('011 234567\n077 1234567', style: AppTypography.businessCardSubtitle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          IconWrapper(icon: UniconsLine.envelope_alt),
                          SizedBox(width: 8),
                          Text('example@mail.com', style: AppTypography.businessCardSubtitle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          IconWrapper(icon: UniconsLine.globe),
                          SizedBox(width: 8),
                          Text('example.com', style: AppTypography.businessCardSubtitle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          IconWrapper(icon: UniconsLine.map_marker),
                          SizedBox(width: 8),
                          Text('123, nowhere st, New York, US', style: AppTypography.businessCardSubtitle),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(UniconsLine.edit, color: Color(0xFF0B2A47)), // Use Unicons
                        onPressed: () => _showEditCardDialog(context),
                      ),
                      IconButton(
                        icon: const Icon(UniconsLine.trash_alt, color: Color(0xFF0B2A47)), // Use Unicons
                        onPressed: () {
                          // Handle delete action
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class IconWrapper extends StatelessWidget {
  final IconData icon;
  const IconWrapper({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.93,
      height: 35.87,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0B2A47),
        borderRadius: BorderRadius.circular(8.0), // Make border radius equal on all sides
      ),
      child: Center(
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class AppTypography {
  static const String fontFamily = 'GeneralSans';

  static const TextStyle businessCardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.35, // This is line-height / font-size
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle businessCardSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.35, // This is line-height / font-size
    color: Color(0xFF0B2A47),
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.35, // This is line-height / font-size
    color: Colors.white,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle viewAllText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.35, // This is line-height / font-size
    color: Color(0xFF0B2A47),
    textBaseline: TextBaseline.alphabetic,
  );
}
