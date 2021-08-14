class Product {
  int? id;
  String? name;
  String? location;

  Product(int id, String name, String location) {
    this.id = id;
    this.name = name;
    this.location = location;
  }
}

class ProductAmp {
  String? name;
  double? amp;

  ProductAmp(String name, double amp) {
    this.name = name;
    this.amp = amp;
  }
}

class ProductStore {
  int? storeId;
  String? name;
  String? phone;
  String? location;

  ProductStore(int storeId, String name, String phone, String location) {
    this.storeId = storeId;
    this.name = name;
    this.phone = phone;
    this.location = location;
  }
}


