import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;

  const CustomSearchBar({
    super.key,
    required this.onSearchChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onSearchChanged,
      decoration: InputDecoration(
        hintText: 'Search books, authors, genres...',
        prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: AppTheme.textSecondary),
                onPressed: () {
                  _controller.clear();
                  widget.onSearchChanged('');
                },
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
