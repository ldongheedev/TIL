import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/write_post_page.dart';
import 'repositories/product_repository.dart';
import 'intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          centerTitle: false,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 8,
          selectedItemColor: Color(0xFFFF6F00),
          unselectedItemColor: Color(0xFF757575),
        ),
        dividerColor: Color(0xFF2C2C2C),
      ),
      themeMode: ThemeMode.dark,
      home: const IntroPage(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final GlobalKey<_HomePageState> _homeKey = GlobalKey<_HomePageState>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(key: _homeKey),
      const CommunityPage(),
      const NearPage(),
      const ChatPage(),
      const MyPage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WritePostPage()),
          );
          // 글쓰기 완료 후 홈 화면 새로고침
          if (result == true && _currentIndex == 0) {
            _homeKey.currentState?.refreshProducts();
          }
        },
        backgroundColor: const Color(0xFFFF6F00),
        elevation: 6,
        icon: SvgPicture.asset(
          'assets/svg/icons/plus.svg',
          width: 19.2,
          height: 19.2,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        label: const Text(
          '글쓰기',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  _currentIndex == 0
                      ? 'assets/svg/icons/home-on.svg'
                      : 'assets/svg/icons/home-off.svg',
                  width: 26,
                  height: 26,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 0
                        ? const Color(0xFFFF6F00)
                        : const Color(0xFF757575),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  _currentIndex == 1
                      ? 'assets/svg/icons/arround-life-on.svg'
                      : 'assets/svg/icons/arround-life-off.svg',
                  width: 26,
                  height: 26,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 1
                        ? const Color(0xFFFF6F00)
                        : const Color(0xFF757575),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: '동네생활',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  _currentIndex == 2
                      ? 'assets/svg/icons/near-on.svg'
                      : 'assets/svg/icons/near-off.svg',
                  width: 26,
                  height: 26,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 2
                        ? const Color(0xFFFF6F00)
                        : const Color(0xFF757575),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: '내 근처',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  _currentIndex == 3
                      ? 'assets/svg/icons/chat-on.svg'
                      : 'assets/svg/icons/chat-off.svg',
                  width: 26,
                  height: 26,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 3
                        ? const Color(0xFFFF6F00)
                        : const Color(0xFF757575),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: '채팅',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  _currentIndex == 4
                      ? 'assets/svg/icons/my-on.svg'
                      : 'assets/svg/icons/my-off.svg',
                  width: 26,
                  height: 26,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 4
                        ? const Color(0xFFFF6F00)
                        : const Color(0xFF757575),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: '나의 활동',
            ),
          ],
        ),
      ),
    );
  }
}

// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductRepository _repository = ProductRepository();
  List<Map<String, dynamic>> _userProducts = [];
  String _userNickname = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadProducts();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userNickname = prefs.getString('user_nickname') ?? '사용자';
    });
  }

  Future<void> _loadProducts() async {
    final products = await _repository.getProducts();
    setState(() {
      _userProducts = products;
    });
  }

  void refreshProducts() {
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    // 사용자 등록 상품 + 샘플 상품 합치기
    final allProducts = [
      ..._userProducts.map(
        (p) => Product(
          image: p['images']?.isNotEmpty == true
              ? p['images'][0]
              : 'assets/images/default_profile.png',
          title: p['title'] ?? '제목 없음',
          nickname: _userNickname,
          time: '방금 전',
          price: p['price'] != null ? '${p['price']}원' : '가격 미정',
          location: p['location'] ?? '',
          description: p['description'] ?? '',
          isUserProduct: true,
        ),
      ),
      ..._sampleProducts,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '아리동',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              'assets/svg/icons/bottom_arrow.svg',
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                Colors.white70,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/svg/icons/search.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white70,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/svg/icons/list.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white70,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Stack(
              children: [
                SvgPicture.asset(
                  'assets/svg/icons/bell.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.white70,
                    BlendMode.srcIn,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6F00),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: allProducts.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 60,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '등록된 상품이 없습니다',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '첫 번째 상품을 등록해보세요!',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadProducts,
              color: const Color(0xFFFF6F00),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: allProducts.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                itemBuilder: (context, index) {
                  final product = allProducts[index];
                  return ProductItem(product: product);
                },
              ),
            ),
    );
  }
}

// 상품 데이터 모델
class Product {
  final String image;
  final String title;
  final String nickname;
  final String time;
  final String price;
  final String location;
  final String description;
  final bool isUserProduct;

