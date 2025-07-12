import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/model/product_model.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel product;
  const DetailProduct({super.key, required this.product});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  late ProductVariant selectedVariant;

  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    selectedVariant = widget.product.variants[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          //appbar
          buildCustomAppBar(context, GlobalKey<ScaffoldState>()),

          //back to home
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
              child: Row(
                children: [
                  IconButton.outlined(
                    iconSize: 16,
                    color: Colors.white,
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      FontAwesomeIcons.arrowLeftLong,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Back to home",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 0,
                bottom: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 450,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.product.variants.length,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                          selectedVariant = widget.product.variants[index];
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Image.network(
                            selectedVariant.productImageMain,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20),
                  _decriptionPro(widget.product.brandName),
                  SizedBox(height: 20),
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          index < selectedVariant.rating
                              ? FontAwesomeIcons.solidStar
                              : FontAwesomeIcons.star,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "TYPE: ${widget.product.categoryName}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "SKU : 9140570231131",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.product.description,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "\$${selectedVariant.variantPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 50),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.grey),
                              onPressed: () {
                                // Trừ số lượng
                              },
                              iconSize: 16,
                              padding: EdgeInsets.zero,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                '1',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.grey),
                              onPressed: () {},
                              iconSize: 16,
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if (selectedVariant.attributes.isNotEmpty)
                    Text(
                      "${selectedVariant.attributes.keys.first} : ${selectedVariant.attributes.values.first}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 20),
                  Row(
                    children: widget.product.variants.map((variant) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedVariant = variant;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 1),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(variant.productImageMain),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 160,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 160,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "BUY IT NOW",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.favorite_border,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Shipping Policy",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Returns Policy",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Within 30 days of delivery, you can return the majority of new, unopened products for a complete refund. If the return is due to a mistake on our part (you received a damaged or inaccurate item, etc.), we will additionally cover the cost of return postage.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "When you give your box to the return shipper, you should anticipate receiving your refund in four weeks, although in many circumstances, you will get your money back sooner. This time frame covers the following: the time it takes us to process your return once we receive it from the shipper (3 to 5 business days), the time it takes your bank to process our refund request (5 to 10 business days), and the transit time for us to get your return from the shipper (5 to 10 business days).",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "To return an item, just sign in to your account, select the 'Complete Orders' link from the My Account menu, see the order, and then click the Return Item(s) button. Upon receipt and processing of the returned goods, we will send you an email to confirm your reimbursement.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Text(
                      "Shipping Policy",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Within 30 days of delivery, you can return the majority of new, unopened products for a complete refund. If the return is due to a mistake on our part (you received a damaged or inaccurate item, etc.), we will additionally cover the cost of return postage.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "When you give your box to the return shipper, you should anticipate receiving your refund in four weeks, although in many circumstances, you will get your money back sooner. This time frame covers the following: the time it takes us to process your return once we receive it from the shipper (3 to 5 business days), the time it takes your bank to process our refund request (5 to 10 business days), and the transit time for us to get your return from the shipper (5 to 10 business days).",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "To return an item, just sign in to your account, select the 'Complete Orders' link from the My Account menu, see the order, and then click the Return Item(s) button. Upon receipt and processing of the returned goods, we will send you an email to confirm your reimbursement.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //footer
          FooterWidget(),
        ],
      ),
    );
  }

  Widget _decriptionPro(title) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlue, Colors.blue[800]!],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          "$title",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
