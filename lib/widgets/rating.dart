import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final int rate;

  Rating(this.rate);

  @override
  Widget build(BuildContext context) {
    int numberOfStarts = rate.round();
    return Row(
      children:
        List<Widget>.generate(5, (index) => Icon(
          (index < numberOfStarts) ? Icons.star : Icons.star_outline,
          size: 16,
          color: Colors.amber,
        ))
        //  + [
        //   SizedBox(width: 4),
        //   Text(rate.toString(), style: greyFontStyle.copyWith(fontSize: 12),)
        // ]
    );
  }
}