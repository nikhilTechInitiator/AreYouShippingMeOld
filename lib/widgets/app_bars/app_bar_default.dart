import 'package:flutter/material.dart';


AppBar appBarDefault(String title) {

  return AppBar(
    automaticallyImplyLeading: true,
    title: Text(
      title,
    ),
    centerTitle: true,
  );
}


