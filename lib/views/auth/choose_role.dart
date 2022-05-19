import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/auth/profesional_sign_up.dart';
import 'package:architect_app/views/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'kontraktor_sign_up.dart';

class ChooseRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: Dimension.screenHeight * 0.2),
          padding: EdgeInsets.symmetric(
              horizontal: Dimension.safeBlockHorizontal * 2),
          child: Column(
            children: [
              Text(
                "Daftar Sebagai",
                style: blackFontStyle3.copyWith(
                    fontSize: Dimension.safeBlockHorizontal * 5),
              ),
              SizedBox(height: Dimension.safeBlockVertical * 3),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: Dimension.blockSizeVertical * 18,
                                child: Image.asset('assets/images/avatar.png'),
                              ),
                              SizedBox(height: Dimension.safeBlockVertical),
                              Text(
                                "Owner",
                                style: blackFontStyle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfesionalSignUp()));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: Dimension.blockSizeVertical * 18,
                                child:
                                    Image.asset('assets/images/architect.png'),
                              ),
                              SizedBox(height: Dimension.safeBlockVertical),
                              Text(
                                "Konsultan",
                                style: blackFontStyle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KontraktorSignUp()));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: Dimension.blockSizeVertical * 18,
                          child: Image.asset('assets/images/architect.png'),
                        ),
                        SizedBox(height: Dimension.safeBlockVertical),
                        Text(
                          "Kontraktor",
                          style: blackFontStyle2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
