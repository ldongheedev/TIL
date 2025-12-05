class MarketEnum {
  static const String statusForSale = '판매중';
  static const String statusReserved = '예약중';
  static const String statusSold = '판매완료';

  static const List<String> categories = [
    '의류',
    '신발',
    '가방',
    '전자기기',
    '가구',
    '책',
    '스포츠',
    '반려동물',
    '뷰티',
    '기타',
  ];

  static const List<String> statuses = [
    statusForSale,
    statusReserved,
    statusSold,
  ];
}
