class Product {
  static const NAME_KEY = 'name';
  static const IMAGEURL_KEY = 'imageUrl';

  String id;
  String name;
  String imageUrl;
  int amount;
  Product.create(this.name);

  //overriding the comparing, comparing if the type product is product then name and id
  @override
  bool operator ==(o) => o is Product && o.name == name && o.id == id;
  //type always override hashcode
  @override
  int get hashCode => name.hashCode;

  Product.fromFirestore(Map<String, dynamic> json) {
    name = json[NAME_KEY];
    imageUrl = json[IMAGEURL_KEY];
    // id = json['id'];
    // amount = json['amount'];
  }
}
