import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/model/user_model.dart';
import 'package:gamingworkdo_fe/services/auth_service.dart';

class EditUserprof extends StatefulWidget {
  final UserModel userModel;
  const EditUserprof({super.key, required this.userModel});

  @override
  State<EditUserprof> createState() => _EditUserprofState();
}

class _EditUserprofState extends State<EditUserprof> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userModel.fullName);
    emailController = TextEditingController(text: widget.userModel.email);
    phoneController = TextEditingController(text: widget.userModel.phoneNumber);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/imgs/user_profile.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 20),

            // Full Name
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Full Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter full name",
              ),
            ),
            const SizedBox(height: 20),

            // Phone Number
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone Number",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter phone number",
              ),
            ),
            const SizedBox(height: 20),

            // Email
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter email",
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                final updatedUser = UserModel(
                  fullName: nameController.text.trim(),
                  email: emailController.text.trim(),
                  phoneNumber: phoneController.text.trim(),
                  pass: widget.userModel.pass,
                );

                final success = await AuthService.updateUserProfile(
                  updatedUser,
                );
                if (success) {
                  Navigator.pop(context, true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile updated successfully!"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to update profile.")),
                  );
                }
              },
              child: const Text(
                "Save Changes",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
