import 'dart:io';

import 'product_manager.dart';
import 'product.dart';
import 'status.dart';

void main() {
  var productManager = ProductManager(Store: {});
  print("Welcome Manager What you want to do today");
  print("");
  var menu = """
  1. View All Product               4, Edit Product           7, View Completed products            
  2. View One Product               5, Delete Product            other - Quite
  3. Add Product                    6, View pending products            
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
        print(productManager.getAllProduct());
        break;
      
      case 2:
        // get one product
        stdout.write("Enter product Id: ");
        var id = int.tryParse(stdin.readLineSync()!);
        if (id == null) {
          id = -1;
        }
        print(productManager.getOneProduct(id));
        break;
      
      case 3:
        // add new product
        stdout.write("Enter product name: ");
        String Name = stdin.readLineSync()!;

        stdout.write("Enter product Price: ");
        double? Price = double.tryParse(stdin.readLineSync()!);

        stdout.write("Enter product Descripton(optional): ");
        var Description = stdin.readLineSync();

        // price and name are mandatory!!!!
        if (Price == null || Name == "") {
          print("product name and price can not be null or invalid");
        } else {
          var item = Product(Name, Price, description: Description ?? "");
          productManager.addProduct(item);
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
          var item = productManager.getOneProduct(id);

          if (item.length == 0) {
            print("no product to update");
          } else {
            // print the old product
            print("here is your old product what you wanna edit");
            print(item);
            stdout.write("Enter new product name(optional): ");
            String Name = stdin.readLineSync() ?? "";

            stdout.write("Enter new product price(optional): ");
            String price = stdin.readLineSync() ?? '-1';
            double Price = double.tryParse(price) ?? -1;

            stdout.write("Enter new product status:(1.pending,2.completed): ");
            var input = stdin.readLineSync();
            var status;
            if (input == "1") {
              status = Status.PENDING;
            } else if (input == "2") {
              status = Status.COMPLETED;
            } else {
              status = item['status'];
            }

            stdout.write("Enter new product desription(optional): ");
            var Description = stdin.readLineSync() ?? item['description'];

            productManager.editProduct(id,
                name: Name,
                price: Price,
                description: Description,
                status: status);
          }
        }

        break;
      
      case 5:
        // delete product
        stdout.write("Enter product Id: ");
        var productId = int.tryParse(stdin.readLineSync()!);
        if (productId == null) {
          print("invalid id,Try again");
          productId = -1;
        }
        productManager.deleteProduct(productId);
        break;
      
      case 6:
        var pendingPoducts = productManager.getPendingProduct();
        if (pendingPoducts != null) {
          print(pendingPoducts);
        }
        break;

      
      case 7:
        var completedPoducts = productManager.getCompletedProduct();
        if (completedPoducts != null) {
          print(completedPoducts);
        }
        break;
      default:
        choice = -1;
        print("Invalid input, try again");
        havetodo = false;
        break;
    }
  }
}
