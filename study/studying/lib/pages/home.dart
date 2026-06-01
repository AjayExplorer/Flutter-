import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'salad.dart';
import 'smoothies.dart';
import 'burgers.dart';
import 'pasta.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  final List<_FoodItem> _items = const [
    _FoodItem(
      name: 'Salads',
      category: 'Healthy',
      icon: Icons.spa,
      color: Colors.green,
    ),
    _FoodItem(
      name: 'Smoothies',
      category: 'Drinks',
      icon: Icons.local_drink,
      color: Colors.deepPurple,
    ),
    _FoodItem(
      name: 'Burgers',
      category: 'Fast Food',
      icon: Icons.fastfood,
      color: Colors.orange,
    ),
    _FoodItem(
      name: 'Pasta',
      category: 'Dinner',
      icon: Icons.ramen_dining,
      color: Colors.redAccent,
    ),
  ];

  String _query = '';
  int _selectedCategoryIndex = -1;

  List<_FoodItem> get _filteredItems {
    if (_query.isEmpty) return _items;
    final normalizedQuery = _query.toLowerCase();
    return _items
        .where(
          (item) =>
              item.name.toLowerCase().contains(normalizedQuery) ||
              item.category.toLowerCase().contains(normalizedQuery),
        )
        .toList();
  }

  Future<void> _openGoogleSearch(String value) async {
    final uri = Uri.parse(
      'https://www.mayoclinic.org/healthy-lifestyle/weight-loss/expert-answers/apple-cider-vinegar-for-weight-loss/faq-20058394',
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open link.')));
    }
  }

  void _openItem(_FoodItem item) {
    final name = item.name.toLowerCase();
    if (name == 'salads') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const Salad()));
      return;
    }

    if (name == 'smoothies') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const Smoothies()));
      return;
    }

    if (name == 'burgers') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const Burgers()));
      return;
    }

    if (name == 'pasta') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const Pasta()));
      return;
    }

    // fallback: open external link
    _openGoogleSearch(item.name);
  }

  void _selectCategory(int index) {
    setState(() {
      if (_selectedCategoryIndex == index) {
        _selectedCategoryIndex = -1;
        _query = '';
        _searchController.clear();
      } else {
        _selectedCategoryIndex = index;
        _query = _items[index].name;
        _searchController.text = _items[index].name;
        _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final crossAxis = width > 700 ? 3 : (width > 500 ? 2 : 1);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFBF8FF), Color(0xFFF6F7FB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          'Breakfast',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu, color: Colors.black),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey.shade50,
              child: const Icon(Icons.person, color: Colors.black54),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search food or category',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _query = '';
                                _selectedCategoryIndex = -1;
                              });
                            },
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) => setState(() => _query = value.trim()),
                ),
              ),
              const SizedBox(height: 20),

              // Categories
              const Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 56,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    final selected = _selectedCategoryIndex == index;
                    return ChoiceChip(
                      selectedColor: item.color.withOpacity(0.15),
                      side: BorderSide.none,
                      backgroundColor: Colors.white,
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      selected: selected,
                      avatar: CircleAvatar(
                        backgroundColor: item.color.withOpacity(0.2),
                        child: Icon(item.icon, color: item.color),
                      ),
                      label: Text(
                        item.name,
                        style: TextStyle(
                          color: selected ? item.color : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onSelected: (_) => _selectCategory(index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Recommendations header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recommendation For Diet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: const Text('See all')),
                ],
              ),
              const SizedBox(height: 12),

              // Recommendations grid/list
              Expanded(
                child: _filteredItems.isEmpty
                    ? const Center(
                        child: Text('No matches found. Try another search.'),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxis,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.6,
                        ),
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: item.color.withOpacity(0.18),
                                  child: Icon(
                                    item.icon,
                                    color: item.color,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item.category,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => _openItem(item),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('View'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FoodItem {
  const _FoodItem({
    required this.name,
    required this.category,
    required this.icon,
    required this.color,
  });

  final String name;
  final String category;
  final IconData icon;
  final Color color;
}
