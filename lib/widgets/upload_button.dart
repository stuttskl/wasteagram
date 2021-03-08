import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  var saveEntry;

  UploadButton({Key key, this.saveEntry});
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Upload New Post',
      child: Padding(
          padding: EdgeInsets.all(0.0),
          child: GestureDetector(
            onTap: () {
              saveEntry(context);
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              width: 500,
              height: 150,
              color: Colors.blue,
              child:
                  Icon(Icons.cloud_upload, size: 150.0, color: Colors.white),
            ),
          )
      )
    );
  }
}
