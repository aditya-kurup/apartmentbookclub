class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final String category;
  final double rating;
  final int pages;
  final String isbn;
  final DateTime publishedDate;
  final bool isAvailable;
  final bool isFeatured;
  final bool isNewArrival;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.category,
    required this.rating,
    required this.pages,
    required this.isbn,
    required this.publishedDate,
    this.isAvailable = true,
    this.isFeatured = false,
    this.isNewArrival = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      coverUrl: json['coverUrl'] ?? '',
      category: json['category'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      pages: json['pages'] ?? 0,
      isbn: json['isbn'] ?? '',
      publishedDate: DateTime.parse(json['publishedDate'] ?? DateTime.now().toIso8601String()),
      isAvailable: json['isAvailable'] ?? true,
      isFeatured: json['isFeatured'] ?? false,
      isNewArrival: json['isNewArrival'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverUrl': coverUrl,
      'category': category,
      'rating': rating,
      'pages': pages,
      'isbn': isbn,
      'publishedDate': publishedDate.toIso8601String(),
      'isAvailable': isAvailable,
      'isFeatured': isFeatured,
      'isNewArrival': isNewArrival,
    };
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String apartmentNumber;
  final String profileImageUrl;
  final List<String> favoriteBooks;
  final List<String> readBooks;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.apartmentNumber,
    this.profileImageUrl = '',
    this.favoriteBooks = const [],
    this.readBooks = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      apartmentNumber: json['apartmentNumber'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      favoriteBooks: List<String>.from(json['favoriteBooks'] ?? []),
      readBooks: List<String>.from(json['readBooks'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'apartmentNumber': apartmentNumber,
      'profileImageUrl': profileImageUrl,
      'favoriteBooks': favoriteBooks,
      'readBooks': readBooks,
    };
  }
}
