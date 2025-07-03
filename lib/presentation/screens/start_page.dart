import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/main.dart';
import 'package:gamingworkdo_fe/presentation/screens/signup_page.dart';
import 'package:gamingworkdo_fe/services/auth_service.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // tránh tự co lại
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("./assets/imgs/screen1st.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Login here",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        icon: Icon(
                          FontAwesomeIcons.envelope,
                          color: Colors.white,
                          size: 30,
                        ),
                        hint: Text("Email"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    child: TextFormField(
                      controller: passController,
                      decoration: InputDecoration(
                        icon: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.white,
                          size: 30,
                        ),
                        hint: Text("Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                        ), // Thêm padding ngang
                        minimumSize: Size(
                          0,
                          0,
                        ), // Đảm bảo không bị giới hạn bởi min width mặc định
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Thu nhỏ vùng chạm
                      ),
                      onPressed: () {},
                      child: Text(
                        "Forgot Your Password?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                      ),
                      onPressed: () async {
                        final inputEmail = emailController.text.trim();
                        final inputPass = passController.text.trim();

                        if (inputEmail.isEmpty || inputPass.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Vui lòng nhập email và mật khẩu'),
                            ),
                          );
                          return;
                        }

                        final success = await AuthService.login(
                          email: inputEmail,
                          pass: inputPass,
                        );

                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sai email hoặc mật khẩu !!!'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  //to Sign up
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have account? ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
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
        ],
      ),
    );
  }
}
