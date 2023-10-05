class Blog {
  late String _id;
  late String title;
  late String imageUrl;
  bool isFavorite = false;

  String get id => _id;

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'title': title,
      'image_url': imageUrl,
    };
  }
  
  Blog.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    title = map['title'];
    imageUrl = map['image_url'];
  }
  
  Blog({required String id, required this.title, required this.imageUrl}) : _id = id;
}