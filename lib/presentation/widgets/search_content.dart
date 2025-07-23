import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/model/product_model.dart';
import 'package:gamingworkdo_fe/presentation/screens/detail_product.dart';
import 'package:gamingworkdo_fe/services/product_service.dart';

class SearchContent extends StatefulWidget {
  @override
  _SearchContentState createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  void onSearch(String query) async {
    if (query.length < 2) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    final products = await ProductService.getAllProducts();
    final filtered = products
        .where(
          (p) => p['product_name'].toString().toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
        .toList();

    setState(() {
      searchResults = filtered.cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Start Typing And Hit Enter",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 10),

              TextField(
                controller: _controller,
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: "Search Product...",
                  border: UnderlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 10),

              if (_controller.text.length < 2)
                Text(
                  "You must enter at least 2 characters.",
                  style: TextStyle(color: Colors.grey[600]),
                ),

              if (_controller.text.length >= 2)
                Expanded(
                  child: searchResults.isEmpty
                      ? Center(
                          child: Text(
                            "No products found.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          itemCount: searchResults.length,
                          separatorBuilder: (_, __) => Divider(),
                          itemBuilder: (context, index) {
                            final product = searchResults[index];
                            final variant =
                                product['product_variants']?[0] ?? {};
                            final imageUrl =
                                variant['product_image_main'] ?? '';

                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  imageUrl,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: Colors.grey[300],
                                        height: 50,
                                        width: 50,
                                        child: Icon(Icons.broken_image),
                                      ),
                                ),
                              ),
                              title: Text(product['product_name']),
                              subtitle: Text(
                                product['brands']?['brand_name'] ?? '',
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailProduct(
                                      product: ProductModel.fromJson(product),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
