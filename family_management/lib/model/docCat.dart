class DocCategoryData {
  final String categoryId;
  final String categoryName;

  DocCategoryData({
    required this.categoryId,
    required this.categoryName,
  });

  factory DocCategoryData.fromMap(String categoryId, Map<String, dynamic> map) {
    return DocCategoryData(
      categoryId: categoryId,
      categoryName: map['categoryName'] ?? '',
    );
  }
}
