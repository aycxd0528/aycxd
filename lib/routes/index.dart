//管理路由
import 'package:flutter/material.dart';
import 'package:mango_shop/pages/Main/index.dart';
import 'package:mango_shop/pages/login/index.dart';
import 'package:mango_shop/pages/Search/index.dart';

//返回APP根级组件
Widget getRootWidget(){
   return MaterialApp(
    //命名路由
    routes: getRootRoutes(),
   );
}
Map<String, Widget Function(BuildContext)> getRootRoutes(){
  return {
    "/": (context) => Mainpage(),//主页路由
    "/login": (context) => LoginPage(),//登录路由
    "/search": (context) => SearchView(),//搜索页面路由
  };
}