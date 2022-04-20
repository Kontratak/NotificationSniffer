class Item {
  String? app;
  String? data;
  String? image;
  Item(this.app,this.data,this.image);

  Map<String, dynamic> toMap() {
    return {
      'title': app,
      'data': data,
      'image': image
    };
  }

  Item.fromMap(Map<String, dynamic> mapData) {
    this.app = mapData["title"];
    this.data = mapData["data"];
    this.image = mapData["image"];
  }

}