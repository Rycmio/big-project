enum KindOfFood {
  Food,
  Drinks,
  Desert,
}

class Product {
  final String id;
  final String imageUrl;
  final String name;
  final double price;
  bool status;
  bool serve;
  final KindOfFood kindOfFood;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.status = true,
    this.serve = false,
    required this.kindOfFood,
  });
}
