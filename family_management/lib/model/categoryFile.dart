class CategoryFile {
  final String fileId;
  final String fileName;
  final String categoryId;
  final String categoryName;

  CategoryFile({
    required this.fileId,
    required this.fileName,
    required this.categoryId,
    required this.categoryName,
  });

  factory CategoryFile.fromMap(Map<String, dynamic> map) {
    return CategoryFile(
      fileId: map['fileId'] ?? '',
      fileName: map['fileName'] ?? '',
      categoryId: map['categoryId'] ?? '',
      categoryName: map['categoryName'] ?? '',
    );
  }
}
