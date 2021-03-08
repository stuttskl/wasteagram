// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:transparent_image/transparent_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../db/new_post_dto.dart';

// class NewPostForm extends StatefulWidget {
//   @override
//   _NewPostFormState createState() => _NewPostFormState();
// }

// class _NewPostFormState extends State<NewPostForm> {
//   final _formKey = GlobalKey<FormState>();
//   final newPostValues = NewPostDTO();

//   void addDateToNewPostValues() {
//     newPostValues.timeStamp = DateTime.now();
//   }

//   void saveEntry(BuildContext context) {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();

//       addDateToNewPostValues();

//       FirebaseFirestore.instance.collection('posts').add({
//         'imgUrl': newPostValues.imgUrl,
//         'lat': newPostValues.lat,
//         'long': newPostValues.long,
//         'quantity': newPostValues.quantity,
//         'timeStamp': newPostValues.timeStamp,
//       });

//       Navigator.of(context).pop();
//     } else {
//       print("invalid, not saving");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [ 
//         Form(
//           key: _formKey,
//           child: 
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 newPostValues.imgUrl == null
//                     ? CircularProgressIndicator()
//                     : FadeInImage.memoryNetwork(
//                         placeholder: kTransparentImage,
//                         image: newPostValues.imgUrl,
//                       ),
//                 TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Number of Wasted Items',
//                       hintStyle: Theme.of(context).textTheme.headline5,
//                     ),
//                     autofocus: true,
//                     keyboardType: TextInputType.number,
//                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                     validator: (value) {
//                       final isDigitsOnly = int.tryParse(value);
//                       return isDigitsOnly == null
//                           ? 'Please enter a quantity'
//                           : null;
//                     },
//                     onSaved: (value) {
//                       newPostValues.quantity = int.tryParse(value);
//                     }),
//             )
//         ),
//         Semantics(
//           label: 'Upload New Post',
//           child: Padding(
//             padding: EdgeInsets.all(0.0),
//             child: 
//               GestureDetector(
//                 onTap: () {
//                   saveEntry(context);
//                 },
//               child:
//                 Container(
//                   alignment: Alignment.bottomCenter,
//                   width: 500,
//                   height: 150,
//                   color: Colors.blue,
//                   child: Icon(Icons.cloud_upload, size: 150.0, color: Colors.white),
//                 ),
//               )
//           )
//         ),
//   );