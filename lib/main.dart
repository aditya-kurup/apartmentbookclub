import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'router.dart';
import 'config/app_theme.dart';
import 'config/supabase_config.dart';
import 'services/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseService.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );
  
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp.router(
      title: 'Bookly',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
