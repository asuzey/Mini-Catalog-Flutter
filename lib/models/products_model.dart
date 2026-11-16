// api den gelen cevabin tamami status meta data
class ProductsModel {
  String? status;
  Meta? meta;
  List<Data>? data;

  ProductsModel({this.status, this.meta, this.data});

  // json dan dart a donusum
  ProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  // dart tan json a donusum
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    if (meta != null) {
      json['meta'] = meta!.toJson();
    }
    if (data != null) {
      json['data'] = data!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

// meta bilgileri
class Meta {
  String? title;
  String? description;
  String? copyright;
  String? generated;
  int? count;

  Meta({
    this.title,
    this.description,
    this.copyright,
    this.generated,
    this.count,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    copyright = json['copyright'];
    generated = json['generated'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'copyright': copyright,
      'generated': generated,
      'count': count,
    };
  }
}

// tek bir urun burada icerik tanimlamasi yaptik
class Data {
  int? id;
  String? name;
  String? tagline;
  String? description;
  // fiyat string geliyor
  String? price;
  String? currency;
  String? image;
  Map<String, dynamic>? specs;

  Data({
    this.id,
    this.name,
    this.tagline,
    this.description,
    this.price,
    this.currency,
    this.image,
    this.specs,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagline = json['tagline'];
    description = json['description'];
    price = json['price'];
    currency = json['currency'];
    image = json['image'];
    // specs icin class yazmadik map kullandik
    specs = json['specs'] != null
        ? Map<String, dynamic>.from(json['specs'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': price,
      'currency': currency,
      'image': image,
      'specs': specs,
    };
  }
}
