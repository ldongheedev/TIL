import 'package:home/src/common/components/app_font.dart';
import 'package:home/src/common/components/place_name_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TradeLocationMap extends StatefulWidget {
  final String? label;
  final String? location; // "lat,lng" format
  const TradeLocationMap({super.key, this.label, this.location});

  @override
  State<TradeLocationMap> createState() => _TradeLocationMapState();
}

class _TradeLocationMapState extends State<TradeLocationMap> {
  final MapController _mapController = MapController();
  String label = '';
  late LatLng initialLocation;
  late LatLng currentCenter;
  String currentAddress = '주소를 불러오는 중...';
  bool isLoadingAddress = false;

  @override
  void initState() {
    super.initState();
    label = widget.label ?? '';

    // Default to Seoul
    initialLocation = const LatLng(37.5665, 126.9780);
    currentCenter = initialLocation;

    // Parse "lat,lng" string to LatLng if provided
    if (widget.location != null && widget.location!.contains(',')) {
      final parts = widget.location!.split(',');
      final lat = double.tryParse(parts[0].trim());
      final lng = double.tryParse(parts[1].trim());
      if (lat != null && lng != null) {
        initialLocation = LatLng(lat, lng);
        currentCenter = initialLocation;
      }
    }

    // Try to get current location in background
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryGetCurrentLocation();
      _getAddressFromCoordinates(currentCenter);
    });
  }

  // Google Maps API Key
  static const String _googleApiKey = 'AIzaSyD27zIB0Qwtwjs7-9b38wMYxjC0dCb24p4';

  Future<void> _getAddressFromCoordinates(LatLng location) async {
    if (isLoadingAddress) return;

    setState(() {
      isLoadingAddress = true;
    });

    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&key=$_googleApiKey&language=ko',
      );

      final response = await http.get(url);

      if (response.statusCode == 200 && mounted) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          // 도로명 주소 또는 지번 주소 찾기
          String address = '';

          for (var result in data['results']) {
            // 도로명 주소 우선
            if (result['types'].contains('route') ||
                result['types'].contains('street_address')) {
              address = result['formatted_address'];
              break;
            }
          }

          // 도로명 주소가 없으면 첫 번째 결과 사용
          if (address.isEmpty) {
            address = data['results'][0]['formatted_address'];
          }

          // "대한민국 " 제거
          address = address.replaceFirst('대한민국 ', '');

          setState(() {
            currentAddress = address;
            isLoadingAddress = false;
          });
        } else {
          setState(() {
            currentAddress =
                '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
            isLoadingAddress = false;
          });
        }
      }
    } catch (e) {
      debugPrint('역지오코딩 실패: $e');
      if (mounted) {
        setState(() {
          currentAddress =
              '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
          isLoadingAddress = false;
        });
      }
    }
  }

  Future<void> _tryGetCurrentLocation() async {
    try {
      final position = await _determinePosition();
      final newLocation = LatLng(position.latitude, position.longitude);
      if (mounted) {
        _mapController.move(newLocation, 15.0);
        setState(() {
          currentCenter = newLocation;
        });
      }
    } catch (e) {
      debugPrint('위치 가져오기 실패: $e');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('위치 서비스가 비활성화되었습니다');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('위치 권한이 거부되었습니다');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('위치 권한을 영구적으로 거부하여 권한 요청이 불가합니다.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _onMapEvent(MapEvent event) {
    if (event is MapEventMove) {
      setState(() {
        currentCenter = _mapController.camera.center;
        if (label.isNotEmpty) {
          label = '';
        }
      });
    }
    // 지도 이동이 끝났을 때 주소 조회
    if (event is MapEventMoveEnd) {
      setState(() {
        currentCenter = _mapController.camera.center;
      });
      _getAddressFromCoordinates(currentCenter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff212123),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const AppFont('거래 희망 장소', fontWeight: FontWeight.bold, size: 18),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppFont(
                  '이웃과 만나서\n거래하고 싶은 장소를 선택해주세요.',
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
                SizedBox(height: 15),
                AppFont(
                  '만남 거래는 찾기 쉬운 공공장소가 좋아요',
                  size: 13,
                  color: Color(0xff6D7179),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: initialLocation,
                    initialZoom: 15.0,
                    onMapEvent: _onMapEvent,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                  ],
                ),
                // Center marker
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Icon(Icons.location_on, color: Colors.red, size: 50),
                  ),
                ),
                // Label if set
                if (label.isNotEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                          ),
                          child: AppFont(label, color: Colors.black, size: 12),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                // Address display
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
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
                          color: Color(0xffED7738),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: isLoadingAddress
                              ? const Row(
                                  children: [
                                    SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Color(0xffED7738),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '주소를 불러오는 중...',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  currentAddress,
                                  style: const TextStyle(
                                    fontSize: 13,
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
                // Select button at bottom
                Positioned(
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).padding.bottom + 15,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        var result = await showDialog<String>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const PlaceNamePopup(),
                        );
                        if (result != null && mounted) {
                          Navigator.of(context).pop({
                            'label': result,
                            'location':
                                '${currentCenter.latitude},${currentCenter.longitude}',
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffED7738),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        '이 위치로 선택',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 80,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            try {
              final position = await _determinePosition();
              final newLocation = LatLng(position.latitude, position.longitude);
              _mapController.move(newLocation, 15.0);
              setState(() {
                currentCenter = newLocation;
              });
              _getAddressFromCoordinates(newLocation);
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('현재 위치를 가져올 수 없습니다')),
                );
              }
            }
          },
          backgroundColor: const Color(0xff212123),
          child: const Icon(Icons.my_location, color: Colors.white),
        ),
      ),
    );
  }
}
