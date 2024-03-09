class Product {
  static int _defaultId = 1;
  int id = 0;
  String? name;
  String? description;
  int? price;

  Product(String name, int price ,{ String description = ""}) {
    this.id = _defaultId;
    _defaultId++;
    this.name = name;
    this.description = description;
    this.price = price;
  }
}
