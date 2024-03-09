import 'product.dart';

class ProductManager {
  final Map<int, Product> Store = {};

  ProductManager({required Store});

  //  get all avaialble products in the store
  getAllProduct() {
    if (Store.length == 0) {
      print("no enough products to show");
      return null;
    } else {
      var ProductList = [];
      for (var item in Store.values) {
        var newitem = {
          "id": item.id,
          "Name": item.name,
          "Price": item.price,
          "Description": item.description
        };
        ProductList.add(newitem);
      }
      return ProductList;
    }
  }

  // get one product with the specified id
  getOneProduct(int id) {
    if (Store.containsKey(id)) {
      var item = Store[id];
      return {
        "id": item?.id,
        "Name": item?.name,
        "Price": item?.price,
        "Description": item?.description
      };
    }
    return "no product found with id $id";
  }

  // add new product to the store
  addProduct(Product product) {
    this.Store[product.id] = product;
    print(getOneProduct(product.id));
  }

  // edit some product its name, price or description or all
  editProduct(int id,
      {String name = "", String description = "", int price = -1}) {
    if (Store.containsKey(id)) {
      var item = Store[id];
      // Edit the product with the changed parametre
      if (name != '') {
        item?.name = name;
      }
      if (description != '') {
        item?.description = description;
      }
      if (price != -1) {
        item?.price = price;
      }
    } else {
      var new_product = Product(name, price, description: description);
      this.addProduct(new_product);
      return 'new product added';
    }
  }

  // delete a product with specified id
  deleteProduct(int id) {
    return Store.remove(id);
  }
}
