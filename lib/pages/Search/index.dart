import 'package:flutter/material.dart';
import 'package:mango_shop/utils/colors.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<String> _searchHistory = ['苹果', '香蕉', '牛奶', '鸡蛋', '大米'];
  List<String> _searchSuggestions = [];
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  bool _hasSearched = false;

  // 商品数据（与分类页面保持一致）
  final Map<String, List<Map<String, dynamic>>> _allProducts = {
    '1': [
      {'id': '101', 'name': '苹果', 'price': '8.9', 'image': 'lib/assets/苹果.png'},
      {'id': '102', 'name': '香蕉', 'price': '5.9', 'image': 'lib/assets/香蕉.png'},
      {'id': '103', 'name': '橙子', 'price': '9.9', 'image': 'lib/assets/橙子.png'},
      {'id': '104', 'name': '草莓', 'price': '12.9', 'image': 'lib/assets/草莓.png'},
      {'id': '105', 'name': '海南芒果', 'price': '19.9', 'image': 'lib/assets/220c3184-fec6-4c46-8606-67015ed200cc.png'},
      {'id': '106', 'name': '广西芒果', 'price': '15.9', 'image': 'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png'},
      {'id': '107', 'name': '云南芒果', 'price': '17.9', 'image': 'lib/assets/220c3184-fec6-4c46-8606-67015ed200cc.png'},
      {'id': '108', 'name': '泰国芒果', 'price': '29.9', 'image': 'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png'},
    ],
    '2': [
      {'id': '201', 'name': '白菜', 'price': '2.9', 'image': 'lib/assets/白菜.png'},
      {'id': '202', 'name': '萝卜', 'price': '3.9', 'image': 'lib/assets/胡萝卜.png'},
      {'id': '203', 'name': '西红柿', 'price': '4.9', 'image': 'lib/assets/西红柿.png'},
      {'id': '204', 'name': '黄瓜', 'price': '3.9', 'image': 'lib/assets/黄瓜.png'},
    ],
    '3': [
      {'id': '301', 'name': '薯片', 'price': '6.9', 'image': 'lib/assets/薯片.png'},
      {'id': '302', 'name': '饼干', 'price': '8.9', 'image': 'lib/assets/饼干.png'},
      {'id': '303', 'name': '糖果', 'price': '5.9', 'image': 'lib/assets/糖果.png'},
      {'id': '304', 'name': '坚果', 'price': '12.9', 'image': 'lib/assets/坚果.png'},
    ],
    '4': [
      {'id': '401', 'name': '可乐', 'price': '3.9', 'image': 'lib/assets/可乐.png'},
      {'id': '402', 'name': '雪碧', 'price': '3.9', 'image': 'lib/assets/雪碧.png'},
      {'id': '403', 'name': '果汁', 'price': '5.9', 'image': 'lib/assets/果汁.png'},
      {'id': '404', 'name': '矿泉水', 'price': '1.9', 'image': 'lib/assets/矿泉水.png'},
    ],
    '5': [
      {'id': '501', 'name': '猪肉', 'price': '29.9', 'image': 'lib/assets/猪肉.png'},
      {'id': '502', 'name': '牛肉', 'price': '59.9', 'image': 'lib/assets/牛肉.png'},
      {'id': '503', 'name': '鸡肉', 'price': '19.9', 'image': 'lib/assets/鸡肉.png'},
      {'id': '504', 'name': '鸭肉', 'price': '15.9', 'image': 'lib/assets/鸭肉.png'},
    ],
    '6': [
      {'id': '601', 'name': '鱼', 'price': '29.9', 'image': 'lib/assets/鱼.png'},
      {'id': '602', 'name': '虾', 'price': '49.9', 'image': 'lib/assets/虾.png'},
      {'id': '603', 'name': '蟹', 'price': '69.9', 'image': 'lib/assets/螃蟹.png'},
      {'id': '604', 'name': '贝类', 'price': '39.9', 'image': 'lib/assets/贝.png'},
    ],
    '7': [
      {'id': '701', 'name': '牛奶', 'price': '5.9', 'image': 'lib/assets/奶.png'},
      {'id': '702', 'name': '鸡蛋', 'price': '12.9', 'image': 'lib/assets/蛋.png'},
      {'id': '703', 'name': '调味品', 'price': '9.9', 'image': 'lib/assets/调味品.png'},
      {'id': '704', 'name': '米面', 'price': '15.9', 'image': 'lib/assets/米.png'},
    ],
  };

  // 所有商品的列表（用于搜索）
  late List<Map<String, dynamic>> _allProductsList;

  @override
  void initState() {
    super.initState();
    // 初始化所有商品列表
    _initializeAllProductsList();
    // 自动聚焦到搜索框
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  // 初始化所有商品列表
  void _initializeAllProductsList() {
    _allProductsList = [];
    // 将所有分类的商品添加到一个列表中
    _allProducts.forEach((categoryId, products) {
      _allProductsList.addAll(products);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // 处理搜索
  void _handleSearch(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        _searchSuggestions = [];
        _searchResults = [];
        _isSearching = false;
        _hasSearched = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // 模拟搜索延迟
    Future.delayed(Duration(milliseconds: 300), () {
      // 生成搜索建议
      List<String> suggestions = [];
      for (var product in _allProductsList) {
        if (product['name'].toLowerCase().contains(keyword.toLowerCase())) {
          suggestions.add(product['name']);
        }
      }

      // 生成搜索结果
      List<Map<String, dynamic>> results = [];
      for (var product in _allProductsList) {
        if (product['name'].toLowerCase().contains(keyword.toLowerCase())) {
          results.add(product);
        }
      }

      setState(() {
        _searchSuggestions = suggestions;
        _searchResults = results;
        _isSearching = false;
        _hasSearched = true;
      });
    });
  }

  // 执行搜索
  void _performSearch(String keyword) {
    if (keyword.isEmpty) return;

    // 添加到搜索历史
    if (!_searchHistory.contains(keyword)) {
      setState(() {
        _searchHistory.insert(0, keyword);
        if (_searchHistory.length > 10) {
          _searchHistory = _searchHistory.sublist(0, 10);
        }
      });
    }

    // 执行搜索
    _handleSearch(keyword);
  }

  // 清除搜索历史
  void _clearSearchHistory() {
    setState(() {
      _searchHistory = [];
    });
  }

  // 从历史记录中选择
  void _selectFromHistory(String keyword) {
    _searchController.text = keyword;
    _performSearch(keyword);
  }

  // 从建议中选择
  void _selectFromSuggestion(String keyword) {
    _searchController.text = keyword;
    _performSearch(keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            onChanged: _handleSearch,
            onSubmitted: _performSearch,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: AppColors.textHint, size: 20),
              hintText: '搜索商品',
              hintStyle: TextStyle(color: AppColors.textHint, fontSize: 14),
              contentPadding: EdgeInsets.only(top: 8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _performSearch(_searchController.text);
            },
            child: Text('搜索', style: TextStyle(color: AppColors.primary, fontSize: 14)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 搜索建议或结果
            Expanded(
              child: _isSearching
                  ? Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : _hasSearched
                      ? _buildSearchResults()
                      : _buildSearchSuggestions(),
            ),
          ],
        ),
      ),
    );
  }

  // 构建搜索建议
  Widget _buildSearchSuggestions() {
    return ListView(
      children: [
        // 搜索历史
        if (_searchHistory.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('搜索历史', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                IconButton(
                  icon: Icon(Icons.delete_outline, size: 18, color: AppColors.textHint),
                  onPressed: _clearSearchHistory,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _searchHistory.map((item) {
                return GestureDetector(
                  onTap: () => _selectFromHistory(item),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.gray300, width: 1),
                    ),
                    child: Text(item, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
        ],

        // 热门搜索
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text('热门搜索', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['苹果', '香蕉', '牛奶', '鸡蛋', '大米', '可乐', '薯片', '草莓'].map((item) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = item;
                  _performSearch(item);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.gray300, width: 1),
                  ),
                  child: Text(item, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ),
              );
            }).toList(),
          ),
        ),

        // 搜索建议
        if (_searchSuggestions.isNotEmpty) ...[
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text('搜索建议', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          ),
          ..._searchSuggestions.map((suggestion) {
            return GestureDetector(
              onTap: () => _selectFromSuggestion(suggestion),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: AppColors.white,
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.textHint, size: 18),
                    SizedBox(width: 12),
                    Text(suggestion, style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ],
    );
  }

  // 构建搜索结果
  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.textHint),
            SizedBox(height: 16),
            Text('未找到相关商品', style: TextStyle(fontSize: 14, color: AppColors.textHint)),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        var product = _searchResults[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    image: DecorationImage(
                      image: AssetImage(product['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '¥${product['price']}',
                      style: TextStyle(fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
