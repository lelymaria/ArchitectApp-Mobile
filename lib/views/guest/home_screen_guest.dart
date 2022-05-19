import 'package:flutter/material.dart';

class HomeScreenGuest extends StatefulWidget {
  @override
  State<HomeScreenGuest> createState() => _HomeScreenGuestState();
}

class _HomeScreenGuestState extends State<HomeScreenGuest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 12, left: 12),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 10),
                  // _listProject.length == null
                  //     ? Padding(
                  //         padding: EdgeInsets.only(
                  //             top: Dimension.safeBlockVertical * 25),
                  //         child: Center(
                  //           child: Text("Tidak ada data"),
                  //         ),
                  //       )
                  //     : StaggeredGridView.countBuilder(
                  //         crossAxisCount: 2,
                  //         crossAxisSpacing: 15,
                  //         mainAxisSpacing: 20,
                  //         itemCount: _listProject.length ?? 0,
                  //         shrinkWrap: true,
                  //         physics: ClampingScrollPhysics(),
                  //         itemBuilder: (context, index) {
                  //           Project projects = _listProject[index];
                  //           return DesainCard(
                  //               project: projects,
                  //               height: index % 4 == 0
                  //                   ? Dimension.blockSizeVertical * 43
                  //                   : Dimension.blockSizeVertical * 30);
                  //         },
                  //         staggeredTileBuilder: (index) {
                  //           // return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.5);
                  //           return new StaggeredTile.fit(1);
                  //         },
                  //       )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
