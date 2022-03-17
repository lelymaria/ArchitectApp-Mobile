import 'package:flutter/material.dart';

class CustomButtonNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  CustomButtonNavbar({this.selectedIndex = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if(onTap != null) {
                  onTap(0);
                }
              },
              child: Icon(
                (selectedIndex == 0) ? Icons.home : Icons.home_outlined,
                color: (selectedIndex == 0) ? Colors.amber : Colors.grey[300],
                size: 32,
              ),
              // child: Container(
              //   width: 32,
              //   height: 32,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/ic_home' + ((selectedIndex == 0) ? '.png' : '_normal.png'))
              //     )
              //   ),
              // ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if(onTap != null) {
                  onTap(1);
                }
              },
              child: Icon(
                (selectedIndex == 1) ? Icons.architecture : Icons.architecture_outlined,
                color: (selectedIndex == 1) ? Colors.amber : Colors.grey[300],
                size: 32,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if(onTap != null) {
                  onTap(2);
                }
              },
              child: Icon(
                (selectedIndex == 2) ? Icons.person : Icons.person_outline_outlined,
                color: (selectedIndex == 2) ? Colors.amber : Colors.grey[300],
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
