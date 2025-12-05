import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASCII 아트 변환기',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const AsciiArtScreen(),
    );
  }
}

class AsciiArtScreen extends StatefulWidget {
  const AsciiArtScreen({super.key});

  @override
  State<AsciiArtScreen> createState() => _AsciiArtScreenState();
}

class _AsciiArtScreenState extends State<AsciiArtScreen> {
  XFile? _selectedImage;
  Uint8List? _imageBytes;
  String? _asciiArt;
  bool _isLoading = false;
  final ImagePicker _imagePicker = ImagePicker();

  // ASCII 아트 변환 함수
  Future<String> _imageToAsciiArt(XFile imageFile) async {
    // 이미지 로드
    final imageData = await imageFile.readAsBytes();
    final image = img.decodeImage(imageData);

    if (image == null) {
      return '이미지를 로드할 수 없습니다.';
    }

    // 이미지 크기 조정 (ASCII 아트용)
    final resized = img.copyResize(
      image,
      width: 80,
      height: 30,
    );

    // ASCII 문자 세트 (밝기순)
    const String chars = "@%#*+=-:. ";

    StringBuffer result = StringBuffer();

    // 각 픽셀을 ASCII 문자로 변환
    for (int y = 0; y < resized.height; y++) {
      for (int x = 0; x < resized.width; x++) {
        final pixel = resized.getPixelSafe(x, y);
        
        // 픽셀의 밝기 계산 (그레이스케일)
        final brightness = _getPixelBrightness(pixel);
        
        // 0-255를 0-9 범위로 변환하여 ASCII 문자 선택
        final charIndex = ((brightness / 255) * (chars.length - 1)).toInt();
        result.write(chars[charIndex]);
      }
      result.write('\n');
    }

    return result.toString();
  }

  // 픽셀 밝기 계산 함수
  int _getPixelBrightness(dynamic pixel) {
    // 픽셀에서 RGB 추출
    final r = pixel.r.toInt();
    final g = pixel.g.toInt();
    final b = pixel.b.toInt();

    // 표준 밝기 계산 공식
    return ((r * 299 + g * 587 + b * 114) / 1000).toInt();
  }

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = pickedFile;
        _imageBytes = imageBytes;
        _asciiArt = null;
      });
    }
  }

  // ASCII 아트 생성 함수
  Future<void> _generateAsciiArt() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('먼저 이미지를 선택하세요.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _imageToAsciiArt(_selectedImage!);
      setState(() {
        _asciiArt = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASCII 아트 변환기'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 선택된 이미지 표시
              if (_imageBytes != null)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      _imageBytes!,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '이미지를 선택하세요',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // 버튼들
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text('이미지 선택'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _generateAsciiArt,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.auto_awesome),
                      label: Text(_isLoading ? '변환중...' : 'ASCII로 변환'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ASCII 아트 결과 표시
              if (_asciiArt != null)
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _asciiArt!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Courier New',
                              fontSize: 14,
                              color: Colors.greenAccent,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else if (_selectedImage != null && !_isLoading)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    '"ASCII로 변환" 버튼을 눌러 변환을 시작하세요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
