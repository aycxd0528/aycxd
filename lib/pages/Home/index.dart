 import 'package:flutter/material.dart';
import 'package:mango_shop/components/Home/MgSlider/MgSlider.dart';
import 'package:mango_shop/components/Home/MgCategory/MgCategory.dart';
import 'package:mango_shop/components/Home/MgHot/MgHot.dart';
import 'package:mango_shop/components/Home/MgSuggestion/MgSuggestion.dart';
import 'package:mango_shop/components/Home/MgMoreList/MgMoreList.dart';
import 'package:mango_shop/utils/colors.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 轮播图和搜索栏
          Stack(
            children: [
              // 轮播图
              Container(
                width: double.infinity,
                child: Mgslider(),
              ),
              // 透明搜索栏（置顶）
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    // 搜索栏点击事件
                    print('搜索栏被点击');
                    // 跳转到搜索页面
                    Navigator.pushNamed(context, '/search');
                  },
                  child: AnimatedScale(
                    duration: Duration(milliseconds: 100),
                    scale: 1.0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Icon(Icons.search, color: AppColors.textHint, size: 20),
                          SizedBox(width: 12),
                          Text('搜索商品', style: TextStyle(color: AppColors.textHint, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 分类导航
          Mgcategory(),
          // 热门商品
          Mghot(),
          // 推荐商品
          Mgsuggestion(),
          // 更多商品列表
          MgmoreList(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}