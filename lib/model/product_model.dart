class ProductVariant {
  final int variantId;
  final String variantName;
  final double variantPrice;
  final String productImageMain;
  // final String productImageHover;
  final int rating;
  final Map<String, String> attributes;

  ProductVariant({
    required this.variantId,
    required this.variantName,
    required this.variantPrice,
    required this.productImageMain,
    // required this.productImageHover,
    required this.rating,
    required this.attributes,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      variantId: json['variant_id'],
      variantName: json['variant_name'],
      variantPrice: (json['variant_price'] as num).toDouble(),
      productImageMain: json['product_image_main'],
      // productImageHover: json['product_image_hover'],
      rating: json['rating'] ?? 0,
      attributes: Map<String, String>.from(json['attributes'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variant_id': variantId,
      'variant_name': variantName,
      'variant_price': variantPrice,
      'product_image_main': productImageMain,
      // 'product_image_hover': productImageHover,
      'rating': rating,
      'attributes': attributes,
    };
  }
}

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String status;
  final String brandName;
  final String categoryName;
  final List<ProductVariant> variants;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.brandName,
    required this.categoryName,
    required this.variants,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['product_id'],
      name: json['product_name'],
      description: json['description'],
      status: json['product_status'],
      brandName: json['brands']['brand_name'],
      categoryName: json['categories']['category_name'],
      variants: (json['product_variants'] as List)
          .map((v) => ProductVariant.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'product_name': name,
      'description': description,
      'product_status': status,
      'brands': {'brand_name': brandName},
      'categories': {'category_name': categoryName},
      'product_variants': variants.map((v) => v.toJson()).toList(),
    };
  }
}