  Product({
    required this.image,
    required this.title,
    required this.nickname,
    required this.time,
    required this.price,
    this.location = '',
    this.description = '',
    this.isUserProduct = false,
  });
}

// 샘플 데이터
final List<Product> _sampleProducts = [
  Product(
    image: 'assets/images/apple.png',
    title: '애플 맥북 프로 16인치 M3 Max 팝니다',
    nickname: '테크러버',
    time: '1시간 전',
    price: '2,500,000원',
  ),
  Product(
    image: 'assets/images/google.png',
    title: '구글 픽셀 8 프로 새제품 미개봉',
    nickname: '당근마켓',
    time: '2시간 전',
    price: '나눔',
  ),
  Product(
    image: 'assets/images/logo_simbol.png',
    title: '브랜드 로고 디자인 작업 해드립니다',
    nickname: '디자인스튜디오',
    time: '3시간 전',
    price: '50,000원',
  ),
  Product(
    image: 'assets/images/default_profile.png',
    title: '아이폰 15 프로 맥스 256GB 티타늄',
    nickname: '애플매니아',
    time: '5시간 전',
    price: '1,200,000원',
  ),
  Product(
    image: 'assets/images/apple.png',
    title: '애플워치 울트라 2 오션밴드 포함',
    nickname: '시계수집가',
    time: '1일 전',
    price: '800,000원',
  ),
  Product(
    image: 'assets/images/google.png',
    title: '구글 네스트 허브 2세대 스마트홈',
    nickname: '스마트홈지기',
    time: '1일 전',
    price: '나눔',
  ),
  Product(
    image: 'assets/images/logo_simbol.png',
    title: '무료 상담 받아가세요 (선착순)',
    nickname: '전문가',
    time: '2일 전',
    price: '나눔',
  ),
  Product(
    image: 'assets/images/apple.png',
    title: '에어팟 프로 2세대 USB-C',
    nickname: '음악듣기',
    time: '3일 전',
    price: '180,000원',
  ),
];

// 상품 아이템 위젯
class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 왼쪽 이미지
            Hero(
              tag: product.title,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _buildProductImage(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // 오른쪽 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  // 제목
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.3,
                      letterSpacing: -0.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // 닉네임과 시간
                  Row(
                    children: [
                      Text(
                        product.nickname,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 2,
                        height: 2,
                        decoration: const BoxDecoration(
                          color: Color(0xFF616161),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.time,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 가격
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: product.price == '나눔'
                          ? const Color(0xFF1B5E20).withOpacity(0.2)
                          : const Color(0xFFFF6F00).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: product.price == '나눔'
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFFF6F00),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      product.price,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: product.price == '나눔'
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFFF6F00),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    // 네트워크 이미지인 경우 (http로 시작)
    if (product.image.startsWith('http')) {
      return Image.network(
        product.image,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80,
            height: 80,
            color: const Color(0xFF2C2C2C),
            child: const Icon(Icons.image_not_supported, color: Colors.grey),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 80,
            height: 80,
            color: const Color(0xFF2C2C2C),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFFFF6F00),
              ),
            ),
          );
        },
      );
    }
    // 로컬 에셋 이미지인 경우
    return Image.asset(
      product.image,
      width: 80,
      height: 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 80,
          height: 80,
          color: const Color(0xFF2C2C2C),
          child: const Icon(
            Icons.shopping_bag,
            color: Color(0xFFFF6F00),
            size: 40,
          ),
        );
      },
    );
  }
}

// 동네 생활 페이지
class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '동네생활',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/icons/arround-life-on.svg',
              width: 80,
              height: 80,
              colorFilter: const ColorFilter.mode(
                Color(0xFF424242),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '동네생활 준비중',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 내 근처 페이지
class NearPage extends StatelessWidget {
  const NearPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내 근처',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/icons/near-on.svg',
              width: 80,
              height: 80,
              colorFilter: const ColorFilter.mode(
                Color(0xFF424242),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '내 근처 준비중',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 채팅 페이지
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '채팅',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/icons/chat-on.svg',
              width: 80,
              height: 80,
              colorFilter: const ColorFilter.mode(
                Color(0xFF424242),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '채팅 준비중',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 나의 활동 페이지
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '나의 활동',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/icons/my-on.svg',
              width: 80,
              height: 80,
              colorFilter: const ColorFilter.mode(
                Color(0xFF424242),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '나의 활동 준비중',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
