import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double width;
  final double height;
  final String imgUrl;
  final double radius;

  CircleImage({
    @required this.width,
    @required this.height,
    @required this.imgUrl,
    @required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    print(this.imgUrl.contains("http"));
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(this.radius),
        child: (this.imgUrl.contains("http")
            ? FadeInImage(
                image: NetworkImage(this.imgUrl),
                placeholder: AssetImage("assets/images/person-placeholder.jpg"),
                height: this.height,
                width: this.width,
                fit: BoxFit.cover,
              )
            : Image.asset("assets/images/person-placeholder.jpg")),
      ),
    );
  }
}
