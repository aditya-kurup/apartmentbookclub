import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../services/database_service.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  int _currentBannerIndex = 0;
  Timer? _timer;
  List<Map<String, dynamic>> _classXIBooks = [];
  List<Map<String, dynamic>> _recommendedBooks = [];
  bool _isLoading = true;
  
  final List<Map<String, dynamic>> _banners = [
    {
      'title': 'Explore the world through books',
      'subtitle': 'Discover amazing stories in your community',
      'color': Color(0xFFF9FAFB),
      'textColor': Color(0xFF111827),
    },
    {
      'title': 'Share your favorite books',
      'subtitle': 'Lend and borrow with your neighbors',
      'color': Color(0xFFEEF2FF),
      'textColor': Color(0xFF4338CA),
    },
    {
      'title': 'Join book discussions',
      'subtitle': 'Connect with fellow book lovers',
      'color': Color(0xFFF0FDF4),
      'textColor': Color(0xFF15803D),
    },
  ];
  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _loadBooks();
    _searchController.addListener(() {
      setState(() {}); // Update UI when search text changes
    });
  }  Future<void> _loadBooks() async {
    try {
      // Get current user's apartment ID first
      final currentUserId = AuthService.currentUserId;
      if (currentUserId == null) {
        print('Error: No current user found');
        setState(() {
          _classXIBooks = _getMockClassXIBooks();
          _recommendedBooks = _getMockRecommendedBooks();
          _isLoading = false;
        });
        return;
      }

      final currentUser = await DatabaseService.getUserProfile(currentUserId);
      if (currentUser == null || currentUser.apartmentId == null) {
        print('Error: No user details or apartment ID found');
        setState(() {
          _classXIBooks = _getMockClassXIBooks();
          _recommendedBooks = _getMockRecommendedBooks();
          _isLoading = false;
        });
        return;
      }

      // Fetch books from current user's apartment only
      final allBooks = await DatabaseService.getBooksByApartment(currentUser.apartmentId!);
      
      // Convert Book objects to Map format for compatibility with existing UI
      final booksAsMap = allBooks.map((book) => {
        'id': book.id,
        'title': book.title,
        'author': book.author,
        'category': book.category,
        'coverUrl': book.coverUrl,
        'rating': book.rating.toString(),
        'isAvailable': book.isAvailable,
      }).toList();      // Filter books by category with proper null safety
      final classXI = booksAsMap.where((book) {
        final category = book['category']?.toString().toLowerCase() ?? '';
        return category.contains('class') ||
               category.contains('education') ||
               category.contains('textbook');
      }).toList();

      final recommended = booksAsMap.where((book) {
        final rating = book['rating']?.toString() ?? '0';
        final category = book['category']?.toString().toLowerCase() ?? '';
        return (double.tryParse(rating) != null && double.parse(rating) >= 4.0) ||
               category.contains('fiction') ||
               category.contains('popular');
      }).toList();

      print('DEBUG: Total apartment books found: ${booksAsMap.length}');
      print('DEBUG: Class XI books found: ${classXI.length}');
      print('DEBUG: Recommended books found: ${recommended.length}');      setState(() {
        // Show actual books from database, fallback to general books if no category matches
        _classXIBooks = classXI.isNotEmpty ? classXI : booksAsMap.take(5).toList();
        _recommendedBooks = recommended.isNotEmpty ? recommended : booksAsMap.skip(classXI.length).take(5).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading books: $e');
      // Only fall back to mock data if there's a real error
      setState(() {
        _classXIBooks = _getMockClassXIBooks();
        _recommendedBooks = _getMockRecommendedBooks();
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> _getMockClassXIBooks() {
    return [
      {'title': 'Geografi Kelas XI', 'author': 'Erlangga'},
      {'title': 'Fisika Kelas XI', 'author': 'Erlangga'},
      {'title': 'Kimia Kelas 11', 'author': 'Erlangga'},
      {'title': 'Biologi Kelas XI', 'author': 'Erlangga'},
      {'title': 'Matematika XI', 'author': 'Erlangga'},
    ];
  }

  List<Map<String, dynamic>> _getMockRecommendedBooks() {
    return [
      {'title': 'The Midnight Library', 'author': 'Matt Haig'},
      {'title': 'Project Hail Mary', 'author': 'Andy Weir'},
      {'title': 'Atomic Habits', 'author': 'James Clear'},
      {'title': 'The Seven Husbands of Evelyn Hugo', 'author': 'Taylor Jenkins Reid'},
    ];
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentBannerIndex < _banners.length - 1) {
        _currentBannerIndex++;
      } else {
        _currentBannerIndex = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.pushNamed(
        'search-results',
        pathParameters: {'query': Uri.encodeComponent(query)},
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Header - logo removed
                  const SizedBox(height: 8),
                    // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.search,
                            size: 16,
                            color: Color(0xFFADAEBC),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onSubmitted: (_) => _performSearch(),
                              decoration: const InputDecoration(
                                hintText: 'Search books, authors...',
                                hintStyle: TextStyle(
                                  color: Color(0xFFADAEBC),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(
                                  Icons.clear,
                                  size: 16,
                                  color: Color(0xFFADAEBC),
                                ),
                              ),
                            ),
                          GestureDetector(
                            onTap: _performSearch,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.search,
                                size: 16,
                                color: Color(0xFF4F46E5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  // Slideable Hero Banner
                  Container(
                    width: double.infinity,
                    height: 160,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentBannerIndex = index;
                            });
                          },
                          itemCount: _banners.length,
                          itemBuilder: (context, index) {
                            final banner = _banners[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: banner['color'] as Color,
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        banner['title'] as String,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: banner['textColor'] as Color,
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        banner['subtitle'] as String,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: (banner['textColor'] as Color).withOpacity(0.7),
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // Page indicators
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _banners.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentBannerIndex == index ? 20 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentBannerIndex == index
                                      ? const Color(0xFF111827)
                                      : const Color(0xFF111827).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  // First book section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Class XI books just for you!',
                          style: TextStyle(
                            color: Color(0xFF111827),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pushNamed('all-books', pathParameters: {'category': 'class-xi'});
                          },
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
                  
                  // First book row - using loaded data
                  SizedBox(
                    height: 270,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _classXIBooks.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final book = _classXIBooks[index];
                        return _buildBookCard(book['title'], book['author']);
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  // Second book section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recommended for you',
                          style: TextStyle(
                            color: Color(0xFF111827),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pushNamed('all-books', pathParameters: {'category': 'recommended'});
                          },
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
                  
                  // Second book row - using loaded data
                  SizedBox(
                    height: 270,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _recommendedBooks.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final book = _recommendedBooks[index];
                        return _buildBookCard(book['title'], book['author']);
                      },
                    ),
                  ),
                  
                  // Bottom padding for navigation bar
                  const SizedBox(height: 100),
                ],
              ),
            ),
      ),
    );
  }
  Widget _buildBookCard(String title, String author) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'book-detail',
          pathParameters: {
            'title': Uri.encodeComponent(title),
            'author': Uri.encodeComponent(author),
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "https://picsum.photos/152/200?random=${title.hashCode}",
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
          const SizedBox(height: 8),
          SizedBox(
            width: 160,
            child: Text(
              title,
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
          ),
          const SizedBox(height: 4),
          Text(
            author,
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
