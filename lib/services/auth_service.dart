import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/book.dart' as models;
import 'database_service.dart';

class AuthService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  /// Get current user
  static User? get currentUser => _supabase.auth.currentUser;

  /// Check if user is signed in
  static bool get isSignedIn => currentUser != null;

  /// Get current user ID
  static String? get currentUserId => currentUser?.id;
  /// Sign up with email and password
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required String username,
    required String phoneNumber,
    required String address,
    required String flatNo,
    required String apartmentId,
    bool? skipEmailConfirmation,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'username': username,
        },
        emailRedirectTo: skipEmailConfirmation == true ? null : null,
      );

      // If signup successful, create user details record
      if (response.user != null) {        final userDetails = models.UserDetails(
          id: response.user!.id,
          username: username,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
          flatNo: flatNo,
          apartmentId: apartmentId,
          status: 'active',
          profileImageUrl: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // Create user details record
        await DatabaseService.upsertUserProfile(userDetails);        // Create profile record
        final profile = models.Profile(
          userId: response.user!.id,
          booksRead: 0,
          favoriteGenre: '',
          booksBorrowed: 0,
          booksLent: 0,
          favoriteBooks: [],
          readBooks: [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await DatabaseService.createProfile(profile);
      }

      return response;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  /// Sign in with email and password
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  /// Sign out
  static Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  /// Reset password
  static Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  /// Get current user details from database
  static Future<models.UserDetails?> getCurrentUserDetails() async {
    if (!isSignedIn) return null;
    
    try {
      return await DatabaseService.getUserProfile(currentUserId!);
    } catch (e) {
      return null;
    }
  }

  /// Listen to auth state changes
  static Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Check if email is confirmed
  static bool get isEmailConfirmed => currentUser?.emailConfirmedAt != null;
  /// Resend confirmation email
  static Future<void> resendConfirmation(String email) async {
    try {
      await _supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
    } catch (e) {
      throw Exception('Failed to resend confirmation: $e');
    }
  }

  /// Check and update email confirmation status
  static Future<bool> checkEmailConfirmationStatus() async {
    try {
      // Refresh the current session to get latest user data
      await _supabase.auth.refreshSession();
      return isEmailConfirmed;
    } catch (e) {
      return false;
    }
  }

  /// For development: Skip email confirmation requirement
  static bool get isDevelopmentMode => const bool.fromEnvironment('DEVELOPMENT_MODE', defaultValue: true);
  
  /// Check if email confirmation should be enforced
  static bool get shouldEnforceEmailConfirmation => !isDevelopmentMode;
}
