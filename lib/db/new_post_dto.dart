class NewPostDTO {
  String imgUrl;
  int numWasted;
  String timeStamp;

  Map<String, dynamic> toMap() {
    return {'imgUrl': imgUrl, 'numWasted': numWasted, 'timeStamp': timeStamp};
  }
}
