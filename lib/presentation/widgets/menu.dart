import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Drawer(
        child: ListView(
          children: [
            Container(
              height: 80,
              padding: EdgeInsets.only(left: 16, top: 16),
              alignment: Alignment.topLeft,
              color: Colors.blueAccent,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(height: 10),
            Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  "Shop",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text("Categories"),
                        iconColor: Colors.black,
                        collapsedIconColor: Colors.black,
                        children: [
                          ListTile(
                            title: Text("Game Consoles"),
                            trailing: Icon(Icons.arrow_right, size: 30),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text("Game Cards"),
                            trailing: Icon(Icons.arrow_right, size: 30),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text("Game Chairs"),
                            trailing: Icon(Icons.arrow_right, size: 30),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text("Game Monitors"),
                            trailing: Icon(Icons.arrow_right, size: 30),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text("Game PCs"),
                            trailing: Icon(Icons.arrow_right, size: 30),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text("Feature Products"),
                        iconColor: Colors.black,
                        collapsedIconColor: Colors.black,
                        children: [
                          ListTile(
                            title: Text("Gaming Chair for Gamers with Lumbar"),
                            trailing: Icon(Icons.arrow_right, size: 30),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text("HTC Vive Tracker (3.0) - PC"),
                            trailing: Icon(Icons.arrow_right, size: 30),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text("VR Headset with Headphones"),
                            trailing: Icon(Icons.arrow_right, size: 30),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text("RX 590 GTS  Graphics Card"),
                            trailing: Icon(Icons.arrow_right, size: 30),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
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
                  "Products",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Game Consoles"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Game Cards"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Game Chairs"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Game Monitors"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Game PCs"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
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
                  "Pages",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("About Us"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Contact with Us"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Game Chairs"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("FAQ's"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Privacy Policy"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Shipping & Delivery"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Terms & Conditions"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
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
                  "Blogs",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Blog Pages"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      title: Text("Article Page"),
                      trailing: Icon(Icons.arrow_right, size: 30),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
