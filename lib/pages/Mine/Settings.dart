import 'package:flutter/material.dart';
import 'EditProfile.dart';
import 'AddressManagement.dart';
import 'package:mango_shop/utils/auth_manager.dart';

class SettingsPage extends StatefulWidget {
  final Map<String, dynamic>? userInfo;
  
  SettingsPage({Key? key, this.userInfo}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // 设置项列表
  late List<List<Map<String, dynamic>>> _settingsGroups;

  @override
  void initState() {
    super.initState();
    // 初始化设置项列表，传递用户信息到个人信息编辑页面
    _settingsGroups = [
      [
        {'icon': '👤', 'title': '个人信息', 'route': EditProfile(userInfo: widget.userInfo)},
        {'icon': '📍', 'title': '收货地址', 'route': AddressManagement()},
      ],
      [
        {'icon': '🔄', 'title': '切换账号', 'action': _switchAccount},
        {'icon': '🚪', 'title': '退出登录', 'action': _logout},
      ],
    ];
  }

  // 切换账号方法
  static void _switchAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('切换账号'),
          content: Text('确定要切换到登录页面吗？'),
          actions: [
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('确定'),
              onPressed: () {
                // 这里可以导航到登录页面
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('切换账号功能开发中')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // 退出登录方法
  static void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('退出登录'),
          content: Text('确定要退出登录吗？'),
          actions: [
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('确定'),
              onPressed: () {
                // 执行退出登录逻辑
                AuthManager().logout();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('已退出登录')),
                );
                // 导航到登录页面
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: _settingsGroups.length,
        itemBuilder: (context, groupIndex) {
          var group = _settingsGroups[groupIndex];
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Column(
                  children: group.asMap().entries.map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return GestureDetector(
                      onTap: () async {
                        if (item.containsKey('route')) {
                          if (item['route'] is EditProfile) {
                            // 导航到个人信息编辑页面并等待返回结果
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => item['route']),
                            );
                            // 处理返回的结果，更新用户信息
                            if (result != null) {
                              setState(() {
                                // 重新初始化设置项列表，使用更新后的用户信息
                                _settingsGroups = [
                                  [
                                    {'icon': '👤', 'title': '个人信息', 'route': EditProfile(userInfo: result)},
                                    {'icon': '📍', 'title': '收货地址', 'route': AddressManagement()},
                                  ],
                                  [
                                    {'icon': '🔄', 'title': '切换账号', 'action': _switchAccount},
                                    {'icon': '🚪', 'title': '退出登录', 'action': _logout},
                                  ],
                                ];
                              });
                              // 传递更新后的用户信息回Mine页面
                              if (mounted) {
                                Navigator.pop(context, result);
                              }
                            }
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => item['route']),
                            );
                          }
                        } else if (item.containsKey('action')) {
                          item['action'](context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                        child: Row(
                          children: [
                            Text(item['icon'], style: TextStyle(fontSize: 20)),
                            SizedBox(width: 12),
                            Expanded(child: Text(item['title'], style: TextStyle(fontSize: 16))),
                            Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
