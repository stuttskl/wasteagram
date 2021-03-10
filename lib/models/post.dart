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

  Post fromMap(Map<String, dynamic> map) {
    return Post(
      imgUrl: map['imgUrl'],
      lat: map['lat'],
      long: map['long'],
      quantity: map['quantity'],
      timeStamp: map['time stamp']);
  }

  String get getImgUrl => imgUrl;
  int get getQuantity => quantity;
  double get getLat => lat;
  double get getLong => long;
  String get getTimeStamp => timeStamp;
}
