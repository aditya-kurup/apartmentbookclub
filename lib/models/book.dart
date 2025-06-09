class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final String category;
  final double rating;
  final int pages;
  final String? isbn;
  final DateTime publishedDate;
  final String? publisher;
  final int maxLendingDays;
  final bool isAvailable;
  final bool isFeatured;
  final bool isNewArrival;
  final String? lenderId;
  final String? apartmentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.category,
    required this.rating,
    required this.pages,
    this.isbn,
    required this.publishedDate,
    this.publisher,
    this.maxLendingDays = 14,
    this.isAvailable = true,
    this.isFeatured = false,
    this.isNewArrival = false,
    this.lenderId,
    this.apartmentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      category: json['category'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      pages: json['pages'] ?? 0,
      isbn: json['isbn'],
      publishedDate: json['published_date'] != null 
          ? DateTime.parse(json['published_date']) 
          : DateTime.now(),
      publisher: json['publisher'],
      maxLendingDays: json['max_lending_days'] ?? 14,
      isAvailable: json['is_available'] ?? true,
      isFeatured: json['is_featured'] ?? false,
      isNewArrival: json['is_new_arrival'] ?? false,
      lenderId: json['lender_id'],
      apartmentId: json['apartment_id'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'cover_url': coverUrl,
      'category': category,
      'rating': rating,
      'pages': pages,
      'isbn': isbn,
      'published_date': publishedDate.toIso8601String().split('T')[0], // Date only
      'publisher': publisher,
      'max_lending_days': maxLendingDays,
      'is_available': isAvailable,
      'is_featured': isFeatured,
      'is_new_arrival': isNewArrival,
      'lender_id': lenderId,
      'apartment_id': apartmentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class UserDetails {
  final String id;
  final String username;
  final String email;
  final String? phoneNumber;
  final String? address;
  final String? flatNo;
  final String? apartmentId;
  final String status;
  final String profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserDetails({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.address,
    this.flatNo,
    this.apartmentId,
    this.status = 'active',
    this.profileImageUrl = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      address: json['address'],
      flatNo: json['flat_no'],
      apartmentId: json['apartment_id'],
      status: json['status'] ?? 'active',
      profileImageUrl: json['profile_image_url'] ?? '',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'flat_no': flatNo,
      'apartment_id': apartmentId,
      'status': status,
      'profile_image_url': profileImageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Profile {
  final String userId;
  final int booksRead;
  final String? favoriteGenre;
  final int booksBorrowed;
  final int booksLent;
  final List<String> favoriteBooks;
  final List<String> readBooks;
  final DateTime createdAt;
  final DateTime updatedAt;

  Profile({
    required this.userId,
    this.booksRead = 0,
    this.favoriteGenre,
    this.booksBorrowed = 0,
    this.booksLent = 0,
    this.favoriteBooks = const [],
    this.readBooks = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['user_id'] ?? '',
      booksRead: json['books_read'] ?? 0,
      favoriteGenre: json['favorite_genre'],
      booksBorrowed: json['books_borrowed'] ?? 0,
      booksLent: json['books_lent'] ?? 0,
      favoriteBooks: List<String>.from(json['favorite_books'] ?? []),
      readBooks: List<String>.from(json['read_books'] ?? []),
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'books_read': booksRead,
      'favorite_genre': favoriteGenre,
      'books_borrowed': booksBorrowed,
      'books_lent': booksLent,
      'favorite_books': favoriteBooks,
      'read_books': readBooks,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Apartment {
  final String id;
  final String aptName;
  final int noOfBooks;
  final String? managerId;
  final int noOfReaders;
  final double? membershipCost;
  final String status;
  final String? address;
  final String? city;
  final DateTime createdAt;
  final DateTime updatedAt;

  Apartment({
    required this.id,
    required this.aptName,
    this.noOfBooks = 0,
    this.managerId,
    this.noOfReaders = 0,
    this.membershipCost,
    this.status = 'active',
    this.address,
    this.city,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      id: json['id'] ?? '',
      aptName: json['apt_name'] ?? '',
      noOfBooks: json['no_of_books'] ?? 0,
      managerId: json['manager'],
      noOfReaders: json['no_of_readers'] ?? 0,
      membershipCost: json['membership_cost']?.toDouble(),
      status: json['status'] ?? 'active',
      address: json['address'],
      city: json['city'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'apt_name': aptName,
      'no_of_books': noOfBooks,
      'manager': managerId,
      'no_of_readers': noOfReaders,
      'membership_cost': membershipCost,
      'status': status,
      'address': address,
      'city': city,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class BorrowRequest {
  final String id;
  final String bookId;
  final String borrowerId;
  final String lenderId;
  final DateTime requestDate;
  final DateTime? approvedDate;
  final DateTime? borrowedDate;
  final DateTime? dueDate;
  final DateTime? returnDate;
  final bool returned;
  final String status; // 'pending', 'approved', 'returned', 'declined', 'overdue'
  final int lendingPeriodDays;
  final int renewals;
  final int maxRenewals;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  BorrowRequest({
    required this.id,
    required this.bookId,
    required this.borrowerId,
    required this.lenderId,
    required this.requestDate,
    this.approvedDate,
    this.borrowedDate,
    this.dueDate,
    this.returnDate,
    this.returned = false,
    required this.status,
    this.lendingPeriodDays = 14,
    this.renewals = 0,
    this.maxRenewals = 2,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BorrowRequest.fromJson(Map<String, dynamic> json) {
    return BorrowRequest(
      id: json['id'] ?? '',
      bookId: json['book_id'] ?? '',
      borrowerId: json['borrower_id'] ?? '',
      lenderId: json['lender_id'] ?? '',
      requestDate: json['request_date'] != null 
          ? DateTime.parse(json['request_date']) 
          : DateTime.now(),
      approvedDate: json['approved_date'] != null 
          ? DateTime.parse(json['approved_date']) 
          : null,
      borrowedDate: json['borrowed_date'] != null 
          ? DateTime.parse(json['borrowed_date']) 
          : null,
      dueDate: json['due_date'] != null 
          ? DateTime.parse(json['due_date']) 
          : null,
      returnDate: json['return_date'] != null 
          ? DateTime.parse(json['return_date']) 
          : null,
      returned: json['returned'] ?? false,
      status: json['status'] ?? 'pending',
      lendingPeriodDays: json['lending_period_days'] ?? 14,
      renewals: json['renewals'] ?? 0,
      maxRenewals: json['max_renewals'] ?? 2,
      notes: json['notes'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_id': bookId,
      'borrower_id': borrowerId,
      'lender_id': lenderId,
      'request_date': requestDate.toIso8601String(),
      'approved_date': approvedDate?.toIso8601String(),
      'borrowed_date': borrowedDate?.toIso8601String(),
      'due_date': dueDate?.toIso8601String().split('T')[0], // Date only
      'return_date': returnDate?.toIso8601String(),
      'returned': returned,
      'status': status,
      'lending_period_days': lendingPeriodDays,
      'renewals': renewals,
      'max_renewals': maxRenewals,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class BookListing {
  final String id;
  final String bookId;
  final String ownerId;
  final bool isAvailable;
  final String condition;
  final String? location;
  final DateTime listedDate;
  final String? notes;

  BookListing({
    required this.id,
    required this.bookId,
    required this.ownerId,
    required this.isAvailable,
    required this.condition,
    this.location,
    required this.listedDate,
    this.notes,
  });

  factory BookListing.fromJson(Map<String, dynamic> json) {
    return BookListing(
      id: json['id'] ?? '',
      bookId: json['book_id'] ?? '',
      ownerId: json['owner_id'] ?? '',
      isAvailable: json['is_available'] ?? true,
      condition: json['condition'] ?? 'Good',
      location: json['location'],
      listedDate: DateTime.parse(json['listed_date'] ?? DateTime.now().toIso8601String()),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_id': bookId,
      'owner_id': ownerId,
      'is_available': isAvailable,
      'condition': condition,
      'location': location,
      'listed_date': listedDate.toIso8601String(),
      'notes': notes,
    };
  }
}

class BookReview {
  final String id;
  final String bookId;
  final String userId;
  final int rating;
  final String? reviewText;
  final int helpfulVotes;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookReview({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.rating,
    this.reviewText,
    this.helpfulVotes = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookReview.fromJson(Map<String, dynamic> json) {
    return BookReview(
      id: json['id'] ?? '',
      bookId: json['book_id'] ?? '',
      userId: json['user_id'] ?? '',
      rating: json['rating'] ?? 1,
      reviewText: json['review_text'],
      helpfulVotes: json['helpful_votes'] ?? 0,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_id': bookId,
      'user_id': userId,
      'rating': rating,
      'review_text': reviewText,
      'helpful_votes': helpfulVotes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Waitlist {
  final String id;
  final String userId;
  final String bookId;
  final int? priority;
  final String status; // 'waiting', 'notified', 'fulfilled', 'cancelled'
  final DateTime createdAt;
  final DateTime updatedAt;

  Waitlist({
    required this.id,
    required this.userId,
    required this.bookId,
    this.priority,
    this.status = 'waiting',
    required this.createdAt,
    required this.updatedAt,
  });

  factory Waitlist.fromJson(Map<String, dynamic> json) {
    return Waitlist(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      bookId: json['book_id'] ?? '',
      priority: json['priority'],
      status: json['status'] ?? 'waiting',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'book_id': bookId,
      'priority': priority,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Notification {
  final String id;
  final String userId;
  final String title;
  final String message;
  final String type; // 'info', 'success', 'warning', 'error', 'book_request', 'book_approved', 'book_due', 'book_returned'
  final bool isRead;
  final String? relatedId;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    this.type = 'info',
    this.isRead = false,
    this.relatedId,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'info',
      isRead: json['is_read'] ?? false,
      relatedId: json['related_id'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'message': message,
      'type': type,
      'is_read': isRead,
      'related_id': relatedId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ApartmentMembership {
  final String id;
  final String userId;
  final String apartmentId;
  final DateTime membershipDate;
  final double? amountPaid;
  final String paymentStatus; // 'pending', 'paid', 'overdue'
  final DateTime? validUntil;
  final DateTime createdAt;

  ApartmentMembership({
    required this.id,
    required this.userId,
    required this.apartmentId,
    required this.membershipDate,
    this.amountPaid,
    this.paymentStatus = 'pending',
    this.validUntil,
    required this.createdAt,
  });

  factory ApartmentMembership.fromJson(Map<String, dynamic> json) {
    return ApartmentMembership(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      apartmentId: json['apartment_id'] ?? '',
      membershipDate: json['membership_date'] != null 
          ? DateTime.parse(json['membership_date']) 
          : DateTime.now(),
      amountPaid: json['amount_paid']?.toDouble(),
      paymentStatus: json['payment_status'] ?? 'pending',
      validUntil: json['valid_until'] != null 
          ? DateTime.parse(json['valid_until']) 
          : null,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'apartment_id': apartmentId,
      'membership_date': membershipDate.toIso8601String(),
      'amount_paid': amountPaid,
      'payment_status': paymentStatus,
      'valid_until': validUntil?.toIso8601String().split('T')[0], // Date only
      'created_at': createdAt.toIso8601String(),
    };
  }
}
