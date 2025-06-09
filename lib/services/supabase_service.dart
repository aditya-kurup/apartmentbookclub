import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient? _instance;
  
  static SupabaseClient get instance {
    if (_instance == null) {
      throw Exception('Supabase not initialized. Call initialize() first.');
    }
    return _instance!;
  }
  
  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
    _instance = Supabase.instance.client;
  }
  
  // Getter for easy access throughout the app
  static SupabaseClient get client => Supabase.instance.client;
}
