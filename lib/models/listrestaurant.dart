class Restaurant {
  bool error;
  String message;
  int count;
  List<Restaurants> restaurants;

  Restaurant(
      {required this.error,
      required this.message,
      required this.count,
      required this.restaurants});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        error: json['error'],
        message: json['message'],
        count: json['count'],
        restaurants:
            List<Restaurants>.from(json["restaurants"].map((restaurant) {
          return Restaurants.fromJson(restaurant);
        })));
  }
}

class Restaurants {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

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
        rating: json['rating']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['pictureId'] = this.pictureId;
    data['city'] = this.city;
    data['rating'] = this.rating;
    return data;
  }
}
