import 'package:flutter/material.dart';
import 'package:vdosecshare/utils/AppIcon.dart';
import 'package:vdosecshare/utils/main_text.dart';
class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  MainText mainText;
  AccountWidget({Key? key, required this.appIcon,required this.mainText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(left: 5,top: 4, bottom: 4
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: 10,),
          mainText,



        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white30,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
    );
  }
}
