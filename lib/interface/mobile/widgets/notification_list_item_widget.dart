import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_exercise/models/notification_model.dart';
import 'package:home_exercise/utils/size_config.dart';

// ignore: must_be_immutable
class NotificationListItemWidget extends StatefulWidget {

  NotificationModel notification;
  NotificationListItemWidget(this.notification);

  @override
  _NotificationListItemWidgetState createState() => _NotificationListItemWidgetState();
}
class _NotificationListItemWidgetState extends State<NotificationListItemWidget> {
  ///Models
  NotificationModel notification;

  @override
  void initState() {
    super.initState();
    notification = widget.notification;
  }

  @override
  Widget build(BuildContext context) {
    ///Init sizeConfig
    SizeConfig().init(context);

    return Column(
      children: [
        Container(
          height: 60, ///Item size
          width: SizeConfig.screenWidth, ///Screen width
          //color: Colors.blue,
          child: Row(
            children: [
              ///Notification icon
              Expanded(
                  flex: 1,
                  child: Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.bell)
                      ],
                    ),
                  )
              ),
              ///Notificaton message
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///Message
                      Container(
                        child: Text(
                          notification.message,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ///Arrow
              Expanded(
                flex: 1,
                child: Container(
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 20, right: 10.0), ///Padding 20% of the screen width on left and 10 on right
          child: Divider(
            color: Colors.grey,
            height: 0.0,
          ),
        )
      ],
    );
  }
}