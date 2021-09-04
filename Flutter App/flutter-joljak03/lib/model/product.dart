//pie chart model
class ProductAmp {
  String? name;
  double? amp;

  ProductAmp(String name, double amp) {
    this.name = name;
    this.amp = amp;
  }
}

//Store info model
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

class ProductSmartPlug1 {
  String? datetime;
  double? amp;

  ProductSmartPlug1(String datetime, double amp) {
    this.datetime = datetime;
    this.amp = amp;
  }
}

class ProductSmartPlug {
  int year = 2020;
  int month = 7;
  int day = 1;
  double amp = 0.0;
  ProductSmartPlug(int year, int month, int day, double amp) {
    this.year = year;
    this.month = month;
    this.day = day;
    this.amp = amp;
  }
}
