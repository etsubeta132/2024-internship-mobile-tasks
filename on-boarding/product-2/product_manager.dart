import 'product.dart';
import 'status.dart';

class ProductManager {
  final Map<int, Product> Store = {};

  ProductManager({required Store});

  //  get all avaialble products in the store
  List getAllProduct() {
    if (Store.length == 0) {
      print("no enough products to show");
      return [];
    } else {
      var ProductList = [];
      for (var item in Store.values) {
        var newitem = {
          "id": item.id,
          "Name": item.name,
          "Price": item.price,
          "Status": item.status,
          "Description": item.description
        };
        ProductList.add(newitem);
      }
      return ProductList;
    }
  }

  // get one product with the specified id
  Map<String, dynamic> getOneProduct(int id) {
    if (Store.containsKey(id)) {
      Product item = Store[id]!;
      return {
        "id": item.id,
        "name": item.name,
        "price": item.price,
        "status": item.status,
        "description": item.description
      };
    } else {
      print("no product found with id $id");
      return {};
    }
  }

  // add new product to the store
  addProduct(Product product) {

    Store[product.id] = product;
    print(getOneProduct(product.id));
  }

  // edit some product its name, price or description or all
  editProduct(int id,
      {String name = "",
      String description = "",
      double price = -1,
      Status status = Status.PENDING}) {
    if (Store.containsKey(id)) {
      var item = Store[id];
      if (item == null) {
        print("no product to update");
      } else {
        // Edit the product with the changed parameter
        if (name != '') {
          item.name = name;
        } else {}
        if (description != '') {
          item.description = description;
        }
        if (price != -1) {
          item.price = price;
        }
        if (status == Status.PENDING || status == Status.COMPLETED) {
          item.status = status;
        }
        print("product updated");
      }
    }
  }

  // delete a product with specified id
  deleteProduct(int id) {
    if (getOneProduct(id).length != 0) {
      Store.remove(id);
      print("product removed succesfully");
    }
  }

  List? getPendingProduct() {
    if (Store.length == 0) {
      print("no enough products to show");
      return null;
    } else {
      var PendingProducts = [];
      for (var item in Store.values) {
        if (item.status == Status.PENDING) {
          var newitem = {
            "id": item.id,
            "Name": item.name,
            "Price": item.price,
            "Status": item.status,
            "Description": item.description
          };
          PendingProducts.add(newitem);
        }
      }
      return PendingProducts;
    }
  }

  List? getCompletedProduct() {
    if (Store.length == 0) {
      print("no enough products to show");
      return null;
    } else {
      var CompletedProducts = [];
      for (var item in Store.values) {
        if (item.status == Status.COMPLETED) {
          var newitem = {
            "id": item.id,
            "Name": item.name,
            "Price": item.price,
            "Status": item.status,
            "Description": item.description
          };
          CompletedProducts.add(newitem);
        }
      }
      return CompletedProducts;
    }
  }
}
