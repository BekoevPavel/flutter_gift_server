import 'package:postgres/postgres.dart';

class WishYouEntity {
  String wishyou;
  DateTime date;
  late Map<String, dynamic> wishMap;

  WishYouEntity({required this.wishyou, required this.date}) {
    wishMap = {
      'wishyou': wishyou,
      'date': date.toString(),
    };
  }

  factory WishYouEntity.fromJson(Map<String, dynamic> json) {
    return WishYouEntity(
        wishyou: json['wishyou'], date: DateTime.parse(json['date']));
  }

  Map<String, dynamic> toJson() {
    return {
      'wishyou': wishyou,
      'date': date.toString(),
    };
  }
}
