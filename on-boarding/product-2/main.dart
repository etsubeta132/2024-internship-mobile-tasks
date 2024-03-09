import 'dart:io';

import 'product_manager.dart';
import 'product.dart';

void main() {
  var pdtMan = ProductManager(Store: {});
  print("Welcome Manager What you want to do today");
  print("");
  var menu = """
  1. View All Product               3. Add Product             5, Delete Product
  2. View One Product               4, Edit Product            other - Quite
                 
""";

  print(menu);
  var havetodo = true;
  while (havetodo) {
    stdout.write("Choose your service: ");
    String input = stdin.readLineSync() ?? "";
    int? choice = int.tryParse(input);
    if (choice == null) {
      choice = -1;
    }
    switch (choice) {
      case 1:
        // get all product 
        pdtMan.getAllProduct();
        break;
      case 2:
        // get one product 
        stdout.write("Enter product Id: ");
        var id = int.tryParse(stdin.readLineSync()!);
        if (id == null) {
          id = -1;
        }
        print(pdtMan.getOneProduct(id));
        break;
      case 3:
        // add new product 
        stdout.write("Enter product name: ");
        String Name = stdin.readLineSync()!;

        stdout.write("Enter product Price: ");
        var Price = int.tryParse(stdin.readLineSync()!);

        stdout.write("Enter product Descripton(optional): ");
        var Description = stdin.readLineSync() ?? "";

         // price and name are mandatory!!!!
        if (Price == null || Name == "") {
          print("product name and price can not be null");
        } else {
          var item = Product(Name, Price, description: Description);
          pdtMan.addProduct(item);
        }
        break;
      case 4:
        // edit product with input id
        stdout.write("Enter product Id: ");
        var id = int.tryParse(stdin.readLineSync()!);
        // handle null id exception
        if (id == null) {
          print("integer id  must be specified");
        } else {
          pdtMan.getOneProduct(id);
          print("here is your old product what you wanna edit");
          var item = pdtMan.getOneProduct(id);
          // print the old product 
          print(item);
          stdout.write("Enter new product name(optional): ");
          String Name = stdin.readLineSync() ?? item.name;

          stdout.write("Enter new product price(optional): ");
          var price = stdin.readLineSync() ?? item.price;
          var Price = int.parse(price);

          stdout.write("Enter new product desription(optional): ");
          var Description = stdin.readLineSync() ?? item.description;

          pdtMan.editProduct(id,
              name: Name, price: Price, description: Description);
        }
        break;
      case 5:
        stdout.write("Enter product Id: ");
        var productId = int.tryParse(stdin.readLineSync()!);
        if (productId == null) {
          print("invalid id,Try again");
          productId = -1;
        }
        pdtMan.deleteProduct(productId);
        break;

      default:
        choice = -1;
        print("Invalid input, try again");
        havetodo = false;
        break;
    }
  }
}
