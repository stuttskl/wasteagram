class NewPostDTO {
  String imgUrl;
  double lat;
  double long;
  int quantity;
  DateTime timeStamp;

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'lat': lat,
      'long': long,
      'quantity': quantity,
      'timeStamp': timeStamp
    };
  }
}
