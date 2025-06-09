import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/database_service.dart';
import '../services/auth_service.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<Map<String, dynamic>> borrowedBooks = [];
  List<Map<String, dynamic>> lendingBooks = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLibraryData();
  }
  Future<void> _loadLibraryData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      // Get current authenticated user ID
      final currentUserId = AuthService.currentUserId;
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }
      
      // Fetch detailed borrow requests for current user as borrower
      final borrowRequestsData = await DatabaseService.getBorrowRequestsWithDetailsForBorrower(currentUserId);
      
      // Fetch detailed borrow requests for current user as lender
      final lendRequestsData = await DatabaseService.getBorrowRequestsWithDetailsForLender(currentUserId);
      
      // Convert borrow requests to UI format for borrowed books
      final borrowedBooksData = borrowRequestsData
          .map((request) => _convertBorrowRequestToBorrowedBook(request))
          .toList();
      
      // Convert lend requests to UI format for lending books
      final lendingBooksData = lendRequestsData
          .map((request) => _convertBorrowRequestToLendingBook(request))
          .toList();
      
      setState(() {
        borrowedBooks = borrowedBooksData;
        lendingBooks = lendingBooksData;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading library data: $e');
      setState(() {
        _errorMessage = 'Failed to load library data. Please try again.';
        _isLoading = false;
      });
      // Fallback to mock data in case of error
      _loadMockData();
    }
  }
  Map<String, dynamic> _convertBorrowRequestToBorrowedBook(Map<String, dynamic> requestData) {
    final approvedDate = requestData['approved_date'] != null 
        ? DateTime.parse(requestData['approved_date']) 
        : null;
    final lendingPeriodDays = requestData['lending_period_days'] ?? 14;
    final returnDate = approvedDate?.add(Duration(days: lendingPeriodDays));
    final daysLeft = returnDate?.difference(DateTime.now()).inDays ?? 0;
    
    final book = requestData['books'] ?? {};
    final lender = requestData['lender'] ?? {};
    
    return {
      'title': book['title'] ?? 'Unknown Title',
      'author': book['author'] ?? 'Unknown Author',
      'daysLeft': daysLeft,
      'borrowedFrom': _formatUserName(lender),
      'borrowDate': approvedDate?.toString().split(' ').first ?? '',
      'returnDate': returnDate?.toString().split(' ').first ?? '',
      'genre': book['category'] ?? 'Fiction',
      'image': book['cover_url'] ?? 'https://placehold.co/400x600/f093fb/ffffff?text=Book',
    };
  }

  Map<String, dynamic> _convertBorrowRequestToLendingBook(Map<String, dynamic> requestData) {
    final approvedDate = requestData['approved_date'] != null 
        ? DateTime.parse(requestData['approved_date']) 
        : null;
    final lendingPeriodDays = requestData['lending_period_days'] ?? 14;
    final returnDate = approvedDate?.add(Duration(days: lendingPeriodDays));
    
    final book = requestData['books'] ?? {};
    final borrower = requestData['borrower'] ?? {};
    
    return {
      'title': book['title'] ?? 'Unknown Title',
      'author': book['author'] ?? 'Unknown Author',
      'lentTo': _formatUserName(borrower),
      'lendDate': approvedDate?.toString().split(' ').first ?? '',
      'returnDate': returnDate?.toString().split(' ').first ?? '',
      'genre': book['category'] ?? 'Fiction',
      'image': book['cover_url'] ?? 'https://placehold.co/400x600/4facfe/ffffff?text=Book',
    };
  }
  String _formatUserName(Map<String, dynamic> user) {
    final username = user['username'] ?? 'Unknown User';
    return username;
  }

  void _loadMockData() {
    setState(() {
      borrowedBooks = [
        {
          "title": "The Midnight Library",
          "author": "Matt Haig",
          "daysLeft": 5,
          "borrowedFrom": "Sarah Johnson",
          "borrowDate": "May 15, 2025",
          "returnDate": "June 5, 2025",
          "genre": "Fiction",
          "image": "https://placehold.co/400x600/f093fb/ffffff?text=Fiction"
        },
        {
          "title": "Project Hail Mary",
          "author": "Andy Weir",
          "daysLeft": 12,
          "borrowedFrom": "Mike Chen",
          "borrowDate": "May 20, 2025",
          "returnDate": "June 12, 2025",
          "genre": "Science Fiction",
          "image": "https://placehold.co/400x600/43e97b/ffffff?text=Science+Fiction"
        },
        {
          "title": "Atomic Habits",
          "author": "James Clear",
          "daysLeft": 18,
          "borrowedFrom": "Emma Davis",
          "borrowDate": "May 25, 2025",
          "returnDate": "June 18, 2025",
          "genre": "Non-Fiction",
          "image": "https://placehold.co/400x600/43e97b/ffffff?text=Non-Fiction"
        },
      ];

      lendingBooks = [
        {
          "title": "Where the Crawdads Sing",
          "author": "Delia Owens",
          "lentTo": "Alex Rodriguez",
          "lendDate": "May 10, 2025",
          "returnDate": "June 10, 2025",
          "genre": "Fiction",
          "image": "https://placehold.co/400x600/f093fb/ffffff?text=Fiction"
        },
        {
          "title": "The Seven Husbands of Evelyn Hugo",
          "author": "Taylor Jenkins Reid",
          "lentTo": "Jessica Kim",
          "lendDate": "May 18, 2025",
          "returnDate": "June 15, 2025",
          "genre": "Romance",
          "image": "https://placehold.co/400x600/4facfe/ffffff?text=Romance"
        },
      ];
      _isLoading = false;
    });
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                ),
              )
            : _errorMessage != null
                ? _buildErrorState()
                : _buildContent(),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFF6B7280),
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to Load Library',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Something went wrong',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadLibraryData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
          child: Column(
            children: [
              // Header matching home page style
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Library',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.24,
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

              // Statistics Banner (similar to hero banner in home)
              Container(
                width: double.infinity,
                height: 120,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Books Borrowed', '${borrowedBooks.length}'),
                      Container(width: 1, height: 40, color: const Color(0xFFE5E7EB)),
                      _buildStatItem('Books Lending', '${lendingBooks.length}'),
                      Container(width: 1, height: 40, color: const Color(0xFFE5E7EB)),
                      _buildStatItem('Total Exchanges', '${borrowedBooks.length + lendingBooks.length}'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Borrowed Books Section
              if (borrowedBooks.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Borrowed Books',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 285, // Fixed height to prevent overflow
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: borrowedBooks
                        .map((book) => _buildBorrowedBookCard(book))
                        .expand((widget) => [widget, const SizedBox(width: 12)])
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),
              ] else ...[
                _buildEmptyState('Borrowed Books', 'No books borrowed yet', Icons.book_outlined),
                const SizedBox(height: 24),
              ],

              // Lending Books Section
              if (lendingBooks.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Lending Books',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 285, // Fixed height to prevent overflow
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: lendingBooks
                        .map((book) => _buildLendingBookCard(book))
                        .expand((widget) => [widget, const SizedBox(width: 12)])
                        .toList(),
                  ),
                ),              ] else ...[
                _buildEmptyState('Lending Books', 'No books being lent yet', Icons.share_outlined),
              ],

              // Bottom padding for navigation bar
              const SizedBox(height: 100),
            ],
          ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6B7280),
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBorrowedBookCard(Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'borrowed-book-detail',
          pathParameters: {'title': book['title']},
          extra: book,
        );
      },
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 190, // Consistent with book card height
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _getGenreColor(book['genre']),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.book,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          book['genre'],
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: book['daysLeft'] <= 7 ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${book['daysLeft']}d',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book['title'],
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2), // Consistent reduced spacing
            Text(
              book['author'],
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildLendingBookCard(Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'lending-book-detail',
          pathParameters: {'title': book['title']},
          extra: book,
        );
      },
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 190, // Consistent height
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _getGenreColor(book['genre']),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.book,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          book['genre'],
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981), // Green for lending
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book['title'],
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              book['author'],
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Lent to: ${book['lentTo']}',
              style: const TextStyle(
                color: Color(0xFF10B981),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Color _getGenreColor(String genre) {
    switch (genre) {
      case 'Mystery':
        return const Color(0xFF667eea);
      case 'Fiction':
        return const Color(0xFFf093fb);
      case 'Romance':
        return const Color(0xFF4facfe);
      case 'Science':
      case 'Science Fiction':
        return const Color(0xFF43e97b);
      case 'Non-Fiction':
        return const Color(0xFF38f9d7);
      default:
        return const Color(0xFF6B7280);
    }
  }
}
