import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  double? borderRadious;
  String? image;

  double? height;
  double? width;

  ProfileIcon({
    super.key,
    this.borderRadious,
    this.image,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadious!),
        image: DecorationImage(
          image: NetworkImage(image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
