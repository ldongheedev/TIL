import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home/controllers/product_write_controller.dart';
import 'package:home/constants/market_enum.dart';
import 'package:home/repositories/product_repository.dart';
import 'package:home/widgets/custom_textfield.dart';
import 'package:home/widgets/custom_checkbox.dart';
import 'package:home/widgets/price_view.dart';
import 'package:home/widgets/custom_button.dart';
import 'package:home/widgets/multiple_image_view.dart';
import 'package:home/src/common/components/trade_location_map.dart';

class WritePostPage extends StatefulWidget {
  const WritePostPage({super.key});

  @override
  State<WritePostPage> createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  late ProductWriteController _controller;
  final ProductRepository _repository = ProductRepository();
  bool _isLoading = false;
  List<String> _mockImages = [];
  String? _selectedLocationLabel;
  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _controller = ProductWriteController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상품 등록'),
        backgroundColor: const Color(0xFF212123),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF212123),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6F00)),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 사진 추가
                  MultipleImageView(
                    images: _mockImages,
                    onAddImage: _addImage,
                    onRemoveImage: _removeImage,
                  ),
                  const SizedBox(height: 24),

                  // 카테고리 선택
                  _buildCategorySection(),
                  const SizedBox(height: 20),

                  // 제목
                  _buildTitleSection(),
                  const SizedBox(height: 20),

                  // 가격
                  _buildPriceSection(),
                  const SizedBox(height: 20),

                  // 거래 위치
                  _buildLocationSection(),
                  const SizedBox(height: 20),

                  // 상품 설명
                  _buildDescriptionSection(),
                  const SizedBox(height: 20),

                  // 거래 방식
                  _buildTradeStatusSection(),
                  const SizedBox(height: 20),

                  // 가격 협상 가능 여부
                  CustomCheckbox(
                    value: _controller.canNegotiate,
                    onChanged: (value) {
                      setState(() {
                        _controller.canNegotiate = value ?? false;
                      });
                    },
                    label: '가격 협상 가능',
                  ),
                  const SizedBox(height: 30),

                  // 버튼들
                  _buildActionButtons(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '카테고리',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: _controller.selectedCategory,
            hint: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('카테고리를 선택하세요', style: TextStyle(color: Colors.grey)),
            ),
            isExpanded: true,
            dropdownColor: const Color(0xFF2C2C2C),
            underline: Container(),
            items: MarketEnum.categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    category,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _controller.selectedCategory = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '제목',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: _controller.titleController,
          hintText: '상품 제목을 입력하세요',
          maxLength: 100,
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '가격',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: _controller.priceController,
          hintText: '0',
          keyboardType: TextInputType.number,
          prefixText: '₩ ',
          onChanged: (value) {
            setState(() {});
          },
        ),
        if (_controller.priceController.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: PriceView(
              price: double.tryParse(_controller.priceController.text) ?? 0,
              textStyle: const TextStyle(
                color: Color(0xFFFF6F00),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '거래 희망 장소',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push<Map<String, dynamic>>(
              context,
              MaterialPageRoute(
                builder: (context) => TradeLocationMap(
                  label: _selectedLocationLabel,
                  location: _selectedLocation,
                ),
              ),
            );
            if (result != null) {
              setState(() {
                _selectedLocationLabel = result['label'];
                _selectedLocation = result['location'];
                _controller.locationController.text =
                    _selectedLocationLabel ?? '';
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedLocationLabel ?? '지도에서 거래 장소를 선택하세요',
                          style: TextStyle(
                            color: _selectedLocationLabel != null
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedLocationLabel != null)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLocationLabel = null;
                        _selectedLocation = null;
                        _controller.locationController.text = '';
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.close, color: Colors.grey, size: 18),
                    ),
                  )
                else
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
              ],
            ),
          ),
        ),
        if (_selectedLocation != null) ...[
          const SizedBox(height: 4),
          Text(
            '좌표: $_selectedLocation',
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '상품 설명',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: _controller.descriptionController,
          hintText: '상품에 대해 자세히 설명해주세요',
          maxLines: 5,
          maxLength: 1000,
        ),
      ],
    );
  }

  Widget _buildTradeStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '거래 상태',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: _controller.selectedStatus,
            hint: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('거래 상태를 선택하세요', style: TextStyle(color: Colors.grey)),
            ),
            isExpanded: true,
            dropdownColor: const Color(0xFF2C2C2C),
            underline: Container(),
            items: MarketEnum.statuses.map((String status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _controller.selectedStatus = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomButton(label: '상품 등록하기', onPressed: _submitProduct),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            label: '취소',
            onPressed: () => Navigator.pop(context),
            isOutlined: true,
            backgroundColor: Colors.grey,
          ),
        ),
      ],
    );
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _addImage() async {
    if (_mockImages.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('최대 10장까지 추가할 수 있습니다'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 선택 옵션 보여주기
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color(0xFFFF6F00),
              ),
              title: const Text(
                '갤러리에서 선택',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFFFF6F00)),
              title: const Text(
                '카메라로 촬영',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (images.isNotEmpty) {
        final remainingSlots = 10 - _mockImages.length;
        final imagesToAdd = images.take(remainingSlots).toList();

        setState(() {
          for (var image in imagesToAdd) {
            _mockImages.add(image.path);
          }
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${imagesToAdd.length}장의 이미지가 추가되었습니다'),
              backgroundColor: const Color(0xFFFF6F00),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('이미지 선택 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('이미지를 불러올 수 없습니다'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        setState(() {
          _mockImages.add(image.path);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('사진이 추가되었습니다'),
              backgroundColor: Color(0xFFFF6F00),
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('카메라 촬영 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('카메라를 사용할 수 없습니다'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _mockImages.removeAt(index);
    });
  }

  Future<void> _submitProduct() async {
    if (_controller.titleController.text.isEmpty) {
      _showErrorSnackBar('제목을 입력해주세요');
      return;
    }
    if (_controller.selectedCategory == null) {
      _showErrorSnackBar('카테고리를 선택해주세요');
      return;
    }
    if (_controller.priceController.text.isEmpty) {
      _showErrorSnackBar('가격을 입력해주세요');
      return;
    }
    if (_selectedLocationLabel == null || _selectedLocationLabel!.isEmpty) {
      _showErrorSnackBar('거래 희망 장소를 선택해주세요');
      return;
    }
    if (_controller.descriptionController.text.isEmpty) {
      _showErrorSnackBar('상품 설명을 입력해주세요');
      return;
    }

    // 등록 확인 다이얼로그
    final shouldRegister = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          '상품 등록',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          '이 상품을 등록하시겠습니까?',
          style: TextStyle(color: Color(0xFFBDBDBD), fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              '등록',
              style: TextStyle(
                color: Color(0xFFFF6F00),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (shouldRegister != true) return;

    // 로딩 다이얼로그 표시
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: Color(0xFF2C2C2C),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFFFF6F00),
                    strokeWidth: 3,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '등록 중...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    try {
      // 컨트롤러에 이미지와 위치 설정
      _controller.selectedImages = _mockImages;
      _controller.selectedTradeLocation = _selectedLocationLabel;

      final productData = _controller.getProductData();
      final success = await _repository.saveProduct(productData);

      // 2초 대기
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // 로딩 다이얼로그 닫기
        Navigator.pop(context);

        if (success) {
          // 성공 메시지와 함께 메인으로 이동
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('상품이 등록되었습니다!'),
              backgroundColor: Color(0xFFFF6F00),
            ),
          );
          Navigator.pop(context, true); // 메인 페이지로 이동
        } else {
          _showErrorSnackBar('상품 등록에 실패했습니다');
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // 로딩 다이얼로그 닫기
        _showErrorSnackBar('오류 발생: $e');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFFF6F00),
      ),
    );
  }
}
