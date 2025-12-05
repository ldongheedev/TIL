import 'package:flutter/material.dart';

class MultipleImageView extends StatefulWidget {
  final List<String> images;
  final VoidCallback onAddImage;
  final Function(int index)? onRemoveImage;
  final int maxImages;

  const MultipleImageView({
    Key? key,
    required this.images,
    required this.onAddImage,
    this.onRemoveImage,
    this.maxImages = 10,
  }) : super(key: key);

  @override
  State<MultipleImageView> createState() => _MultipleImageViewState();
}

class _MultipleImageViewState extends State<MultipleImageView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '사진 (최대 10장)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Add image button
              if (widget.images.length < widget.maxImages)
                GestureDetector(
                  onTap: widget.onAddImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Colors.grey,
                      size: 32,
                    ),
                  ),
                ),
              if (widget.images.length < widget.maxImages)
                const SizedBox(width: 8),

              // Image list
              ...widget.images.asMap().entries.map((entry) {
                int index = entry.key;
                String image = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFF2C2C2C),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _buildImage(image),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => widget.onRemoveImage?.call(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${widget.images.length}/${widget.maxImages}',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildImage(String image) {
    // 네트워크 이미지인 경우
    if (image.startsWith('http')) {
      return Image.network(
        image,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 100,
            color: const Color(0xFF2C2C2C),
            child: const Icon(Icons.broken_image, color: Colors.grey),
          );
        },
      );
    }
    // 로컬 에셋 이미지인 경우
    return Image.asset(
      image,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 100,
          height: 100,
          color: const Color(0xFF2C2C2C),
          child: const Icon(Icons.image, color: Colors.grey),
        );
      },
    );
  }
}
