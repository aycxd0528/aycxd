// 登录状态管理类
class AuthManager {
  // 单例实例
  static final AuthManager _instance = AuthManager._internal();
  
  // 工厂构造函数
  factory AuthManager() {
    return _instance;
  }
  
  // 内部构造函数
  AuthManager._internal();
  
  // 用户信息
  Map<String, dynamic>? _userInfo;
  
  // 是否登录
  bool get isLoggedIn => _userInfo != null;
  
  // 获取用户信息
  Map<String, dynamic>? get userInfo => _userInfo;
  
  // 登录
  void login(Map<String, dynamic> userInfo) {
    _userInfo = userInfo;
  }
  
  // 退出登录
  void logout() {
    _userInfo = null;
  }
}
