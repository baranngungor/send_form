import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendFormController {
  Future sendFormCall(BuildContext context, url, requestBody, token, errorTitle,
      errorMessage) async {
    await http
        .post(Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode(requestBody))
        .then((value) {
      var response = json.decode(value.body);
      if (response['success'] == true) {
        Navigator.pop(context);
      } else {
        showCustomDialog(context, errorTitle, response['errorMessage']);
      }
    }).onError((error, stackTrace) =>
            showCustomDialog(context, errorTitle, errorMessage));
  }

  showCustomDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
