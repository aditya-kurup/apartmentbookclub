// Test Supabase Connection
// Run this in your Flutter app to test if Supabase is working

import 'package:flutter/material.dart';
import '../services/database_service.dart';

class SupabaseTestWidget extends StatefulWidget {
  @override
  _SupabaseTestWidgetState createState() => _SupabaseTestWidgetState();
}

class _SupabaseTestWidgetState extends State<SupabaseTestWidget> {
  String _status = 'Testing connection...';
  
  @override
  void initState() {
    super.initState();
    _testConnection();
  }
  
  Future<void> _testConnection() async {
    try {
      // Try to fetch books from database
      final books = await DatabaseService.getAllBooks();
      setState(() {
        _status = 'Success! Found ${books.length} books in database.';
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Supabase Test')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Supabase Connection Test',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                _status,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _testConnection,
                child: Text('Test Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
