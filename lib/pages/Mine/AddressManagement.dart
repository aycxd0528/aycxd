import 'package:flutter/material.dart';

class AddressManagement extends StatefulWidget {
  AddressManagement({Key? key}) : super(key: key);

  @override
  _AddressManagementState createState() => _AddressManagementState();
}

class _AddressManagementState extends State<AddressManagement> {
  // 模拟地址数据
  List<Map<String, dynamic>> _addresses = [
    {
      'id': 1,
      'name': '张三',
      'phone': '138****8888',
      'province': '广东省',
      'city': '深圳市',
      'district': '南山区',
      'detail': '科技园南区8栋',
      'isDefault': true,
    },
    {
      'id': 2,
      'name': '李四',
      'phone': '139****9999',
      'province': '北京市',
      'city': '北京市',
      'district': '朝阳区',
      'detail': '国贸大厦A座1001',
      'isDefault': false,
    },
  ];

  // 设置默认地址
  void _setDefaultAddress(int id) {
    setState(() {
      _addresses.forEach((address) {
        address['isDefault'] = (address['id'] == id);
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已设置为默认地址')),
    );
  }

  // 编辑地址
  void _editAddress(Map<String, dynamic> address) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('编辑地址功能开发中')),
    );
  }

  // 删除地址
  void _deleteAddress(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('删除地址'),
          content: Text('确定要删除这个地址吗？'),
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
                setState(() {
                  _addresses.removeWhere((address) => address['id'] == id);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('地址已删除')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // 添加新地址
  void _addNewAddress() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('添加地址功能开发中')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址管理'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          // 地址列表
          Expanded(
            child: ListView.builder(
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                var address = _addresses[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 姓名和电话
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(address['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              Text(address['phone']),
                            ],
                          ),
                          if (address['isDefault']) 
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text('默认', style: TextStyle(color: Colors.red, fontSize: 12)),
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // 地址详情
                      Text(
                        '${address['province']}${address['city']}${address['district']}${address['detail']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 15),
                      // 操作按钮
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => _setDefaultAddress(address['id']),
                            child: Text('设为默认', style: TextStyle(color: Colors.red)),
                          ),
                          TextButton(
                            onPressed: () => _editAddress(address),
                            child: Text('编辑'),
                          ),
                          TextButton(
                            onPressed: () => _deleteAddress(address['id']),
                            child: Text('删除', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 添加地址按钮
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _addNewAddress,
              child: Text('添加新地址'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
