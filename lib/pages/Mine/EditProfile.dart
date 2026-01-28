import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final Map<String, dynamic>? userInfo;
  
  EditProfile({Key? key, this.userInfo}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // 用户数据
  late Map<String, dynamic> _userInfo;

  @override
  void initState() {
    super.initState();
    // 初始化用户数据，如果没有传递则使用默认值
    _userInfo = widget.userInfo ?? {
      'avatar': 'lib/assets/ic_public_my_active.png',
      'nickname': '芒果用户',
      'phone': '138****8888',
      'email': 'user@example.com',
    };
    // 初始化控制器
    _nicknameController.text = _userInfo['nickname'] ?? '';
    _emailController.text = _userInfo['email'] ?? '';
  }

  // 表单控制器
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // 释放控制器
    _nicknameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // 保存修改
  void _saveChanges() {
    setState(() {
      _userInfo['nickname'] = _nicknameController.text;
      _userInfo['email'] = _emailController.text;
    });
    // 传递更新后的用户信息回Mine页面
    Navigator.pop(context, _userInfo);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('个人信息已更新')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑个人信息'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // 头像编辑
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage(_userInfo['avatar']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('更换头像功能开发中')),
                    );
                  },
                  child: Text('更换头像', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // 表单字段
          _buildFormItem('昵称', _nicknameController),
          _buildFormItem('手机号', null, enabled: false, value: _userInfo['phone']),
          _buildFormItem('邮箱', _emailController),

          SizedBox(height: 40),

          // 保存按钮
          ElevatedButton(
            onPressed: _saveChanges,
            child: Text('保存修改'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 15),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // 构建表单项
  Widget _buildFormItem(String label, TextEditingController? controller, {bool enabled = true, String? value}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              hintText: value,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
