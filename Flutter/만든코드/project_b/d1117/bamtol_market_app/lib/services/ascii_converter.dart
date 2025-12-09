import 'dart:typed_data';
import 'package:image/image.dart' as img;

class AsciiConverter {
  // ASCII 문자 팔레트 (밝기순)
  static const String asciiChars = '@%#*+=-:. ';

  /// 이미지를 ASCII 아트로 변환
  static String convertImageToAscii(
    Uint8List imageData, {
    int width = 100,
    int height = 40,
  }) {
    try {
      // 이미지 디코딩
      img.Image? image = img.decodeImage(imageData);
      if (image == null) {
        return 'Error: Could not decode image';
      }

      // 이미지를 지정된 크기로 리사이징
      img.Image resized = img.copyResize(
        image,
        width: width,
        height: height,
      );

      StringBuffer ascii = StringBuffer();

      // 각 픽셀을 ASCII 문자로 변환
      for (int y = 0; y < resized.height; y++) {
        for (int x = 0; x < resized.width; x++) {
          final pixel = resized.getPixelSafe(x, y);
          
          // 그레이스케일 값 계산 (0-255)
          int gray = _getGrayscaleFromPixel(pixel);
          
          // 밝기 값을 ASCII 문자로 매핑
          int charIndex = (gray * (asciiChars.length - 1)) ~/ 255;
          ascii.write(asciiChars[charIndex]);
        }
        ascii.write('\n');
      }

      return ascii.toString();
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// 픽셀의 그레이스케일 값 계산
  static int _getGrayscaleFromPixel(dynamic pixel) {
    // 픽셀에서 RGBA 값 추출
    int r = (pixel.r as int);
    int g = (pixel.g as int);
    int b = (pixel.b as int);

    // 표준 그레이스케일 계산
    return ((0.299 * r + 0.587 * g + 0.114 * b).round());
  }
}
