class Booking {
  final String? id;
  final String title;
  final String image;
  final String description;
  final int price;
  final DateTime? bookingDate;
  final String? user;
  final String category;

  Booking({
    this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    this.bookingDate,
    this.user,
    required this.category,
  });

  Booking copyWith({
    String? id,
    String? title,
    String? image,
    String? description,
    int? price,
    DateTime? bookingDate,
    String? user,
    String? category,
  }) {
    return Booking(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      bookingDate: bookingDate ?? this.bookingDate,
      user: user ?? this.user,
      category: category ?? this.category,
    );
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'] as String?,
      title: json['title'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      bookingDate: json['bookingDate'] != null ? DateTime.parse(json['bookingDate']).toUtc() : null,
      user: json['user'] is Map<String, dynamic> ? json['user']['_id'] as String : json['user'] as String?,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'image': image,
      'description': description,
      'price': price,
      'bookingDate': bookingDate?.toUtc().toIso8601String(),
      'user': user,
      'category': category,
    };
  }
}