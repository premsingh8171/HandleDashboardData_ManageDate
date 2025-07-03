class FoodProduct {
  final String? productName;
  final String? brands;
  final String? imageThumbUrl;
  final String? imageUrl;
  final String? ingredientsText;

  FoodProduct({
    this.productName,
    this.brands,
    this.imageThumbUrl,
    this.imageUrl,
    this.ingredientsText,
  });

  factory FoodProduct.fromJson(Map<String, dynamic> json) {
    return FoodProduct(
      productName: json['product_name'],
      brands: json['brands'],
      imageThumbUrl: json['image_thumb_url'],
      imageUrl: json['image_url'],
      ingredientsText: json['ingredients_text'],
    );
  }
}
