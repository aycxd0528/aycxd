import 'package:flutter/material.dart';
import 'package:mango_shop/pages/Cart/index.dart';
import 'package:mango_shop/pages/Category/index.dart';
import 'package:mango_shop/pages/Home/index.dart';
import 'package:mango_shop/pages/Mine/index.dart';

// 购物车商品模型
class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  int quantity;
  bool isSelected;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    this.isSelected = true,
  });
}

class Mainpage extends StatefulWidget {
  Mainpage({Key? key}) : super(key: key);

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  // 定义Tab栏数据
  final List<Map<String, dynamic>> _tablist = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "activeIcon": "lib/assets/ic_public_home_active.png",
      "text": "首页",
      "page": Center(child: Text("首页")),
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "activeIcon": "lib/assets/ic_public_pro_active.png",
      "text": "分类",
      "page": Center(child: Text("分类")),
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "activeIcon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车",
      "page": Center(child: Text("购物车")),
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "activeIcon": "lib/assets/ic_public_my_active.png",
      "text": "我的",
      "page": Center(child: Text("我的")),
    },
  ];

  int _currentIndex = 0;
  List<CartItem> _cartItems = [
    CartItem(
      id: '1',
      name: '新鲜芒果 泰国进口大青芒 2个装 单果约400-500g 新鲜水果',
      image: 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
      price: 29.9,
      quantity: 2,
    ),
    CartItem(
      id: '2',
      name: '海南小台农芒果 500g装 单果约80-120g 新鲜水果',
      image: 'lib/assets/52da9c14-9404-4e4d-83a1-4a294050350f.png',
      price: 15.9,
      quantity: 1,
    ),
    CartItem(
      id: '3',
      name: '广西百色芒果 桂七香芒 2个装 单果约300-400g 新鲜水果',
      image: 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png',
      price: 25.9,
      quantity: 3,
    ),
  ]; // 购物车数据

  // 计算购物车总数量
  int get _cartCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // 构建Tab栏图标
  Widget _buildTabIcon(int index, bool isActive) {
    // 根据是否选中使用不同的图标
    String iconPath = isActive ? _tablist[index]["activeIcon"]! : _tablist[index]["icon"]!;
    
    Widget icon = Image.asset(
      iconPath,
      width: 30,
      height: 30,
    );

    // 购物车图标添加数量显示
    if (index == 2) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          icon,
          if (_cartCount > 0)
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                _cartCount > 99 ? '99+' : _cartCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      );
    }

    return icon;
  }

  // 返回底部渲染的4个分类
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tablist.length, (int index) {
      return BottomNavigationBarItem(
        icon: _buildTabIcon(index, false),
        activeIcon: _buildTabIcon(index, true),
        label: _tablist[index]["text"]!,
      );
    });
  }

  // 更新购物车数据
  void _updateCartItems(List<CartItem> newCartItems) {
    setState(() {
      _cartItems = newCartItems;
    });
  }

  // 获取购物车数据
  List<CartItem> get cartItems => _cartItems;

  List<Widget> _getChildren(){
    return [
      HomeView(),
      categoryView(
        cartItems: _cartItems,
        onCartItemsChanged: _updateCartItems,
        onCartCountChanged: (count) {
          setState(() {
            // 这里不需要手动更新，因为_cartCount是根据_cartItems计算的
          });
        },
      ),
      CartView(
        cartItems: _cartItems,
        onCartItemsChanged: _updateCartItems,
        onCartCountChanged: (count) {
          setState(() {
            // 这里不需要手动更新，因为_cartCount是根据_cartItems计算的
          });
        },
      ),
      MineView()
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child:IndexedStack(
        index: _currentIndex,
        children: _getChildren(),
      ),
    ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        backgroundColor: Colors.white,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
      ),
    );
  }
}