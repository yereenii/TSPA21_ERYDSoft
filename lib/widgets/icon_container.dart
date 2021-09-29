import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  final double size;

  const IconContainer({Key? key, required this.size})
      : assert(size != null && size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size * 0.30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(this.size * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            //blurRadius: 5,
            //offset: Offset(0, 5), //sombra
          ),
        ],
      ),
      padding: EdgeInsets.all(this.size * .02), //8.0), //this.size * 0.20),
      child: Center(
        child: SvgPicture.asset(
          'assets/icon.svg',
          width: this.size,
          height: this.size * 0.25,
        ),
      ),
    );
  }
}
