import 'package:flutter/material.dart';
import 'package:mango_shop/pages/Main/index.dart';

class categoryView extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(List<CartItem>)? onCartItemsChanged;
  final Function(int)? onCartCountChanged;

  categoryView({Key? key, required this.cartItems, this.onCartItemsChanged, this.onCartCountChanged}) : super(key: key);

  @override
  _categoryViewState createState() => _categoryViewState();
}

class _categoryViewState extends State<categoryView> {
  // 分类数据
  final List<Map<String, dynamic>> _categories = [
    {'id': '1', 'name': '水果', 'icon': '🍎'},
    {'id': '2', 'name': '蔬菜', 'icon': '🥬'},
    {'id': '3', 'name': '零食', 'icon': '🍟'},
    {'id': '4', 'name': '饮料', 'icon': '🥤'},
    {'id': '5', 'name': '肉禽', 'icon': '🥩'},
    {'id': '6', 'name': '水产', 'icon': '🐟'},
    {'id': '7', 'name': '更多', 'icon': '📦'},
  ];

  // 原始商品数据（完整数据集）
  final Map<String, List<Map<String, dynamic>>> _allProducts = {
    '1': [
      {'id': '101', 'name': '苹果', 'price': '8.9', 'image': 'lib/assets/苹果.png'},
      {'id': '102', 'name': '香蕉', 'price': '5.9', 'image': 'lib/assets/香蕉.png'},
      {'id': '103', 'name': '橙子', 'price': '9.9', 'image': 'lib/assets/橙子.png'},
      {'id': '104', 'name': '草莓', 'price': '12.9', 'image': 'lib/assets/草莓.png'},
      {'id': '105', 'name': '海南芒果', 'price': '19.9', 'image': 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png'},
      {'id': '106', 'name': '广西芒果', 'price': '15.9', 'image': 'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png'},
      {'id': '107', 'name': '云南芒果', 'price': '17.9', 'image': 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png'},
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

  // 当前显示的商品数据（随机排序后的数据集）
  late Map<String, List<Map<String, dynamic>>> _products;
  
  // 所有商品的列表（用于随机显示全部商品）
  late List<Map<String, dynamic>> _allProductsList;
  
  // 当前是否处于随机显示全部商品模式
  bool _isRandomAllMode = false;
  
  // 当前随机显示的全部商品
  late List<Map<String, dynamic>> _randomAllProducts;

  // 当前选中的分类
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    // 初始化商品数据，随机排序
    _initializeProducts();
    // 初始化所有商品列表
    _initializeAllProductsList();
  }

  // 初始化商品数据
  void _initializeProducts() {
    _products = {};
    // 对每个分类的商品进行随机排序
    _allProducts.forEach((categoryId, products) {
      final shuffled = [...products]..shuffle();
      _products[categoryId] = shuffled;
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

  // 更换当前分类的商品
  void _refreshCategoryProducts() {
    if (_isRandomAllMode) {
      // 随机显示全部商品模式
      _refreshRandomAllProducts();
    } else {
      // 普通模式：仅随机排序当前分类的商品
      setState(() {
        final currentCategoryId = _categories[_selectedCategoryIndex]['id'];
        // 对当前分类的商品进行随机排序
        final shuffled = [..._allProducts[currentCategoryId]!]..shuffle();
        _products[currentCategoryId] = shuffled;
      });
      // 显示更换成功提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已为你更换${_categories[_selectedCategoryIndex]['name']}分类的商品')),
      );
    }
  }

  // 随机显示全部商品
  void _refreshRandomAllProducts() {
    setState(() {
      // 从所有商品中随机选择12个商品
      final shuffled = [..._allProductsList]..shuffle();
      _randomAllProducts = shuffled.take(12).toList();
    });
    // 显示更换成功提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已为你随机显示全部商品')),
    );
  }

  // 切换到随机显示全部商品模式
  void _toggleRandomAllMode() {
    setState(() {
      _isRandomAllMode = !_isRandomAllMode;
      if (_isRandomAllMode) {
        // 进入随机显示全部商品模式
        _refreshRandomAllProducts();
      }
    });
    // 显示模式切换提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_isRandomAllMode ? '已切换到随机显示全部商品模式' : '已切换到分类商品模式')),
    );
  }

  // 计算购物车总数量
  int get _cartCount {
    return widget.cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // 通知父组件购物车数量变化
  void _notifyCartCountChanged() {
    if (widget.onCartCountChanged != null) {
      widget.onCartCountChanged!(_cartCount);
    }
  }

  // 添加商品到购物车
  void _addToCart(Map<String, dynamic> product) {
    // 创建购物车数据的副本
    final newCartItems = List<CartItem>.from(widget.cartItems);
    
    // 检查商品是否已在购物车中
    final existingIndex = newCartItems.indexWhere((item) => item.id == product['id']);
    
    if (existingIndex >= 0) {
      // 商品已存在，增加数量
      newCartItems[existingIndex].quantity++;
    } else {
      // 商品不存在，添加到购物车
      newCartItems.add(CartItem(
        id: product['id'],
        name: product['name'],
        image: product['image'],
        price: double.parse(product['price']),
        quantity: 1,
      ));
    }
    
    // 通知父组件更新购物车数据
    if (widget.onCartItemsChanged != null) {
      widget.onCartItemsChanged!(newCartItems);
    }
    
    // 通知父组件购物车数量变化
    _notifyCartCountChanged();
    
    // 显示添加成功提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product['name']} 已添加到购物车')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // 左侧分类列表
          Container(
            width: 110,
            color: Colors.white,
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                    // 显示分类切换提示
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('已切换到${_categories[index]['name']}分类'),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _selectedCategoryIndex == index ? Colors.red : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      color: _selectedCategoryIndex == index ? Colors.red[50] : Colors.white,
                      boxShadow: _selectedCategoryIndex == index ? [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ] : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 分类图标
                        Text(
                          _categories[index]['icon'],
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 6),
                        // 分类名称
                        Text(
                          _categories[index]['name'],
                          style: TextStyle(
                            fontSize: 13,
                            color: _selectedCategoryIndex == index ? Colors.red : Colors.grey[800],
                            fontWeight: _selectedCategoryIndex == index ? FontWeight.bold : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // 右侧商品列表
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  // 分类标题和操作按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isRandomAllMode ? '全部商品' : _categories[_selectedCategoryIndex]['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Row(
                        children: [
                          // 模式切换按钮
                          GestureDetector(
                            onTap: () {
                              _toggleRandomAllMode();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: _isRandomAllMode ? Colors.red[100] : Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _isRandomAllMode ? '分类模式' : '全部模式',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _isRandomAllMode ? Colors.red : Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                          // 换一批按钮
                          GestureDetector(
                            onTap: () {
                              // 显示加载提示
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('正在为你更换商品...')),
                              );
                              // 更换商品
                              _refreshCategoryProducts();
                            },
                            child: Row(
                              children: [
                                Text(_isRandomAllMode ? '换一换' : '换一批', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                                Icon(Icons.refresh, size: 14, color: Colors.grey[600]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // 商品网格
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _isRandomAllMode ? _randomAllProducts.length : (_products[_categories[_selectedCategoryIndex]['id']]?.length ?? 0),
                    itemBuilder: (context, index) {
                      final product = _isRandomAllMode ? _randomAllProducts[index] : _products[_categories[_selectedCategoryIndex]['id']]?[index];
                      if (product == null) return Container();
                       
                      return GestureDetector(
                        onTap: () {
                          // 商品点击事件
                          print('分类商品 ${product['name']} 被点击');
                          // 显示商品详情页跳转提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('查看商品详情：${product['name']}')),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 商品图片
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
                              // 商品信息
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '¥${product['price']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _addToCart(product);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              '加入购物车',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}