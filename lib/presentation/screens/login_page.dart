import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/main.dart';
import 'package:gamingworkdo_fe/presentation/screens/signup_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/decription_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';
import 'package:gamingworkdo_fe/presentation/widgets/scroll_to_top.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final void Function(int)? onChangePage;

  const LoginPage({super.key, this.onChangePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int? selectedShareIndex;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _saveTestAccount();
  }

  Future<void> _saveTestAccount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', 'test@gmail.com');
    await prefs.setString('password', '12345');
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController, // Thêm dòng này!
        slivers: [
          // AppBar
          // buildCustomAppBar(context, GlobalKey<ScaffoldState>()),

          //Decription Page
          DecriptionPage(
            backTo: "",
            title: "Login",
            subtitle:
                "Welcome to gaming – where every login is a new adventure. Gear up, dive in, and conquer your quests. Your journey to greatness starts now!",
            onBack: () {
              if (widget.onChangePage != null) {
                widget.onChangePage!(2);
              }
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 410,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Form(
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
                                  "Email :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "*",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Password :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "*",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: passController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(),
                              ),
                            ),

                            //forgot your password
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 0,
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
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //Policy
                            SizedBox(height: 10),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "By continuing, you agree to the ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Terms of use",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Xử lý chuyển trang đăng ký ở đây
                                        // Navigator.push(...);
                                      },
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Xử lý chuyển trang đăng ký ở đây
                                        // Navigator.push(...);
                                      },
                                  ),
                                ],
                              ),
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
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  final email = prefs.getString('email');
                                  final password = prefs.getString('password');

                                  final inputEmail = emailController.text;
                                  final inputPass = passController.text;

                                  if (inputEmail == email &&
                                      inputPass == password) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainPage(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Sai email hoặc mật khẩu !!!',
                                        ),
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
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Sign up",
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Xử lý chuyển trang đăng ký ở đây
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
