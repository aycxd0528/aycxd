import 'package:flutter/material.dart';
import 'package:mango_shop/utils/colors.dart';
import 'package:mango_shop/utils/text_styles.dart';

class Mgcategory extends StatefulWidget {
  Mgcategory({Key? key}) : super(key: key);

  @override
  _MgcategoryState createState() => _MgcategoryState();
}

class _MgcategoryState extends State<Mgcategory> {
  final List<Map<String, dynamic>> _categories = [
    {'name': '芒果', 'icon': 'lib/assets/220c3184-fec6-4c46-8606-67015ed201cc.png'},
    {'name': '水果', 'icon': 'lib/assets/苹果.png'},
    {'name': '蔬菜', 'icon': 'lib/assets/白菜.png'},
    {'name': '零食', 'icon': 'lib/assets/薯片.png'},
    {'name': '饮料', 'icon': 'lib/assets/可乐.png'},
    {'name': '肉禽', 'icon': 'lib/assets/猪肉.png'},
    {'name': '水产', 'icon': 'lib/assets/鱼.png'},
    {'name': '更多', 'icon': 'lib/assets/调味品.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 6 : 4;
    final iconSize = screenWidth > 600 ? 72.0 : 64.0;
    
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: AppColors.white,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 24,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 分类点击事件
              print('分类 ${_categories[index]['name']} 被点击');
            },
            child: Column(
              children: [
                AnimatedScale(
                  duration: Duration(milliseconds: 200),
                  scale: 1.0,
                  child: Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(iconSize / 2),
                      image: DecorationImage(
                        image: AssetImage(_categories[index]['icon']),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  _categories[index]['name'],
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}