import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllBooksScreen extends StatelessWidget {
  final String category;
  
  const AllBooksScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF6B7280),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _getCategoryTitle(category),
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Color(0xFF6B7280),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            
            // Books Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _getBooks(category).length,                  itemBuilder: (context, index) {
                    final book = _getBooks(category)[index];
                    return _buildBookCard(context, book);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryTitle(String category) {
    switch (category) {
      case 'class-xi':
        return 'Class XI Books';
      case 'recommended':
        return 'Recommended Books';
      default:
        return 'All Books';
    }
  }

  List<Map<String, String>> _getBooks(String category) {
    switch (category) {
      case 'class-xi':
        return [
          {'title': 'Geografi Kelas XI', 'author': 'Erlangga'},
          {'title': 'Fisika Kelas XI', 'author': 'Erlangga'},
          {'title': 'Kimia Kelas 11', 'author': 'Erlangga'},
          {'title': 'Matematika XI', 'author': 'Erlangga'},
          {'title': 'Biologi Kelas XI', 'author': 'Erlangga'},
          {'title': 'Bahasa Indonesia XI', 'author': 'Erlangga'},
          {'title': 'Sejarah Kelas XI', 'author': 'Erlangga'},
          {'title': 'Ekonomi Kelas XI', 'author': 'Erlangga'},
          {'title': 'Sosiologi Kelas XI', 'author': 'Erlangga'},
          {'title': 'PKN Kelas XI', 'author': 'Erlangga'},
        ];
      case 'recommended':
        return [
          {'title': 'The Midnight Library', 'author': 'Matt Haig'},
          {'title': 'Project Hail Mary', 'author': 'Andy Weir'},
          {'title': 'Atomic Habits', 'author': 'James Clear'},
          {'title': 'The Seven Husbands of Evelyn Hugo', 'author': 'Taylor Jenkins Reid'},
          {'title': 'Where the Crawdads Sing', 'author': 'Delia Owens'},
          {'title': 'The Silent Patient', 'author': 'Alex Michaelides'},
          {'title': 'Educated', 'author': 'Tara Westover'},
          {'title': 'The Invisible Man', 'author': 'H.G. Wells'},
          {'title': '1984', 'author': 'George Orwell'},
          {'title': 'To Kill a Mockingbird', 'author': 'Harper Lee'},
          {'title': 'Pride and Prejudice', 'author': 'Jane Austen'},
          {'title': 'The Great Gatsby', 'author': 'F. Scott Fitzgerald'},
        ];
      default:
        return [];
    }
  }  Widget _buildBookCard(BuildContext context, Map<String, String> book) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'book-detail',
          pathParameters: {
            'title': Uri.encodeComponent(book['title']!),
            'author': Uri.encodeComponent(book['author']!),
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://picsum.photos/200/280?random=${book['title'].hashCode}",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF3F4F6),
                          child: const Center(
                            child: Icon(
                              Icons.book,
                              size: 48,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book['title']!,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            book['author']!,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.12,
            ),
          ),
        ],
      ),
    );
  }
}
