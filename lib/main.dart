import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

/* TODO: 
[x]  Display a circular progress indicator when there are no previous posts to display in the List Screen.
[x]  The List Screen should display a list of all previous posts, with the most recent at the top of the list.
[x]  Each post in the List Screen should be displayed as a date, representing the date the post was created, and a number, representing the total number of wasted items recorded in the post.
[x]  Tapping on a post in the List Screen should cause a Detail Screen to appear. The Detail Screen's back button should cause the List Screen to appear.
[x]  The Detail Screen should display the post's date, photo, number of wasted items, and the latitude and longitude that was recorded as part of the post.
[x]  The List Screen should display a large button at the center bottom area of the screen.
[x]  Tapping on the large button enables an employee to capture a photo, or select a photo from the device's photo gallery.
[x]  After taking a new photo or selecting a photo from the gallery, the New Post screen appears.
[x-KIND OF]  The New Post screen displays the photo of wasted food, a Number of Items text input field for entering the number of wasted items, and a large upload button for saving the post.
[]  Tapping on the Number of Items text input field should cause the device to display its numeric keypad.
[x]  In the New Post screen, tapping the back button in the app bar should cause the List Screen to appear.
[x]  In the New Post screen, tapping the large upload button should cause the List Screen to appear, with the latest post now appearing at the top of the list.
[x-KIND OF]  In the New Post screen, if the Number of Items field is empty, tapping the upload button should cause a sensible error message to appear.

--

[x]  Use the location, image_picker, cloud_firestore, and firebase_storage packages to meet the functional and technical requirements.
[x]  Incorporate the use of Firebase Cloud Storage and Firebase Cloud Firestore for storing images and post data.
[x]  Data should not be stored locally on the device.
[x]  On the List Screen, the application should display the posts stored in the Firestore database.
[x]  On the Detail Screen, the application should display the image stored in the Cloud Storage bucket.
[x]  On the New Post screen, tapping the large upload button should store a new post in the Firestore database.
[x]  Each "post" in Firestore should have the following attributes: date, imageURL, quantity, latitude and longitude. 
[]  The application should incorporate the Semantics widget in multiple places, such as interactive widgets like buttons, to aid accessibility.
[x]  The codebase should incorporate a model class.
[]  The codebase should incorporate a few (two or three) simple unit tests that test the model class.

*/