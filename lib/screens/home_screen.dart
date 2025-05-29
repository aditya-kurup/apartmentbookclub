import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String selectedCategory = "All";
  final List<String> categories = ["All", "Fiction", "Mystery", "Science", "Romance"];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final List<Map<String, dynamic>> featuredBooks = [
    {
      "title": "The Silent Patient",
      "author": "Alex Michaelides",
      "rating": 4.8,
      "price": "\$12.99",
      "image": "https://placehold.co/400x600/667eea/ffffff?text=Mystery",
      "genre": "Mystery",
      "color": const Color(0xFF667eea)
    },
    {
      "title": "Where the Crawdads Sing",
      "author": "Delia Owens",
      "rating": 4.6,
      "price": "\$14.99",
      "image": "https://placehold.co/400x600/f093fb/ffffff?text=Fiction",
      "genre": "Fiction",
      "color": const Color(0xFFf093fb)
    },
    {
      "title": "The Seven Husbands",
      "author": "Taylor Jenkins Reid",
      "rating": 4.9,
      "price": "\$13.99",
      "image": "https://placehold.co/400x600/4facfe/ffffff?text=Romance",
      "genre": "Romance",
      "color": const Color(0xFF4facfe)
    },
  ];

  final List<Map<String, dynamic>> allBooks = [
    {
      "title": "Atomic Habits",
      "author": "James Clear",
      "rating": 4.7,
      "price": "\$15.99",
      "image": "https://placehold.co/300x450/43e97b/ffffff?text=Science",
      "genre": "Science",
      "color": const Color(0xFF43e97b)
    },
    {
      "title": "The Midnight Library",
      "author": "Matt Haig",
      "rating": 4.5,
      "price": "\$12.99",
      "image": "https://placehold.co/400x600/f093fb/ffffff?text=Fiction",
      "genre": "Fiction",
      "color": const Color(0xFFf093fb)
    },
    {
      "title": "Project Hail Mary",
      "author": "Andy Weir",
      "rating": 4.8,
      "price": "\$16.99",
      "image": "https://placehold.co/400x600/38f9d7/ffffff?text=Science",
      "genre": "Science",
      "color": const Color(0xFF38f9d7)
    },
    {
      "title": "The Thursday Murder Club",
      "author": "Richard Osman",
      "rating": 4.4,
      "price": "\$13.99",
      "image": "https://placehold.co/400x600/667eea/ffffff?text=Mystery",
      "genre": "Mystery",
      "color": const Color(0xFF667eea)
    },
    {
      "title": "It Ends with Us",
      "author": "Colleen Hoover",
      "rating": 4.7,
      "price": "\$14.99",
      "image": "https://placehold.co/400x600/4facfe/ffffff?text=Romance",
      "genre": "Romance",
      "color": const Color(0xFF4facfe)
    },
    {
      "title": "The Silent Wife",
      "author": "Karin Slaughter",
      "rating": 4.6,
      "price": "\$13.49",
      "image": "https://placehold.co/400x600/667eea/ffffff?text=Mystery",
      "genre": "Mystery",
      "color": const Color(0xFF667eea)
    },
    {
      "title": "Normal People",
      "author": "Sally Rooney",
      "rating": 4.3,
      "price": "\$11.99",
      "image": "https://placehold.co/400x600/f093fb/ffffff?text=Fiction",
      "genre": "Fiction",
      "color": const Color(0xFFf093fb)
    },
    {
      "title": "A Brief History of Time",
      "author": "Stephen Hawking",
      "rating": 4.9,
      "price": "\$17.99",
      "image": "https://placehold.co/300x450/43e97b/ffffff?text=Science",
      "genre": "Science",
      "color": const Color(0xFF43e97b)
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildSearchBar(),
                  const SizedBox(height: 28),
                  _buildCategoryFilter(),
                  const SizedBox(height: 40),
                  _buildFeaturedBooks(),
                  const SizedBox(height: 40),
                  _buildAllBooks(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
              child: Text(
                "Bookly",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Discover your next great read",
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667eea).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: TextField(
        style: const TextStyle(color: AppTheme.textPrimary, fontSize: 16),
        decoration: InputDecoration(
          hintText: "Search books, authors...",
          hintStyle: const TextStyle(color: AppTheme.textMuted, fontSize: 16),
          border: InputBorder.none,
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.search_rounded,
              color: AppTheme.primaryColor,
              size: 24,
            ),
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: isSelected ? AppTheme.primaryGradient : null,
                color: isSelected ? null : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: isSelected
                    ? AppTheme.buttonShadow
                    : AppTheme.cardShadow,
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedBooks() {
    final filteredFeaturedBooks = selectedCategory == "All" 
        ? featuredBooks 
        : featuredBooks.where((book) => book["genre"] == selectedCategory).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Books",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "See all",
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        filteredFeaturedBooks.isEmpty
            ? _buildEmptyState("No featured books in this category")
            : SizedBox(
                height: 360,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  itemCount: filteredFeaturedBooks.length,
                  itemBuilder: (context, index) {
                    final book = filteredFeaturedBooks[index];
                    return _buildFeaturedBookCard(book, index);
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildFeaturedBookCard(Map<String, dynamic> book, int index) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 100)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.surfaceColor,
                book["color"].withOpacity(0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      book["image"],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: book["color"].withOpacity(0.1),
                          child: Icon(
                            Icons.menu_book_rounded,
                            color: book["color"],
                            size: 48,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  book["title"],
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  book["author"],
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppTheme.starColor,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${book["rating"]}",
                          style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: book["color"],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        book["price"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllBooks() {
    final filteredBooks = selectedCategory == "All" 
        ? allBooks 
        : allBooks.where((book) => book["genre"] == selectedCategory).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Books",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View all",
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        filteredBooks.isEmpty
            ? _buildEmptyState("No books found in this category")
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (filteredBooks.length / 2).ceil(),
                itemBuilder: (context, rowIndex) {
                  final int startIndex = rowIndex * 2;
                  final int endIndex = startIndex + 1 < filteredBooks.length ? startIndex + 1 : startIndex;                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        _buildBookCard(filteredBooks[startIndex]),
                        const SizedBox(width: 16),
                        if (endIndex > startIndex)
                          _buildBookCard(filteredBooks[endIndex])
                        else
                          Expanded(child: Container()),
                      ],
                    ),
                  );
                },
              ),
      ],
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: book["color"].withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: Image.network(
                    book["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.menu_book_rounded,
                          color: book["color"],
                          size: 28,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book["title"],
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            book["author"],
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppTheme.starColor,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                book["rating"].toString(),
                                style: const TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [book["color"], book["color"].withOpacity(0.8)],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Read",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}