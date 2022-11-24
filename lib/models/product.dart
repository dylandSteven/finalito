class Producto {
  int    id;
  String title;
  String image;
  String imageType;
  bool isFavorite;

  Producto(this.id, this.title, this.image, this.imageType,this.isFavorite);

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'title': title,
      'image': image,
      'imageType': imageType,
    };
  }
}
