import 'package:test/test.dart';
import 'package:wasteagram/models/post.dart';

void main() {
  Post post;
  const url = 'imageUrl';
  const lat = 1.0;
  const long = 2.0;
  const quantity = 42;
  const timeStamp = '2021-03-14';

  post = Post(
      imgUrl: url,
      lat: lat,
      long: long,
      quantity: quantity,
      timeStamp: timeStamp);

  group('testing Post Model', () {
    test('imgUrl should not be null', () {
      expect(post.imgUrl, isNotNull);
    });

    test('latitude shold be not null', () {
      expect(post.lat, isNotNull);
    });

    test('longitude shold be not null', () {
      expect(post.long, isNotNull);
    });

    test('new post quantity should be greater than 0', () {
      expect(post.quantity, greaterThanOrEqualTo(0));
    });

    test('timeStamp should not be null', () {
      expect(post.timeStamp, isNotNull);
    });
  });
}
