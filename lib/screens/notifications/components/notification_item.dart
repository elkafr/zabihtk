import 'package:flutter/material.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/models/notification_message.dart';
import 'package:zabihtk/utils/app_colors.dart';

class NotificationItem extends StatelessWidget {

  final NotificationMsg notificationMsg;

  const NotificationItem({Key key, this.notificationMsg}) : super(key: key);

  @override
 Widget build(BuildContext context) {

   return LayoutBuilder(

   builder: (context,constraints){

     return Row(
       crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[

     Container(
      margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth *0.02 ,
           vertical: constraints.maxHeight *0.12
         ),

         width: 40,
      height: 40,
       child: Image.asset('assets/images/alert.png'),
     ),
       Container(
           height: constraints.maxHeight*0.75,
         width: constraints.maxWidth *0.85,
          child: Column(
  mainAxisAlignment: MainAxisAlignment.end,
           crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
                  Container(
                width: constraints.maxWidth *0.8,
            child: Text('${notificationMsg.messageContent}',
                maxLines: 2,
              overflow: TextOverflow.ellipsis,style: TextStyle(
                 height: 1.5
               ),
              ),),
         Row(

            children: <Widget>[
              Icon(
                Icons.access_time,
                color: cHintColor,
                size: 17,
              ),
             Padding(padding: EdgeInsets.all(2)),
                Text('${notificationMsg.messageDate}' ,style: TextStyle(
               color: cPrimaryColor ,fontSize: 12
                ),)
               ],
              ),
                   Divider(

     ),

         ],
        ),
        ),

  ],
        );
         }
    );

  }
}