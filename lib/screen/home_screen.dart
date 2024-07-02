import 'package:beehive/screen/viewall.dart';
import 'package:beehive/styles/typography.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
                    icon: const Icon(Icons.close, color: Color(0xFF0B2A47)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.folder, color: Color(0xFF0B2A47)),
                title: const Text('Choose from files', style: AppTypography.businessCardSubtitle),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF0B2A47)),
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
              icon: const Icon(Icons.add, color: Colors.white),
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
                          Icon(Icons.phone, color: Color(0xFF0B2A47)),
                          SizedBox(width: 8),
                          Text('011 234567\n077 1234567', style: AppTypography.businessCardSubtitle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Icon(Icons.email, color: Color(0xFF0B2A47)),
                          SizedBox(width: 8),
                          Text('example@mail.com', style: AppTypography.businessCardSubtitle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Icon(Icons.web, color: Color(0xFF0B2A47)),
                          SizedBox(width: 8),
                          Text('example.com', style: AppTypography.businessCardSubtitle),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Icon(Icons.location_on, color: Color(0xFF0B2A47)),
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
                        icon: const Icon(Icons.edit, color: Color(0xFF0B2A47)),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Color(0xFF0B2A47)),
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
