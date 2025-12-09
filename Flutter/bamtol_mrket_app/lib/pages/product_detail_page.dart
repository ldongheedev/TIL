import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ProductDetailPage extends StatefulWidget {
  final String image;
  final String title;
  final String nickname;
  final String time;
  final String price;
  final String location;
  final String description;
  final String category;
  final String status;
  final bool canNegotiate;
  final bool isUserProduct;

  const ProductDetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.nickname,
    required this.time,
    required this.price,
    this.location = '',
    this.description = '',
    this.category = '',
    this.status = '판매중',
    this.canNegotiate = false,
    this.isUserProduct = false,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  LatLng? _locationCoordinates;
  String _roadAddress = '';
  bool _isLoadingLocation = false;

  // Google API Key
  static const String _googleApiKey = 'AIzaSyD27zIB0Qwtwjs7-9b38wMYxjC0dCb24p4';

  // 서울 중심 기본 좌표
  static const LatLng _defaultSeoulCenter = LatLng(37.5665, 126.9780);

  Future<void> _geocodeAddress(String address) async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      // 주소에 "서울"이 없으면 추가
      String searchAddress = address;
      if (!address.contains('서울')) {
        searchAddress = '서울 $address';
      }

      final encodedAddress = Uri.encodeComponent(searchAddress);
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$_googleApiKey&language=ko&region=kr';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint('Geocoding response: ${data['status']}');

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          final result = data['results'][0];
          final location = result['geometry']['location'];
          final formattedAddress = result['formatted_address'];

          setState(() {
            _locationCoordinates = LatLng(location['lat'], location['lng']);
            _roadAddress = formattedAddress;
          });
        } else {
          // API 실패 시 기본 좌표 사용
          debugPrint('Geocoding failed: ${data['status']}');
          setState(() {
            _locationCoordinates = _defaultSeoulCenter;
            _roadAddress = address;
          });
        }
      } else {
        // HTTP 오류 시 기본 좌표 사용
        setState(() {
          _locationCoordinates = _defaultSeoulCenter;
          _roadAddress = address;
        });
      }
    } catch (e) {
      debugPrint('지오코딩 오류: $e');
      // 오류 시 기본 좌표 사용
      setState(() {
        _locationCoordinates = _defaultSeoulCenter;
        _roadAddress = address;
      });
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _showLocationMap() async {
    if (widget.location.isEmpty) return;

    // 주소로 좌표 가져오기
    if (_locationCoordinates == null) {
      await _geocodeAddress(widget.location);
    }

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // 드래그 핸들
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // 헤더
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '거래 희망 장소',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            // 지도
            Expanded(
              child: _isLoadingLocation
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF6F00),
                      ),
                    )
                  : _locationCoordinates != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: _locationCoordinates!,
                            initialZoom: 16,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: _locationCoordinates!,
                                  width: 50,
                                  height: 50,
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Color(0xFFFF6F00),
                                    size: 50,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_off,
                            color: Colors.grey,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '위치를 찾을 수 없습니다',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            // 주소 정보
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFFFF6F00),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.location,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_roadAddress.isNotEmpty &&
                      _roadAddress != widget.location) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.map, color: Colors.grey, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _roadAddress,
                            style: const TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          // 앱바 + 이미지
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFF1E1E1E),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.white),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('공유 기능은 준비 중입니다')),
                  );
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.more_vert, color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(tag: widget.title, child: _buildImage()),
            ),
          ),

          // 상품 정보
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 판매자 정보
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0xFF2C2C2C),
                        child: Text(
                          widget.nickname.isNotEmpty ? widget.nickname[0] : '?',
                          style: const TextStyle(
                            color: Color(0xFFFF6F00),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.nickname,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.location.isNotEmpty
                                  ? widget.location
                                  : '위치 정보 없음',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.isUserProduct)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6F00).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '내 상품',
                            style: TextStyle(
                              color: Color(0xFFFF6F00),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(color: Color(0xFF2C2C2C)),
                  const SizedBox(height: 24),

                  // 카테고리
                  if (widget.category.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.category,
                            color: Color(0xFF9E9E9E),
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.category,
                            style: const TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // 제목
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 시간
                  Text(
                    widget.time,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),

                  const SizedBox(height: 24),

                  // 가격 및 상태 정보
                  Row(
                    children: [
                      // 가격
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: widget.price == '나눔'
                              ? const Color(0xFF1B5E20).withOpacity(0.2)
                              : const Color(0xFFFF6F00).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.price == '나눔'
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFFF6F00),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              widget.price == '나눔'
                                  ? Icons.volunteer_activism
                                  : Icons.sell,
                              color: widget.price == '나눔'
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFFF6F00),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.price,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: widget.price == '나눔'
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFFFF6F00),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // 가격 협상 가능 여부
                      if (widget.canNegotiate)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2196F3).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF2196F3),
                              width: 1.5,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.handshake,
                                color: Color(0xFF2196F3),
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '협상 가능',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2196F3),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  // 거래 상태
                  if (widget.status.isNotEmpty && widget.status != '판매중')
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: widget.status == '예약중'
                              ? const Color(0xFF9C27B0).withOpacity(0.15)
                              : const Color(0xFF616161).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: widget.status == '예약중'
                                ? const Color(0xFF9C27B0)
                                : const Color(0xFF616161),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              widget.status == '예약중'
                                  ? Icons.schedule
                                  : Icons.check_circle,
                              color: widget.status == '예약중'
                                  ? const Color(0xFF9C27B0)
                                  : const Color(0xFF616161),
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.status,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: widget.status == '예약중'
                                    ? const Color(0xFF9C27B0)
                                    : const Color(0xFF616161),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),
                  const Divider(color: Color(0xFF2C2C2C)),
                  const SizedBox(height: 24),

                  // 상품 설명
                  const Text(
                    '상품 설명',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description.isNotEmpty
                        ? widget.description
                        : '상품 설명이 없습니다.',
                    style: const TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),

                  // 거래 희망 장소
                  if (widget.location.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFF2C2C2C)),
                    const SizedBox(height: 24),
                    const Text(
                      '거래 희망 장소',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _showLocationMap,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C2C2C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color(0xFFFF6F00),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.location,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.map,
                              color: Color(0xFF9E9E9E),
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '지도 보기',
                              style: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 100), // 하단 버튼 공간 확보
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).padding.bottom + 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            // 찜 버튼
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF424242)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('찜 목록에 추가되었습니다'),
                      backgroundColor: Color(0xFFFF6F00),
                    ),
                  );
                },
                icon: const Icon(Icons.favorite_border, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            // 채팅 버튼
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('채팅 기능은 준비 중입니다')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6F00),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '채팅하기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    // 웹인 경우 - blob URL이나 네트워크 이미지로 처리
    if (kIsWeb) {
      if (widget.image.startsWith('blob:') || widget.image.startsWith('http')) {
        return Container(
          color: const Color(0xFF2C2C2C),
          child: Image.network(
            widget.image,
            fit: BoxFit.contain,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFF2C2C2C),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 60,
                  ),
                ),
              );
            },
          ),
        );
      }
      // 로컬 에셋인 경우
      return Container(
        color: const Color(0xFF2C2C2C),
        child: Image.asset(
          widget.image,
          fit: BoxFit.contain,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF2C2C2C),
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 60,
                ),
              ),
            );
          },
        ),
      );
    }

    // 모바일 - 파일 경로인 경우 (image_picker로 선택한 이미지)
    if (widget.image.startsWith('/') ||
        widget.image.contains('cache') ||
        widget.image.contains('tmp')) {
      return Container(
        color: const Color(0xFF2C2C2C),
        child: Image.file(
          File(widget.image),
          fit: BoxFit.contain,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF2C2C2C),
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 60,
                ),
              ),
            );
          },
        ),
      );
    }
    // 네트워크 이미지인 경우
    if (widget.image.startsWith('http')) {
      return Container(
        color: const Color(0xFF2C2C2C),
        child: Image.network(
          widget.image,
          fit: BoxFit.contain,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF2C2C2C),
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 60,
                ),
              ),
            );
          },
        ),
      );
    }
    // 로컬 에셋 이미지인 경우
    return Container(
      color: const Color(0xFF2C2C2C),
      child: Image.asset(
        widget.image,
        fit: BoxFit.contain,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFF2C2C2C),
            child: const Center(
              child: Icon(
                Icons.image_not_supported,
                color: Colors.grey,
                size: 60,
              ),
            ),
          );
        },
      ),
    );
  }
}
