import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unicons/unicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beehive/screen/login_screen.dart'; // Import the LoginScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<bool> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio16x9,
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: const Color(0xFF0B2A47),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Crop Image',
            ),
          ],
        );

        if (croppedFile != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image selected: ${croppedFile.path}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image cropping canceled.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while picking the image.')),
      );
    }
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    final permissionsGranted = await _requestPermissions();
    if (!permissionsGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Camera and storage permissions are required. Please enable them in settings.'),
        ),
      );
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
                    icon: const Icon(UniconsLine.times, color: Color(0xFF0B2A47)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                leading: const Icon(UniconsLine.folder, color: Color(0xFF0B2A47)),
                title: const Text('Choose from files', style: AppTypography.businessCardSubtitle),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery, context);
                },
              ),
              ListTile(
                leading: const Icon(UniconsLine.camera, color: Color(0xFF0B2A47)),
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

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed out successfully.')),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
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
                backgroundColor: const Color(0xFFF69C2C),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () => _showImageSourceDialog(context),
              icon: const Icon(UniconsLine.plus, color: Colors.white),
              label: const Text('Add New', style: AppTypography.button),
            ),
            PopupMenuButton(
              icon: const CircleAvatar(
                backgroundImage: AssetImage('assets/profile_image.png'), // Replace with dynamic image
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'signout',
                  child: Row(
                    children: const [
                      Icon(UniconsLine.sign_out_alt, color: Color(0xFF0B2A47)),
                      SizedBox(width: 8),
                      Text('Sign Out', style: AppTypography.businessCardSubtitle),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'signout') {
                  _signOut(context);
                }
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // Replace with dynamic item count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/logo.png', width: 50, height: 50),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Jon Doe', style: AppTypography.businessCardTitle),
                            const Text('CEO & Founder - ABC Company',
                                style: AppTypography.businessCardSubtitle, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      IconWrapper(icon: UniconsLine.phone),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text('011 234567\n077 1234567',
                            style: AppTypography.businessCardSubtitle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      IconWrapper(icon: UniconsLine.envelope_alt),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text('example@mail.com',
                            style: AppTypography.businessCardSubtitle, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      IconWrapper(icon: UniconsLine.globe),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text('example.com',
                            style: AppTypography.businessCardSubtitle, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      IconWrapper(icon: UniconsLine.map_marker),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text('123, nowhere st, New York, US',
                            style: AppTypography.businessCardSubtitle, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
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
        borderRadius: BorderRadius.circular(8.0),
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
    height: 1.35,
  );

  static const TextStyle businessCardSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.35,
    color: Color(0xFF0B2A47),
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.35,
    color: Colors.white,
  );

  static const TextStyle viewAllText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.35,
    color: Color(0xFF0B2A47),
  );
}
