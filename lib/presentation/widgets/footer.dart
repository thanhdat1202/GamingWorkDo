import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  int? selectedShareIndex;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      "Gaming",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Reach out & let your mind explore",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "I also love the challenge of trying to beat a difficult game or master a new skill.",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),

              Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text(
                    "NAVIGATION",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,

                  children: [
                    ListTile(
                      title: Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "All Collections",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "All Products",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "Article Page",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "Blog Page",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text(
                    "USEFULLLINK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,

                  children: [
                    ListTile(
                      title: Text(
                        "About Us",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "Contact With Us",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "FAQ's",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "Privacy Policy",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "Shopping & Dilivery",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "Terms & Conditions",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text(
                    "SHARE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  collapsedIconColor: Colors.white,
                  iconColor: Colors.white,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              selectedShareIndex = 0;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.squareFacebook,
                            color: selectedShareIndex == 0
                                ? Colors.lightBlue
                                : Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              selectedShareIndex = 1;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.squareInstagram,
                            color: selectedShareIndex == 1
                                ? Colors.lightBlue
                                : Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              selectedShareIndex = 2;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.squareYoutube,
                            color: selectedShareIndex == 2
                                ? Colors.lightBlue
                                : Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              selectedShareIndex = 3;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.squarePinterest,
                            color: selectedShareIndex == 3
                                ? Colors.lightBlue
                                : Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              selectedShareIndex = 4;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.squareXTwitter,
                            color: selectedShareIndex == 4
                                ? Colors.lightBlue
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "© 2025, Gaming WorkDo, Powered by WorkDo.Io",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "./assets/imgs/logo-visa.png",
                    height: 20,
                    width: 40,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 5),
                  Image.asset(
                    "./assets/imgs/logo-mastercard.png",
                    height: 20,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 5),
                  Image.asset(
                    "./assets/imgs/logo-amex.png",
                    height: 20,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 5),
                  Image.asset(
                    "./assets/imgs/logo-paypal.png",
                    height: 20,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 5),
                  Image.asset(
                    "./assets/imgs/logo-diners.png",
                    height: 20,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 5),
                  Image.asset(
                    "./assets/imgs/logo-discover.png",
                    height: 20,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
