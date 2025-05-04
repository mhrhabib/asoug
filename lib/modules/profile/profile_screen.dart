import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Abu Taleb');
  final _emailController = TextEditingController(text: 'abu.taleb@example.com');
  final _phoneController = TextEditingController(text: '+966 50 123 4567');
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final ProfileController _controller = Get.put(ProfileController());
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final buttonWidth = screenWidth * 0.9;
    final avatarRadius = isSmallScreen ? 50.0 : 60.0;
    final cameraIconSize = isSmallScreen ? 18.0 : 24.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              width: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfilePictureSection(avatarRadius, cameraIconSize),
            const Gap(16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildLabeledTextField(
                    label: 'Name',
                    controller: _nameController,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
                  ),
                  _buildLabeledTextField(
                    label: 'Email',
                    controller: _emailController,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter your email' : null,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildLabeledTextField(
                    label: 'Phone',
                    controller: _phoneController,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter your phone' : null,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            const Gap(16),
            SizedBox(
              width: buttonWidth,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                onPressed: _updateProfile,
                child: Text(
                  'Update',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Gap(24),
            _buildChangePasswordSection(buttonWidth, isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection(double avatarRadius, double cameraIconSize) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.grey[200],
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(avatarRadius),
                      child: Image.file(
                        _selectedImage!,
                        width: avatarRadius * 2,
                        height: avatarRadius * 2,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(avatarRadius),
                      child: Image.network(
                        'https://picsum.photos/200',
                        width: avatarRadius * 2,
                        height: avatarRadius * 2,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person,
                          size: avatarRadius,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _changeProfilePicture,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.camera_enhance_outlined,
                    size: cameraIconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        Text(
          'Welcome,',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        Text(
          'Abu Taleb',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildChangePasswordSection(double buttonWidth, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Change Password',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[300],
        ),
        const Gap(16),
        Form(
          key: _passwordFormKey,
          child: Column(
            children: [
              _buildLabeledTextField(
                label: 'Current password',
                controller: _currentPasswordController,
                obscureText: true,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter current password' : null,
              ),
              _buildLabeledTextField(
                label: 'New Password',
                controller: _newPasswordController,
                obscureText: true,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter new password' : null,
              ),
              _buildLabeledTextField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please confirm password';
                  if (value != _newPasswordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
            ],
          ),
        ),
        const Gap(16),
        SizedBox(
          width: buttonWidth,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            onPressed: _changePassword,
            child: Text(
              'Change Password',
              style: TextStyle(
                fontSize: isSmallScreen ? 18 : 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const Gap(24),
      ],
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const Gap(4),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  void _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _controller.updateProfile(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Profile updated successfully' : 'Failed to update profile'),
        ),
      );
    }
  }

  void _changePassword() async {
    if (_passwordFormKey.currentState?.validate() ?? false) {
      final success = await _controller.updatePassword(
        _newPasswordController.text.trim(),
        _confirmPasswordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Password changed successfully' : 'Failed to change password'),
        ),
      );

      if (success) {
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      }
    }
  }

  void _changeProfilePicture() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _selectedImage = File(pickedFile.path);
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _selectedImage = File(pickedFile.path);
                  });
                  final success = await _controller.updateAvatar(_selectedImage!);
                  if (success) {
                    print("updated");
                  } else {
                    print('not updated');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
