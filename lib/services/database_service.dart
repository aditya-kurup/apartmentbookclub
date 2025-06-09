import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/book.dart' as models;
import '../services/supabase_service.dart';

class DatabaseService {
  static final SupabaseClient _supabase = SupabaseService.client;

  // =============== BOOKS ===============
  
  /// Fetch all books from the database
  static Future<List<models.Book>> getAllBooks() async {
    try {
      final response = await _supabase
          .from('books')
          .select()
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((book) => models.Book.fromJson(book))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }

  /// Fetch books by apartment (for multi-apartment support)
  static Future<List<models.Book>> getBooksByApartment(String apartmentId) async {
    try {
      final response = await _supabase
          .from('books')
          .select()
          .eq('apartment_id', apartmentId)
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((book) => models.Book.fromJson(book))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch apartment books: $e');
    }
  }
  /// Fetch books by category
  static Future<List<models.Book>> getBooksByCategory(String category) async {
    try {
      final response = await _supabase
          .from('books')
          .select()
          .eq('category', category)
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((book) => models.Book.fromJson(book))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch books by category: $e');
    }
  }
  /// Search books by title or author
  static Future<List<models.Book>> searchBooks(String query) async {
    try {
      final response = await _supabase
          .from('books')
          .select()
          .or('title.ilike.%$query%,author.ilike.%$query%')
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((book) => models.Book.fromJson(book))
          .toList();
    } catch (e) {
      throw Exception('Failed to search books: $e');
    }
  }
  /// Add a new book to the database
  static Future<models.Book> addBook(models.Book book) async {
    try {
      final response = await _supabase
          .from('books')
          .insert(book.toJson())
          .select()
          .single();
      
      return models.Book.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add book: $e');
    }
  }

  /// Update book information
  static Future<models.Book> updateBook(models.Book book) async {
    try {
      final response = await _supabase
          .from('books')
          .update(book.toJson())
          .eq('id', book.id)
          .select()
          .single();
      
      return models.Book.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update book: $e');
    }
  }

  /// Delete a book from the database
  static Future<void> deleteBook(String bookId) async {
    try {
      await _supabase
          .from('books')
          .delete()
          .eq('id', bookId);
    } catch (e) {
      throw Exception('Failed to delete book: $e');
    }
  }

  // =============== BOOK LISTINGS ===============  /// Fetch available book listings
  static Future<List<models.BookListing>> getAvailableListings() async {
    try {
      final response = await _supabase
          .from('book_listings')
          .select('*, books(*), user_details!owner_id(*)')
          .eq('is_available', true)
          .order('listed_date', ascending: false);
        return (response as List)
          .map((listing) => models.BookListing.fromJson(listing))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch book listings: $e');
    }
  }

  /// Fetch listings by owner
  static Future<List<models.BookListing>> getListingsByOwner(String ownerId) async {
    try {
      final response = await _supabase
          .from('book_listings')
          .select('*, books(*)')
          .eq('owner_id', ownerId)
          .order('listed_date', ascending: false);
      
      return (response as List)
          .map((listing) => models.BookListing.fromJson(listing))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch owner listings: $e');
    }
  }

  /// Add a new book listing
  static Future<models.BookListing> addBookListing(models.BookListing listing) async {
    try {
      final response = await _supabase
          .from('book_listings')
          .insert(listing.toJson())
          .select()
          .single();
      
      return models.BookListing.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add book listing: $e');
    }
  }

  /// Update book listing availability
  static Future<void> updateListingAvailability(String listingId, bool isAvailable) async {
    try {
      await _supabase
          .from('book_listings')
          .update({'is_available': isAvailable})
          .eq('id', listingId);
    } catch (e) {
      throw Exception('Failed to update listing availability: $e');
    }
  }

  // =============== BORROW REQUESTS ===============
  
  /// Create a new borrow request
  static Future<models.BorrowRequest> createBorrowRequest(models.BorrowRequest request) async {
    try {
      final response = await _supabase
          .from('borrow_requests')
          .insert(request.toJson())
          .select()
          .single();
      
      return models.BorrowRequest.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create borrow request: $e');
    }
  }
  /// Fetch borrow requests for a user (as borrower)
  static Future<List<models.BorrowRequest>> getBorrowRequestsByBorrower(String borrowerId) async {
    try {
      final response = await _supabase
          .from('borrow_requests')
          .select('*, books(*), user_details!lender_id(*)')
          .eq('borrower_id', borrowerId)
          .order('request_date', ascending: false);
      
      return (response as List)
          .map((request) => models.BorrowRequest.fromJson(request))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch borrower requests: $e');
    }
  }

  /// Fetch borrow requests for a user (as lender)
  static Future<List<models.BorrowRequest>> getBorrowRequestsByLender(String lenderId) async {
    try {
      final response = await _supabase
          .from('borrow_requests')
          .select('*, books(*), user_details!borrower_id(*)')
          .eq('lender_id', lenderId)
          .order('request_date', ascending: false);
      
      return (response as List)
          .map((request) => models.BorrowRequest.fromJson(request))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch lender requests: $e');
    }
  }

  /// Update borrow request status
  static Future<models.BorrowRequest> updateBorrowRequestStatus(
    String requestId, 
    String status, 
    {DateTime? approvedDate, DateTime? returnDate}
  ) async {
    try {
      final updateData = <String, dynamic>{'status': status};
      if (approvedDate != null) updateData['approved_date'] = approvedDate.toIso8601String();
      if (returnDate != null) updateData['return_date'] = returnDate.toIso8601String();
      
      final response = await _supabase
          .from('borrow_requests')
          .update(updateData)
          .eq('id', requestId)
          .select()
          .single();
      
      return models.BorrowRequest.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update borrow request: $e');
    }
  }
  // =============== USER DETAILS ===============
  
  /// Get user profile
  static Future<models.UserDetails?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('user_details')
          .select()
          .eq('id', userId)
          .maybeSingle();
      
      if (response == null) return null;
      return models.UserDetails.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  /// Create or update user profile
  static Future<models.UserDetails> upsertUserProfile(models.UserDetails user) async {
    try {
      final response = await _supabase
          .from('user_details')
          .upsert(user.toJson())
          .select()
          .single();
      
      return models.UserDetails.fromJson(response);
    } catch (e) {
      throw Exception('Failed to upsert user profile: $e');
    }
  }
  /// Get all users in the apartment complex
  static Future<List<models.UserDetails>> getAllUsers() async {
    try {
      final response = await _supabase
          .from('user_details')
          .select()
          .order('username');
      
      return (response as List)
          .map((user) => models.UserDetails.fromJson(user))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  // =============== DASHBOARD DATA ===============
  
  /// Get dashboard statistics
  static Future<Map<String, int>> getDashboardStats(String userId) async {
    try {      // Get total books available
      final totalBooksResponse = await _supabase
          .from('book_listings')
          .select('id')
          .eq('is_available', true);      // Get user's active borrows
      final activeBorrowsResponse = await _supabase
          .from('borrow_requests')
          .select('id')
          .eq('borrower_id', userId)
          .eq('status', 'approved');

      // Get user's pending requests
      final pendingRequestsResponse = await _supabase
          .from('borrow_requests')
          .select('id')
          .eq('borrower_id', userId)
          .eq('status', 'pending');

      // Get user's books being lent
      final booksLentResponse = await _supabase
          .from('borrow_requests')
          .select('id')
          .eq('lender_id', userId)
          .eq('status', 'approved');

      return {
        'totalBooks': totalBooksResponse.length,
        'activeBorrows': activeBorrowsResponse.length,
        'pendingRequests': pendingRequestsResponse.length,
        'booksLent': booksLentResponse.length,
      };
    } catch (e) {
      throw Exception('Failed to fetch dashboard stats: $e');
    }
  }
  // =============== REAL-TIME SUBSCRIPTIONS ===============
  
  /// Subscribe to borrow request changes for a user
  static RealtimeChannel subscribeToBorrowRequests(String userId, Function(Map<String, dynamic>) onUpdate) {
    return _supabase
        .channel('borrow_requests_$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'borrow_requests',
          callback: (payload) => onUpdate(payload.newRecord),
        )
        .subscribe();
  }

  /// Subscribe to book listing changes
  static RealtimeChannel subscribeToBookListings(Function(Map<String, dynamic>) onUpdate) {
    return _supabase
        .channel('book_listings')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'book_listings',
          callback: (payload) => onUpdate(payload.newRecord),
        )
        .subscribe();
  }

  // =============== APARTMENTS ===============
  
  /// Get all apartments
  static Future<List<models.Apartment>> getAllApartments() async {
    try {
      final response = await _supabase
          .from('apartments')
          .select()
          .order('apt_name');
      
      return (response as List)
          .map((apartment) => models.Apartment.fromJson(apartment))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch apartments: $e');
    }
  }

  /// Get apartment by ID
  static Future<models.Apartment?> getApartment(String apartmentId) async {
    try {
      final response = await _supabase
          .from('apartments')
          .select()
          .eq('id', apartmentId)
          .maybeSingle();
      
      if (response == null) return null;
      return models.Apartment.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch apartment: $e');
    }
  }

  // =============== PROFILES ===============
  
  /// Get user profile data
  static Future<models.Profile?> getProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('user_id', userId)
          .maybeSingle();
      
      if (response == null) return null;
      return models.Profile.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  /// Create or update user profile data
  static Future<models.Profile> upsertProfile(models.Profile profile) async {
    try {
      final response = await _supabase
          .from('profiles')
          .upsert(profile.toJson())
          .select()
          .single();
      
      return models.Profile.fromJson(response);
    } catch (e) {
      throw Exception('Failed to upsert profile: $e');
    }
  }

  // =============== BOOK REVIEWS ===============
  
  /// Get reviews for a book
  static Future<List<models.BookReview>> getBookReviews(String bookId) async {
    try {
      final response = await _supabase
          .from('book_reviews')
          .select('*, user_details!user_id(*)')
          .eq('book_id', bookId)
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((review) => models.BookReview.fromJson(review))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch book reviews: $e');
    }
  }

  /// Add a book review
  static Future<models.BookReview> addBookReview(models.BookReview review) async {
    try {
      final response = await _supabase
          .from('book_reviews')
          .insert(review.toJson())
          .select()
          .single();
      
      return models.BookReview.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add book review: $e');
    }
  }

  // =============== WAITLIST ===============
  
  /// Get waitlist entries for a book
  static Future<List<models.Waitlist>> getBookWaitlist(String bookId) async {
    try {
      final response = await _supabase
          .from('waitlist')
          .select('*, user_details!user_id(*)')
          .eq('book_id', bookId)
          .eq('status', 'waiting')
          .order('priority');
      
      return (response as List)
          .map((waitlist) => models.Waitlist.fromJson(waitlist))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch book waitlist: $e');
    }
  }

  /// Add user to waitlist
  static Future<models.Waitlist> addToWaitlist(models.Waitlist waitlist) async {
    try {
      final response = await _supabase
          .from('waitlist')
          .insert(waitlist.toJson())
          .select()
          .single();
      
      return models.Waitlist.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add to waitlist: $e');
    }
  }

  // =============== NOTIFICATIONS ===============
  
  /// Get notifications for a user
  static Future<List<models.Notification>> getUserNotifications(String userId) async {
    try {
      final response = await _supabase
          .from('notifications')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((notification) => models.Notification.fromJson(notification))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }

  /// Add a notification
  static Future<models.Notification> addNotification(models.Notification notification) async {
    try {
      final response = await _supabase
          .from('notifications')
          .insert(notification.toJson())
          .select()
          .single();
      
      return models.Notification.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add notification: $e');
    }
  }

  /// Mark notification as read
  static Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('id', notificationId);
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }
}
