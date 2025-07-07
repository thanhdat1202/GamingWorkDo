import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/presentation/screens/login_page.dart';
import 'package:gamingworkdo_fe/presentation/screens/start_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/decription_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';
import 'package:gamingworkdo_fe/presentation/widgets/scroll_to_top.dart';
import 'package:gamingworkdo_fe/services/auth_service.dart';

class SignupPage extends StatefulWidget {
  final void Function(int)? onChangePage;
  const SignupPage({super.key, this.onChangePage});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();

  //controller
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passWordController = TextEditingController();

  bool isLoading = false;
  //
  int? selectedShareIndex;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    //Goi API
    final thanhcong = await AuthService.signup(
      fullName: fullNameController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      email: emailController.text.trim(),
      pass: passWordController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    //ket qua
    if (thanhcong) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Đăng ký thành công")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Đăng ký thất bại")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // AppBar
          buildCustomAppBar(context),

          //Decription Page
          DecriptionPage(
            backTo: "",
            title: "Create Account",
            subtitle:
                "Join the ultimate gaming community and unlock exclusive rewards. Register now and start your adventure!",
            onBack: () {
              Navigator.of(context).pop();
            },
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 15,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Full Name :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: fullNameController,
                              decoration: InputDecoration(
                                hintText: "Full Name",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? "Fill your full name" : null,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "Phone Number :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? "Fill your phone number"
                                  : null,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "Email :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Fill your email";
                                }

                                // Biểu thức chính quy kiểm tra định dạng email
                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );
                                if (!emailRegex.hasMatch(value.trim())) {
                                  return "Email không hợp lệ";
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "Password :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: passWordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Fill your password";
                                }

                                if (value.trim().length < 5) {
                                  return "Password phải có ít nhất 5 ký tự";
                                }

                                return null;
                              },
                            ),

                            //button Login
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  minimumSize: Size(150, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: submit,
                                child: Text(
                                  "CREATE AN ACCOUNT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),

                            //to Sign up
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Already Have An Account? ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Log in",
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //footer
          FooterWidget(),
        ],
      ),
      floatingActionButton: ScrollToTop(controller: _scrollController),
    );
  }
}
