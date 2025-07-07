import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/model/user_model.dart';
import 'package:gamingworkdo_fe/presentation/screens/edit_userprof.dart';
import 'package:gamingworkdo_fe/services/auth_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserModel? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final fetchedUser = await AuthService.fetchUserProfile();
    setState(() {
      userModel = fetchedUser;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : userModel == null
            ? const Center(child: Text("Không thể tải dữ liệu người dùng"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "User Profile",
                          style: TextStyle(fontSize: 28),
                        ),
                        const SizedBox(height: 10),
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'assets/imgs/user_profile.png',
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userModel?.fullName ?? "No Name",
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          userModel?.email ?? "No Email",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userModel?.phoneNumber ?? "No Phone Number",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () async {
                            if (userModel != null) {
                              // Chờ EditUserprof trả về kết quả (nếu có)
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditUserprof(userModel: userModel!),
                                ),
                              );

                              // Nếu có cập nhật thành công → load lại user
                              if (result == true) {
                                loadUser(); // gọi lại API fetchUserProfile()
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("User data is not loaded yet."),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(),
                  const ProfileMenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                  ),
                  const ProfileMenuItem(
                    icon: Icons.receipt_long,
                    title: 'My Orders',
                  ),
                  const ProfileMenuItem(
                    icon: Icons.location_on,
                    title: 'Address',
                  ),
                  const ProfileMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                  ),
                  const Divider(),
                  const ProfileMenuItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                  ),
                  const ProfileMenuItem(
                    icon: Icons.logout,
                    title: 'Log out',
                    isLogout: true,
                  ),
                ],
              ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.indigo),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // xử lý khi bấm menu
      },
    );
  }
}
