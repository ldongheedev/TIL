import 'package:flutter/material.dart';
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

  // 로컬 에셋 이미지 목록 (실제 앱에서는 갤러리에서 선택)
  final List<String> _availableImages = [
    'assets/images/apple.png',
    'assets/images/google.png',
    'assets/images/logo_simbol.png',
    'assets/images/default_profile.png',
  ];

  void _addImage() {
    if (_mockImages.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('최대 10장까지 추가할 수 있습니다'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 로컬 에셋에서 순환하여 이미지 추가
    final imageIndex = _mockImages.length % _availableImages.length;
    setState(() {
      _mockImages.add(_availableImages[imageIndex]);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('이미지가 추가되었습니다'),
        backgroundColor: Color(0xFFFF6F00),
        duration: Duration(seconds: 1),
      ),
    );
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

    setState(() => _isLoading = true);

    try {
      final productData = _controller.getProductData();
      final success = await _repository.saveProduct(productData);

      if (mounted) {
        setState(() => _isLoading = false);

        if (success) {
          _showSuccessSnackBar('상품이 등록되었습니다!');
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.pop(context, true); // 등록 성공 시 true 반환
            }
          });
        } else {
          _showErrorSnackBar('상품 등록에 실패했습니다');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
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
