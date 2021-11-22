class ListResponse {
  bool error;
  String message;
  int count;
  List<Restaurants> restaurants;

  ListResponse(
      {required this.error,
      required this.message,
      required this.count,
      required this.restaurants});

  factory ListResponse.fromJson(Map<String, dynamic> json) {
    return ListResponse(
        error: json['error'],
        message: json['message'],
        count: json['count'],
        restaurants:
            List<Restaurants>.from(json["restaurants"].map((restaurant) {
          return Restaurants.fromJson(restaurant);
        })));
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurants {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  num rating;

  Restaurants(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating});

  factory Restaurants.fromJson(Map<String, dynamic> json) {
    return Restaurants(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'].toDouble());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['pictureId'] = this.pictureId;
    data['city'] = this.city;
    data['rating'] = this.rating.toDouble();
    return data;
  }
}
