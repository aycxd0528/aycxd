import 'package:flutter/material.dart';
import 'package:mango_shop/pages/Orders/PendingPaymentOrders.dart';
import 'package:mango_shop/pages/Orders/PendingShipmentOrders.dart';
import 'package:mango_shop/pages/Orders/ShippingOrders.dart';
import 'package:mango_shop/pages/Mine/EditProfile.dart';
import 'package:mango_shop/pages/Mine/Settings.dart';
import 'package:mango_shop/utils/auth_manager.dart';

class MineView extends StatefulWidget {
  MineView({Key? key}) : super(key: key);

  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  Map<String, dynamic>? _userInfo;

  @override
  void initState() {
    super.initState();
    // 从AuthManager获取用户信息
    _updateUserInfo();
  }

  // 更新用户信息
  void _updateUserInfo() {
    setState(() {
      _userInfo = AuthManager().userInfo;
    });
  }

  // 订单状态
  final List<Map<String, dynamic>> _orderStatus = [
    {'icon': '🔔', 'name': '待付款'},
    {'icon': '📦', 'name': '待发货'},
    {'icon': '🚚', 'name': '待收货'},
  ];

  // 功能入口
  final List<Map<String, dynamic>> _features = [
    {'icon': '💬', 'name': '客服中心'},
    {'icon': '⚙️', 'name': '设置'},
    {'icon': 'ℹ️', 'name': '关于我们'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          // 用户信息区域
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.red, Colors.orange[600]!],
              ),
            ),
            child: _userInfo != null
                ? Row(
                    children: [
                      // 头像
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white, width: 3),
                          image: DecorationImage(
                            image: AssetImage(_userInfo?['avatar'] ?? 'lib/assets/220c3184-fec6-4c46-8606-67015ed200cc.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      // 用户信息
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userInfo?['nickname'] ?? '用户',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _userInfo?['phone'] ?? '未设置',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 编辑资料按钮
                      GestureDetector(
                        onTap: () async {
                          // 编辑资料点击事件
                          print('编辑资料按钮被点击');
                          // 导航到编辑资料页面并等待返回结果
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return EditProfile(userInfo: _userInfo);
                            }),
                          );
                          // 如果有返回结果，更新用户信息
                          if (result != null) {
                            setState(() {
                              _userInfo = result;
                              // 更新AuthManager中的用户信息
                              AuthManager().login(result);
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '编辑资料',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '未登录',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '登录后享受更多服务',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      // 登录按钮
                      GestureDetector(
                        onTap: () async {
                          // 导航到登录页面
                          await Navigator.pushNamed(context, '/login');
                          // 登录后更新用户信息
                          _updateUserInfo();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '去登录',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),

          // 订单区域
          Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '我的订单',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '查看全部',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _orderStatus.map((status) {
                    return GestureDetector(
                      onTap: () {
                        print('${status['name']}入口被点击');
                        if (status['name'] == '待付款') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PendingPaymentOrders()),
                          );
                        } else if (status['name'] == '待发货') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PendingShipmentOrders()),
                          );
                        } else if (status['name'] == '待收货') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShippingOrders()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${status['name']}功能开发中')),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.red[100]!, Colors.red[50]!],
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: Text(
                                  status['icon'],
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              status['name'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // 功能入口区域
          Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '更多服务',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: _features.length,
                  itemBuilder: (context, index) {
                    var feature = _features[index];
                    return GestureDetector(
                      onTap: () async {
                        print('${feature['name']}入口被点击');
                        if (feature['name'] == '设置') {
                          // 导航到设置页面并等待返回结果
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SettingsPage(userInfo: _userInfo);
                            }),
                          );
                          // 如果有返回结果，更新用户信息
                          if (result != null) {
                            setState(() {
                              _userInfo = result;
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${feature['name']}功能开发中')),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.orange[100]!, Colors.amber[50]!],
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Text(
                                  feature['icon'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              feature['name'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}