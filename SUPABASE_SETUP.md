# Supabase Integration Setup

Your Flutter app is now configured to work with Supabase! Here's what you need to do to complete the setup:

## 1. Get Your Supabase Credentials

1. Go to your [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project
3. Go to Settings > API
4. Copy the following values:
   - **Project URL** (looks like: `https://your-project-id.supabase.co`)
   - **anon public key** (starts with `eyJ...`)

## 2. Update Configuration

Open `lib/config/supabase_config.dart` and replace the placeholder values:

```dart
static const String supabaseUrl = 'https://your-actual-project-id.supabase.co';
static const String supabaseAnonKey = 'your-actual-anon-key-here';
```

## 3. Using Supabase in Your App

Now you can use Supabase throughout your app:

```dart
import 'package:apartment_book_club/services/supabase_service.dart';

// Example usage:
final supabase = SupabaseService.client;

// Query data
final response = await supabase.from('your_table').select();

// Insert data
await supabase.from('your_table').insert({'column': 'value'});

// Authentication
await supabase.auth.signUp(email: email, password: password);
```

## 4. Security Note

For production apps, consider using environment variables instead of hardcoding credentials in the config file.

## Files Added/Modified

- ✅ `pubspec.yaml` - Added supabase_flutter dependency
- ✅ `lib/services/supabase_service.dart` - Supabase service wrapper
- ✅ `lib/config/supabase_config.dart` - Configuration file (update with your credentials)
- ✅ `lib/main.dart` - Initialize Supabase on app startup

Your app is ready to connect to Supabase once you update the credentials!
