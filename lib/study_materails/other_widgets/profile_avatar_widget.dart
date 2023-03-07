import 'dart:io';
import 'package:are_you_shipping_me/study_materails/other_widgets/profile_pic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final double size;
  final File? imageFile;
  final String? imageUrl;

  const ProfileAvatarWidget(
      {Key? key, required this.size, this.imageFile, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child: FittedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                  child: Container(
                color: Colors.white,
                width: size * .8,
                height: size * .8,
              )),
              imageFile != null
                  ? Container(
                margin: const EdgeInsets.only(top: 10),
                width: size * .8,
                height: size * .8,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.white,
                              width: 5,
                              strokeAlign: BorderSide.strokeAlignOutside)),
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.fill,
                      ),
                    )
                  : imageUrl?.isNotEmpty == true
                      ? ProfilePicWidget(
                          url: imageUrl ?? "",
                          size: 100,
                          radius: 50,
                        )
                      : Icon(
                          CupertinoIcons.person_crop_circle_fill,
                          size: size,
                        ),
              Positioned(
                bottom: size * .09,
                right: size * .09,
                child: ClipOval(
                    child: Container(
                        color: Colors.white,
                        width: size * .22,
                        height: size * .22,
                        child: Icon(
                          Icons.camera_alt,
                          size: size * .18,
                        ))),
              )
            ],
          ),
        ));
  }
}
