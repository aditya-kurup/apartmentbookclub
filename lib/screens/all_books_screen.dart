import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/database_service.dart';
import '../services/auth_service.dart';
import '../models/book.dart' as models;

class AllBooksScreen extends StatefulWidget {
  final String category;
  
  const AllBooksScreen({super.key, required this.category});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  List<models.Book> _books = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }
  Future<void> _loadBooks() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Get current user's apartment ID
      final currentUserId = AuthService.currentUserId;
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }

      final currentUser = await DatabaseService.getUserProfile(currentUserId);
      if (currentUser == null || currentUser.apartmentId == null) {
        throw Exception('User apartment not found');
      }

      List<models.Book> books;
      
      if (widget.category == 'all') {
        // Get all books from user's apartment
        books = await DatabaseService.getBooksByApartment(currentUser.apartmentId!);
      } else {
        // Get books by category from user's apartment only
        final allApartmentBooks = await DatabaseService.getBooksByApartment(currentUser.apartmentId!);
        books = allApartmentBooks.where((book) => 
          book.category.toLowerCase() == widget.category.toLowerCase() ||
          widget.category == 'class-xi' && (
            book.category.toLowerCase().contains('class') ||
            book.category.toLowerCase().contains('education') ||
            book.category.toLowerCase().contains('textbook')
          ) ||
          widget.category == 'recommended' && book.rating >= 4.0
        ).toList();
      }

      setState(() {
        _books = books;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }
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
                      _getCategoryTitle(widget.category),
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
            
            // Content area (loading, error, or books grid)
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load books',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadBooks,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_books.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_outlined,
              size: 64,
              color: Color(0xFF9CA3AF),
            ),
            SizedBox(height: 16),
            Text(
              'No books found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try a different category or check back later.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _books.length,
        itemBuilder: (context, index) {
          final book = _books[index];
          return _buildBookCard(context, book);
        },
      ),
    );
  }
  String _getCategoryTitle(String category) {
    switch (category) {
      case 'Educational':
      case 'class-xi':
        return 'Educational Books';
      case 'Fiction':
      case 'recommended':
        return 'Fiction Books';
      case 'Non-Fiction':
        return 'Non-Fiction Books';
      case 'Biography':
        return 'Biography Books';
      case 'Science':
        return 'Science Books';
      case 'History':
        return 'History Books';
      case 'all':
        return 'All Books';
      default:
        return '${category} Books';
    }
  }

  Widget _buildBookCard(BuildContext context, models.Book book) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'book-detail',
          pathParameters: {
            'title': Uri.encodeComponent(book.title),
            'author': Uri.encodeComponent(book.author),
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
                    child: book.coverUrl.isNotEmpty
                        ? Image.network(
                            book.coverUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildFallbackBookCover(book.title);
                            },
                          )
                        : _buildFallbackBookCover(book.title),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.title,
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
            book.author,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.12,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.star,
                color: const Color(0xFFFBBF24),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                book.rating.toString(),
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: book.isAvailable 
                      ? const Color(0xFFDCFCE7) 
                      : const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  book.isAvailable ? 'Available' : 'Borrowed',
                  style: TextStyle(
                    color: book.isAvailable 
                        ? const Color(0xFF059669) 
                        : const Color(0xFFDC2626),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackBookCover(String title) {
    return Container(
      color: const Color(0xFFF3F4F6),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.book,
              size: 32,
              color: Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
