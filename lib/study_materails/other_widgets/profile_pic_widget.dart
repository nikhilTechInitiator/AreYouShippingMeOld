import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  final double size;
  final String? url;
  final int? radius;

  const ProfilePicWidget({Key? key, this.size = 32, this.url, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(radius?.toDouble() ?? 16),
      child: SizedBox(
        height: size,
        width: size,
        child: FittedBox(
          clipBehavior: Clip.antiAlias,
          child: url != null
              ? CachedNetworkImage(
                  imageUrl: url!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) {
                    debugPrint('catch error $url $error ');

                    return const Icon(CupertinoIcons.person_crop_circle);
                  })
              : const Icon(CupertinoIcons.person_crop_circle),
        ),
      ),
    );
  }
}
