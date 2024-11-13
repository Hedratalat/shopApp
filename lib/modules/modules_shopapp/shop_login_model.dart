class ShopLoginModel {
  bool status;
  String message;
  UserDate? date;

  ShopLoginModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] ?? false, // توفير قيمة افتراضية
        message = json['message'] ?? '',   // توفير قيمة افتراضية
        date = json['data'] != null ? UserDate.fromJson(json['data']) : null;
}

class UserDate {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserDate.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? 'Unknown';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    image = json['image'] ?? '';
    points = json['points'] ?? 0;
    credit = json['credit'] ?? 0;
    token = json['token'] ?? '';
  }
}
