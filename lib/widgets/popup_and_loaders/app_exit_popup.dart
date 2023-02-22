import 'package:flutter/material.dart';

Future<bool> showExitPopup(context) async {
  return await showDialog(
        //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          // title:const  Text('Are you sure want to exit'),
          content: const Text('Are you sure want to exit'),
          actionsPadding: const EdgeInsets.only(right: 16, bottom: 10),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: const BorderSide(width: 1, color: Colors.grey),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child: const Text('NO'),
            ),
            const SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              //return true when click on "Yes"
              child: const Text('YES'),
            ),
          ],
        ),
      ) ??
      false; //if showDialouge had returned null, then return false
}
