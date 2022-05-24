class Category {
  String? title;
  String? description;
  int? isActive;
  String? imagePath;
  int? id;

  Category(
      {this.title, this.description, this.isActive, this.imagePath, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isActive = json['is_active'];
    imagePath = json['image_path'];
    id = json['id'];
  }
}
