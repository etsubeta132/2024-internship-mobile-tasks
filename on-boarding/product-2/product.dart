import 'status.dart';

class Product {
  static int _defaultId = 1;
  int id = 0;
  String? _name;
  String? _description;
  double? _price;
  Status _status = Status.PENDING;

  // getter for each field
  String get name => this._name!;
  double get price => this._price!;
  String get description => this._description ?? "";
  Status get status => this._status;

  // setter for each field
  set name(String value) {
    if (value == "") {
      throw ArgumentError('Name cannot be empty.');
    } else {
      _name = value;
    }
  }

  set price(double value) {
    try {
      
      if (value >= 0) {
        _price = value;
      } else {
        throw ArgumentError('price must be a number');
      }
    } catch (e) {
      throw ArgumentError('price must be a number');
    }
  }

  set status(Status status) {
    if (Status.values.contains(status)) {
      _status = status;
    } else {
      _status = Status.PENDING;
    }
  }

  set description(String value) {
    if (value == "") {
      _description = "";
    } else {
      _description = value;
    }
  }

  Product(String name, double price, {String description = ""}) {
  this.id = _defaultId;
  _defaultId++;
  this._name = name; 
  this._price = price; 
  this._description = description; 
}


}
