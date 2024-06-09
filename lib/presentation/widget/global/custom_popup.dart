import 'package:flutter/material.dart';

customPopUp(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Error"),
      content: Text(text),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Center(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    ),
  );
}
