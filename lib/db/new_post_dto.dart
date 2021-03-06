class NewPostDTO {
  String imgUrl;
  double lat;
  double long;
  int numWasted;
  String timeStamp;

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'lat': lat,
      'long': long,
      'numWasted': numWasted,
      'timeStamp': timeStamp
    };
  }
}
