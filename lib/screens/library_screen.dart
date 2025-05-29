import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final List<Map<String, dynamic>> myBooks = [
    {
      "title": "Atomic Habits",
      "author": "James Clear",
      "progress": 0.75,
      "rating": 4.7,
      "status": "Reading",
      "genre": "Non-Fiction",
      "image": "https://placehold.co/300x450/43e97b/ffffff?text=Non-Fiction"
    },
    {
      "title": "The Silent Patient",
      "author": "Alex Michaelides",
      "progress": 1.0,
      "rating": 4.8,
      "status": "Completed",
      "genre": "Mystery",
      "image": "https://placehold.co/400x600/667eea/ffffff?text=Mystery"
    },
    {
      "title": "Where the Crawdads Sing",
      "author": "Delia Owens",
      "progress": 0.45,
      "rating": 4.6,
      "status": "Reading",
      "genre": "Fiction",
      "image": "https://placehold.co/400x600/f093fb/ffffff?text=Fiction"
    },
    {
      "title": "The Seven Husbands",
      "author": "Taylor Jenkins Reid",
      "progress": 0.0,
      "rating": 0.0,
      "status": "To Read",
      "genre": "Romance",
      "image": "https://placehold.co/400x600/4facfe/ffffff?text=Romance"
    },
  ];
  
  final List<Map<String, dynamic>> borrowedBooks = [
    {
      "title": "The Midnight Library",
      "author": "Matt Haig",
      "daysLeft": 5,
      "borrowDate": "May 15, 2025",
      "returnDate": "June 5, 2025",
      "genre": "Fiction",
      "image": "https://placehold.co/400x600/f093fb/ffffff?text=Fiction"
    },
    {
      "title": "Project Hail Mary",
      "author": "Andy Weir",
      "daysLeft": 12,
      "borrowDate": "May 20, 2025",
      "returnDate": "June 12, 2025",
      "genre": "Science",
      "image": "https://placehold.co/400x600/43e97b/ffffff?text=Science+Fiction"
    },
  ];
  
  final List<Map<String, dynamic>> lentBooks = [
    {
      "title": "The Thursday Murder Club",
      "author": "Richard Osman",
      "borrower": "Alice Smith",
      "lendDate": "May 10, 2025",
      "returnDate": "June 10, 2025",
      "genre": "Mystery",
      "image": "https://placehold.co/400x600/667eea/ffffff?text=Mystery"
    },
    {
      "title": "Normal People",
      "author": "Sally Rooney",
      "borrower": "John Doe",
      "lendDate": "May 25, 2025",
      "returnDate": "June 25, 2025",
      "genre": "Romance",
      "image": "https://placehold.co/400x600/4facfe/ffffff?text=Romance"
    },
  ];

  String selectedTab = "All";
  final List<String> tabs = ["All", "Reading", "Completed", "To Read"];
  
  String selectedSection = "My Books";
  final List<String> sections = ["My Books", "Borrowing", "Lending"];

  // Genre color mapping
  final Map<String, Color> genreColors = {
    "Mystery": const Color(0xFF667eea),
    "Fiction": const Color(0xFFf093fb),
    "Romance": const Color(0xFF4facfe),
    "Science": const Color(0xFF43e97b),
    "Non-Fiction": const Color(0xFF38f9d7),
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
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
      backgroundColor: const Color(0xFFF8FAFC),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildSectionSelector(),
                  const SizedBox(height: 24),
                  if (selectedSection == "My Books") ...[
                    _buildTabBar(),
                    const SizedBox(height: 24),
                    Expanded(
                      child: _buildBooksList(),
                    ),
                  ] else if (selectedSection == "Borrowing") ...[
                    Expanded(
                      child: _buildBorrowedBooksList(),
                    ),
                  ] else if (selectedSection == "Lending") ...[
                    Expanded(
                      child: _buildLentBooksList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ).createShader(bounds),
                child: Text(
                  "My Library",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Discover your reading journey",
                style: TextStyle(
                  color: const Color(0xFF64748b),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667eea).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: sections.asMap().entries.map((entry) {
          final index = entry.key;
          final section = entry.value;
          final isSelected = selectedSection == section;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(right: index == sections.length - 1 ? 0 : 16),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedSection = section;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  gradient: isSelected ? const LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ) : null,
                  color: isSelected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: isSelected ? null : Border.all(
                    color: const Color(0xFF667eea).withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected 
                          ? const Color(0xFF667eea).withOpacity(0.3)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: isSelected ? 12 : 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  section,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF64748b),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = selectedTab == tab;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(right: index == tabs.length - 1 ? 0 : 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = tab;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF667eea) : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: isSelected ? null : Border.all(
                    color: const Color(0xFF667eea).withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected 
                          ? const Color(0xFF667eea).withOpacity(0.2)
                          : Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF64748b),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBooksList() {
    final filteredBooks = selectedTab == "All" 
        ? myBooks 
        : myBooks.where((book) => book["status"] == selectedTab).toList();

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: filteredBooks.length,
      itemBuilder: (context, index) {
        final book = filteredBooks[index];
        final genreColor = genreColors[book["genre"]] ?? const Color(0xFF667eea);
        
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeOutBack,
          margin: const EdgeInsets.only(bottom: 20),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  genreColor.withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: genreColor.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: genreColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        genreColor.withOpacity(0.1),
                        genreColor.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Image.network(
                      book["image"],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.auto_stories_rounded,
                            color: genreColor,
                            size: 32,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          book["title"],
                          style: const TextStyle(
                            color: Color(0xFF1e293b),
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
                            color: Color(0xFF64748b),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (book["status"] == "Reading") ...[
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: genreColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: book["progress"],
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [genreColor, genreColor.withOpacity(0.8)],
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: genreColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "${(book["progress"] * 100).toInt()}%",
                                  style: TextStyle(
                                    color: genreColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else if (book["status"] == "Completed") ...[
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFfbbf24).withOpacity(0.2),
                                      const Color(0xFFf59e0b).withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFfbbf24),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      book["rating"].toString(),
                                      style: const TextStyle(
                                        color: Color(0xFF1e293b),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: genreColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "Completed",
                                  style: TextStyle(
                                    color: genreColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF64748b).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.bookmark_outline_rounded,
                                  color: const Color(0xFF64748b),
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "To Read",
                                  style: TextStyle(
                                    color: const Color(0xFF64748b),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: genreColor.withOpacity(0.7),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildBorrowedBooksList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: borrowedBooks.length,
      itemBuilder: (context, index) {
        final book = borrowedBooks[index];
        final genreColor = genreColors[book["genre"]] ?? const Color(0xFF667eea);
        final isUrgent = book["daysLeft"] < 7;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                isUrgent 
                    ? Colors.red.withOpacity(0.02)
                    : genreColor.withOpacity(0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isUrgent 
                  ? Colors.red.withOpacity(0.2)
                  : genreColor.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isUrgent 
                    ? Colors.red.withOpacity(0.1)
                    : genreColor.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      genreColor.withOpacity(0.1),
                      genreColor.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Image.network(
                    book["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.auto_stories_rounded,
                          color: genreColor,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        book["title"],
                        style: const TextStyle(
                          color: Color(0xFF1e293b),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        book["author"],
                        style: const TextStyle(
                          color: Color(0xFF64748b),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isUrgent 
                                    ? [Colors.red.withOpacity(0.2), Colors.red.withOpacity(0.1)]
                                    : [genreColor.withOpacity(0.2), genreColor.withOpacity(0.1)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.schedule_rounded,
                                  color: isUrgent ? Colors.red : genreColor,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${book["daysLeft"]} days left",
                                  style: TextStyle(
                                    color: isUrgent ? Colors.red : genreColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Return by: ${book["returnDate"]}",
                        style: const TextStyle(
                          color: Color(0xFF64748b),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: genreColor,
                  size: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildLentBooksList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: lentBooks.length,
      itemBuilder: (context, index) {
        final book = lentBooks[index];
        final genreColor = genreColors[book["genre"]] ?? const Color(0xFF667eea);
        
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                genreColor.withOpacity(0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: genreColor.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: genreColor.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      genreColor.withOpacity(0.1),
                      genreColor.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Image.network(
                    book["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.auto_stories_rounded,
                          color: genreColor,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        book["title"],
                        style: const TextStyle(
                          color: Color(0xFF1e293b),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        book["author"],
                        style: const TextStyle(
                          color: Color(0xFF64748b),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  genreColor.withOpacity(0.2),
                                  genreColor.withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_outline_rounded,
                                  color: genreColor,
                                  size: 14,
                                ),                                const SizedBox(width: 4),
                                Text(
                                  book["borrower"],
                                  style: TextStyle(
                                    color: genreColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Expected return: ${book["returnDate"]}",
                        style: const TextStyle(
                          color: Color(0xFF64748b),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: genreColor,
                  size: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}