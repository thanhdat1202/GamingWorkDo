import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/decription_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';

class AboutusPage extends StatefulWidget {
  const AboutusPage({super.key});

  @override
  State<AboutusPage> createState() => _AboutusPageState();
}

class _AboutusPageState extends State<AboutusPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //appbar
          AppbarWidget(scaffoldKey: scaffoldKey, onSearchChanged: (value) {}),

          //description page
          DecriptionPage(
            title: "About Us",
            subtitle:
                "The gaming industry continues to push the boundaries of innovation, offering virtual reality experiences that blur the lines between the real and the digital.",
            backTo: "Back to home",
            onBack: () {
              Navigator.pop(context);
            },
          ),

          // content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Making ",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                        TextSpan(
                          text: "History ",
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                        TextSpan(
                          text: "Together",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "gaming commands substantial influence. Countries invest in gaming infrastructure and support local developers, recognizing the industry's potential to drive innovation and economic growth.",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      "./assets/imgs/aboutus1.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Gaming Founded With Headquarters In Different Country",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Gaming stands poised at the forefront of technological innovation, promising a future that blends virtual reality (VR), augmented reality (AR), and artificial intelligence (AI) into seamless, immersive experiences. Imagine stepping into fully realized digital worlds where boundaries between reality and fantasy blur, or competing in global tournaments without leaving your home. These advancements not only enhance gameplay but also redefine how we perceive and interact with entertainment.",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      "./assets/imgs/aboutus2.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "We Have Expert Team Member",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Beyond its technological leaps, gaming holds significant cultural sway. It serves as a universal language that transcends geographical and generational divides, fostering communities and shared experiences. The rise of esports, where professional gamers compete for lucrative prizes and global recognition, has transformed gaming into a spectator sport rivaling traditional athletics in popularity and revenue. This cultural shift not only elevates gaming as a mainstream form of entertainment but also challenges societal norms and perceptions.",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      "./assets/imgs/aboutus3.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "The Quality Of Our Products Is Smoth Gaming Experience",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Economically, gaming commands substantial influence. Countries invest in gaming infrastructure and support local developers, recognizing the industry's potential to drive innovation and economic growth. Major gaming events attract millions of participants and spectators alike, injecting tourism and revenue into local economies while promoting digital literacy and technological advancement.However, as gaming continues to expand its reach, it faces critical challenges. Issues such as online safety, digital addiction, and the ethical use of AI in gaming demand careful consideration. Striking a balance between innovation and responsible gaming practices will be essential in shaping a sustainable and inclusive gaming future.",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          //footer\
          FooterWidget(),
        ],
      ),
    );
  }
}
