import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'nickname_setting_page.dart';

class LocationSettingPage extends StatefulWidget {
  const LocationSettingPage({super.key});

  @override
  State<LocationSettingPage> createState() => _LocationSettingPageState();
}

class _LocationSettingPageState extends State<LocationSettingPage> {
  final TextEditingController _locationController = TextEditingController();
  String? _selectedLocation;
  double _latitude = 37.5665;
  double _longitude = 126.9780;
  final List<String> _myLocations = [];
  bool _isLoadingLocation = false;
  GoogleMapController? _mapController;
  LatLng? _selectedMapLocation;

  // 도로명 주소 관련
  String _currentAddress = '주소를 불러오는 중...';
  bool _isLoadingAddress = false;
  late String _googleApiKey;

  @override
  void initState() {
    super.initState();
    _googleApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    _getCurrentLocation();
    _getAddressFromCoordinates(_latitude, _longitude);
  }

  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    if (_isLoadingAddress) return;

    setState(() {
      _isLoadingAddress = true;
    });

    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$_googleApiKey&language=ko',
      );

      final response = await http.get(url);

      if (response.statusCode == 200 && mounted) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          String address = '';

          for (var result in data['results']) {
            if (result['types'].contains('route') ||
                result['types'].contains('street_address')) {
              address = result['formatted_address'];
              break;
            }
          }

          if (address.isEmpty) {
            address = data['results'][0]['formatted_address'];
          }

          address = address.replaceFirst('대한민국 ', '');

          setState(() {
            _currentAddress = address;
            _isLoadingAddress = false;
          });
        } else {
          setState(() {
            _currentAddress =
                '${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}';
            _isLoadingAddress = false;
          });
        }
      }
    } catch (e) {
      debugPrint('역지오코딩 실패: $e');
      if (mounted) {
        setState(() {
          _currentAddress =
              '${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}';
          _isLoadingAddress = false;
        });
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
          _selectedMapLocation = LatLng(_latitude, _longitude);
          _isLoadingLocation = false;
        });

        // 지도 카메라 이동
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(_latitude, _longitude), 15.0),
        );

        // 주소 가져오기
        _getAddressFromCoordinates(_latitude, _longitude);
      }
    } catch (e) {
      debugPrint('위치 가져오기 실패: $e');
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _selectedMapLocation = position.target;
      _latitude = position.target.latitude;
      _longitude = position.target.longitude;
    });
  }

  void _onCameraIdle() {
    _getAddressFromCoordinates(_latitude, _longitude);
  }

  void _selectCurrentMapLocation() {
    if (_selectedMapLocation != null) {
      final locationName = _currentAddress;
      setState(() {
        if (!_myLocations.contains(locationName)) {
          _myLocations.add(locationName);
        }
        _selectedLocation = locationName;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$locationName 선택됨'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _addLocation() {
    if (_locationController.text.isNotEmpty) {
      setState(() {
        _myLocations.add(_locationController.text);
        _selectedLocation = _locationController.text;
      });
      _locationController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$_selectedLocation 위치가 추가되었습니다!'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _completeLocationSetting() async {
    if (_selectedLocation != null) {
      // 위치 정보 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_location', _selectedLocation!);
      await prefs.setDouble('user_latitude', _latitude);
      await prefs.setDouble('user_longitude', _longitude);

      if (mounted) {
        // 닉네임 페이지로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NicknameSettingPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('위치를 선택해주세요.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text(
          '내 동네 설정',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Google Maps 지도 섹션
            Container(
              margin: const EdgeInsets.all(16),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade700, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_latitude, _longitude),
                        zoom: 15.0,
                      ),
                      onCameraMove: _onCameraMove,
                      onCameraIdle: _onCameraIdle,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                    ),
                    // 중앙 마커
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                    // 도로명 주소 표시
                    Positioned(
                      top: 10,
                      left: 10,
                      right: 60,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
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
                              child: _isLoadingAddress
                                  ? const Row(
                                      children: [
                                        SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Color(0xFFFF6F00),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '주소를 불러오는 중...',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      _currentAddress,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 현재 위치 버튼
                    Positioned(
                      top: 10,
                      right: 10,
                      child: FloatingActionButton.small(
                        onPressed: _getCurrentLocation,
                        backgroundColor: const Color(0xFFFF6F00),
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // 이 위치 선택 버튼
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: ElevatedButton(
                        onPressed: _selectCurrentMapLocation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6F00),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          '이 위치로 선택',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 위치 정보 표시
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade700, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📍 현재 위치',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _isLoadingLocation
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFFFF6F00),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '위도: ${_latitude.toStringAsFixed(6)}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '경도: ${_longitude.toStringAsFixed(6)}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _getCurrentLocation,
                                icon: const Icon(Icons.my_location),
                                label: const Text('현재 위치 다시 가져오기'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF6F00),
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),

            // 위치 입력 섹션
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '위치 입력',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _locationController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: '예: 서울특별시 강남구 역삼동',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: const Color(0xFF2C2C2C),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _addLocation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6F00),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('추가'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 등록된 위치 목록
            if (_myLocations.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '등록된 위치',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _myLocations.map((location) {
                        final isSelected = _selectedLocation == location;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedLocation = location;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$location 선택됨'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFF6F00)
                                  : const Color(0xFF2C2C2C),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFFF6F00)
                                    : Colors.grey,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.check_circle
                                      : Icons.location_on,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  location,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 30),

            // 완료 버튼
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _completeLocationSetting,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6F00),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '위치 설정 완료',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}
