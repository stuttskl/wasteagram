class Post {
  final int id;
  final String imgUrl;
  final double lat;
  final double long;
  final int quantity;
  final String timeStamp;

  Post(
      {this.id,
      this.imgUrl,
      this.lat,
      this.long,
      this.quantity,
      this.timeStamp});

  Map<String, dynamic> fromMap() {
    return {
      'timeStamp': timeStamp,
      'quantity': quantity,
      'lat': lat,
      'long': long,
      'imgUrl': imgUrl
    };
  }

  String get getTimeStamp => timeStamp;
}
