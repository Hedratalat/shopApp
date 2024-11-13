class FavoritesModel {
  late bool status;
  String? message;
  FavData? data;

  FavoritesModel({required this.status, this.message, this.data});

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    message = json['message'];
    data = json['data'] != null ? FavData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class FavData {
  late int currentPage;
  List<DataItem> data = [];
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  String? nextPageUrl;
  late String path;
  late int perPage;
  String? prevPageUrl;
  late int to;
  late int total;

  FavData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  FavData.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        data = (json['data'] as List<dynamic>?)
            ?.map((v) => DataItem.fromJson(v))
            .toList() ??
            [],
        firstPageUrl = json['first_page_url'],
        from = json['from'],
        lastPage = json['last_page'],
        lastPageUrl = json['last_page_url'],
        nextPageUrl = json['next_page_url'],
        path = json['path'],
        perPage = json['per_page'],
        prevPageUrl = json['prev_page_url'],
        to = json['to'],
        total = json['total'];

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data.map((v) => v.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class DataItem {
  late int id;
  Product? product;

  DataItem({required this.id, this.product});

  DataItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        product = json['product'] != null ? Product.fromJson(json['product']) : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (product != null) 'product': product!.toJson(),
    };
  }
}

class Product {
  late int id;
  late int price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        image = json['image'],
        name = json['name'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
    };
  }
}
