# Mango Shop

一个基于 Flutter 开发的芒果电商应用，提供商品浏览、分类查看、购物车管理、个人中心等功能。

## 功能特性

### 🛍️ 核心功能
- **主页展示**：轮播图、搜索栏、分类导航、热门商品、为你推荐、更多商品
- **商品分类**：按类别浏览商品，支持全部商品模式
- **购物车**：添加商品、修改数量、删除商品、批量操作、计算总价
- **个人中心**：个人信息管理、订单管理、地址管理、设置
- **用户系统**：登录功能
- **搜索功能**：商品搜索

### 🎨 界面设计
- **现代化 UI**：卡片式设计、渐变色彩、流畅动画
- **响应式布局**：适配不同屏幕尺寸
- **交互体验**：悬停效果、点击反馈、平滑过渡
- **视觉层次**：清晰的信息架构和视觉引导

## 技术栈

- **框架**：Flutter 3.x
- **语言**：Dart
- **状态管理**：setState (基础状态管理)
- **路由管理**：Flutter 内置路由
- **本地存储**：内存存储 (演示模式)
- **UI 组件**：自定义组件 + Flutter 内置组件

## 项目结构

```
mango_shop/
├── lib/
│   ├── assets/           # 静态资源文件
│   ├── components/       # 可复用组件
│   │   └── Home/         # 主页相关组件
│   ├── pages/            # 页面
│   │   ├── Cart/         # 购物车页面
│   │   ├── Category/     # 分类页面
│   │   ├── Home/         # 主页
│   │   ├── Main/         # 主框架页面
│   │   ├── Mine/         # 个人中心页面
│   │   ├── Orders/       # 订单相关页面
│   │   ├── Search/       # 搜索页面
│   │   └── login/        # 登录页面
│   ├── routes/           # 路由配置
│   ├── utils/            # 工具类
│   │   ├── auth_manager.dart    # 认证管理
│   │   ├── colors.dart          # 颜色定义
│   │   └── text_styles.dart     # 文本样式
│   └── main.dart         # 应用入口
├── test/                 # 测试文件
├── web/                  # Web 构建文件
├── README.md             # 项目说明
├── pubspec.yaml          # 依赖配置
└── analysis_options.yaml # 代码分析配置
```

## 安装和运行

### 前提条件
- **Flutter SDK**：3.0 或更高版本
- **Dart SDK**：2.17 或更高版本
- **IDE**：VS Code 或 Android Studio
- **浏览器**：Chrome 或 Edge (Web 模式)

### 安装步骤

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd mango_shop
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **运行项目**
   - **Web 模式**
     ```bash
     flutter run -d chrome
     ```
   - **移动设备**
     ```bash
     flutter run
     ```

### 构建项目

- **构建 Web 版本**
  ```bash
  flutter build web
  ```

- **构建 Android 版本**
  ```bash
  flutter build apk
  ```

- **构建 iOS 版本**
  ```bash
  flutter build ios
  ```

## 开发说明

### 数据管理
- 本项目使用内存存储模拟数据，实际生产环境建议使用：
  - **后端 API**：RESTful API 或 GraphQL
  - **本地存储**：SharedPreferences、SQFlite 或 Hive
  - **状态管理**：Provider、Bloc 或 Riverpod

### 代码规范
- **命名约定**：遵循 Flutter/Dart 命名规范
  - 类名：UpperCamelCase
  - 变量名：lowerCamelCase
  - 文件/文件夹名：snake_case
- **代码风格**：使用 `dart format` 格式化代码
- **代码分析**：使用 `flutter analyze` 检查代码质量

### 自定义组件
项目中的主要自定义组件：
- **MgSlider**：轮播图组件
- **MgCategory**：分类导航组件
- **MgHot**：热门商品组件
- **MgSuggestion**：为你推荐组件
- **MgMoreList**：更多商品组件

## 演示账户

由于本项目处于演示阶段，登录功能使用模拟数据：
- **用户名**：任意输入
- **密码**：任意输入

## 注意事项

1. **演示模式**：本项目为演示版本，使用模拟数据，实际生产环境需要连接真实后端
2. **权限管理**：部分功能（如地址管理）需要完善权限控制
3. **性能优化**：大图片加载和复杂动画可能需要进一步优化
4. **国际化**：当前仅支持中文，可考虑添加国际化支持

## 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目！

## 联系方式

- **项目地址**：<repository-url>
- **开发者**：Mango Shop Team

---

**享受购物的乐趣！** 🍎🍌🥭
