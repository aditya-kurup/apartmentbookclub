import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  final List<String> categories = ["All", "Fiction", "Mystery", "Science", "Romance"];
  
  final List<Map<String, dynamic>> featuredBooks = [
    {
      "title": "The Silent Patient",
      "author": "Alex Michaelides",
      "rating": 4.8,
      "price": "\$12.99",
      "image": "https://placehold.co/400x600/45b7d1/ffffff?text=Mystery",
      "genre": "Mystery"
    },
    {
      "title": "Where the Crawdads Sing",
      "author": "Delia Owens",
      "rating": 4.6,
      "price": "\$14.99",
      "image": "https://placehold.co/400x600/ff6b6b/ffffff?text=Fiction",
      "genre": "Fiction"
    },
    {
      "title": "The Seven Husbands",
      "author": "Taylor Jenkins Reid",
      "rating": 4.9,
      "price": "\$13.99",
      "image": "https://placehold.co/400x600/7b68ee/ffffff?text=Romance",
      "genre": "Romance"
    },
  ];

  final List<Map<String, dynamic>> allBooks = [
    {
      "title": "Atomic Habits",
      "author": "James Clear",
      "rating": 4.7,
      "price": "\$15.99",
      "image": "https://placehold.co/300x450/4ecdc4/ffffff?text=Non-Fiction",
      "genre": "Science"
    },
    {
      "title": "The Midnight Library",
      "author": "Matt Haig",
      "rating": 4.5,
      "price": "\$12.99",
      "image": "https://placehold.co/400x600/ff6b6b/ffffff?text=Fiction",
      "genre": "Fiction"
    },
    {
      "title": "Project Hail Mary",
      "author": "Andy Weir",
      "rating": 4.8,
      "price": "\$16.99",
      "image": "https://placehold.co/400x600/4a90e2/ffffff?text=Science+Fiction",
      "genre": "Science"
    },
    {
      "title": "The Thursday Murder Club",
      "author": "Richard Osman",
      "rating": 4.4,
      "price": "\$13.99",
      "image": "https://placehold.co/400x600/45b7d1/ffffff?text=Mystery",
      "genre": "Mystery"
    },
    {
      "title": "It Ends with Us",
      "author": "Colleen Hoover",
      "rating": 4.7,
      "price": "\$14.99",
      "image": "https://placehold.co/400x600/7b68ee/ffffff?text=Romance",
      "genre": "Romance"
    },
    {
      "title": "The Silent Wife",
      "author": "Karin Slaughter",
      "rating": 4.6,
      "price": "\$13.49",
      "image": "https://placehold.co/400x600/45b7d1/ffffff?text=Mystery",
      "genre": "Mystery"
    },
    {
      "title": "Normal People",
      "author": "Sally Rooney",
      "rating": 4.3,
      "price": "\$11.99",
      "image": "https://placehold.co/400x600/ff6b6b/ffffff?text=Fiction",
      "genre": "Fiction"
    },
    {
      "title": "A Brief History of Time",
      "author": "Stephen Hawking",
      "rating": 4.9,
      "price": "\$17.99",
      "image": "https://placehold.co/300x450/4ecdc4/ffffff?text=Science",
      "genre": "Science"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildSearchBar(),
                const SizedBox(height: 24),
                _buildCategoryFilter(),
                const SizedBox(height: 32),
                _buildFeaturedBooks(),
                const SizedBox(height: 32),
                _buildAllBooks(),
              ],
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
        Text(
          "Bookly",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryColor,
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
          ),
          child: Icon(
            Icons.person,
            color: AppTheme.primaryColor,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(color: AppTheme.textPrimary),
        decoration: InputDecoration(
          hintText: "Search books, authors...",
          hintStyle: TextStyle(color: AppTheme.textSecondary),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.primaryColor,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
            ),
            child: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              underline: Container(),
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedBooks() {
    final filteredFeaturedBooks = selectedCategory == "All" 
        ? featuredBooks 
        : featuredBooks.where((book) => book["genre"] == selectedCategory).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Books",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        filteredFeaturedBooks.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "No featured books in this category",
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ),
              )
            : SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredFeaturedBooks.length,
                  itemBuilder: (context, index) {
                    final book = filteredFeaturedBooks[index];
                    return Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.lightAccent.withOpacity(0.8),
                            AppTheme.gradientStart.withOpacity(0.3),
                          ],
                          stops: const [0.0, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primaryColor.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  book["image"],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: AppTheme.surfaceColor,
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: AppTheme.primaryColor,
                                        size: 32,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              book["title"],
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              book["author"],
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFFFB800),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${book["rating"]}",
                                  style: const TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildAllBooks() {
    // Filter books based on selected category
    final filteredBooks = selectedCategory == "All" 
        ? allBooks 
        : allBooks.where((book) => book["genre"] == selectedCategory).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Books",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        filteredBooks.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "No books found in this category",
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (filteredBooks.length / 2).ceil(),
                itemBuilder: (context, rowIndex) {
                  final int startIndex = rowIndex * 2;
                  final int endIndex = startIndex + 1 < filteredBooks.length ? startIndex + 1 : startIndex;                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        _buildBookCard(filteredBooks[startIndex]),
                        const SizedBox(width: 12),
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
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.network(
                  book["image"],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book["title"],
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 4, top: 2, bottom: 2),
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                book["genre"],
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                book["author"],
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xFFFFB800),
                              size: 10,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              book["rating"].toString(),
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Borrow",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
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
    );
  }
}
