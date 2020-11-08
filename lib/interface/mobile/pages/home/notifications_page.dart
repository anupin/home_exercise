import 'package:flutter/material.dart';
import 'package:home_exercise/blocs/notification_bloc.dart';
import 'package:home_exercise/interface/mobile/widgets/notification_list_item_widget.dart';
import 'package:home_exercise/models/notification_model.dart';
import 'package:home_exercise/utils/size_config.dart';
import 'package:home_exercise/utils/utils.dart';

class NotificationsPage extends StatefulWidget {
  //static String route = '/home';
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  ///Notification bloc
  NotificationBloc notificationBloc;

  @override
  void initState() {
    super.initState();
    notificationBloc = new NotificationBloc();
  }

  @override
  Widget build(BuildContext context) {
    ///Init sizeConfig
    SizeConfig().init(context);
    notificationBloc.getNotifications();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                ///Appbar bottom arc & Notification list
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      ///Notification list
                      Positioned.fill(
                        top: 10,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: StreamBuilder<List<NotificationModel>>(
                            stream: notificationBloc.notifications,
                            builder: (context, AsyncSnapshot<List<NotificationModel>> notificationsSnapshot) {
                              Widget widget;
                              switch(notificationsSnapshot.connectionState){
                                case ConnectionState.waiting:
                                  widget = Center(child: CircularProgressIndicator());
                                  break;
                                case ConnectionState.none:
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  widget = MediaQuery.removePadding(
                                    removeTop: true,
                                    context: context,
                                    child: ListView.separated(
                                      itemCount: notificationsSnapshot.data.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index){
                                        NotificationModel notification = notificationsSnapshot.data.elementAt(index);
                                        return InkWell(
                                          onTap: (){
                                            debugPrint('You tapped item ${++index}');
                                          },
                                          child: NotificationListItemWidget(notification),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) => Padding(
                                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 20, right: 10.0), ///Padding 20% of the screen width on left and 10 on right
                                        child: Divider(
                                          color: Colors.grey,
                                          height: 1.0,
                                        ),
                                      ),
                                    ),
                                  );
                                  break;
                              }
                              //usersBloc.getUsers();
                              return widget;
                            },
                          ),
                        ),
                      ),
                      ///Appbar bottom arc
                      Positioned.fill(
                        top: -10,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Utils.bottomArc,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}