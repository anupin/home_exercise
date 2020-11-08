import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_exercise/models/order_model.dart';
import 'package:home_exercise/utils/size_config.dart';

class OrderListItemWidget extends StatefulWidget {
  
  OrderModel order;

  OrderListItemWidget(this.order);

  @override
  _OrderListItemWidgetState createState() => _OrderListItemWidgetState();
}
class _OrderListItemWidgetState extends State<OrderListItemWidget> {

  OrderModel order;
  Map<String, Color> colors = new Map();

  @override
  void initState() {
    super.initState();
    order = widget.order;
    
    ///Non ottimizato
    colors.putIfAbsent('A', () => Colors.greenAccent);
    colors.putIfAbsent('C', () => Colors.purple);
    colors.putIfAbsent('I', () => Colors.lightBlueAccent[100]);
    colors.putIfAbsent('F', () => Colors.red);
    colors.putIfAbsent('M', () => Colors.black);
    colors.putIfAbsent('P', () => Colors.deepOrange);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      padding: EdgeInsets.only(left: 10.0),
      height: 80, ///Item size
      width: double.infinity, ///Screen width
      //color: Colors.blue,
      child: Row(
        children: [
          ///Profile pic
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  //padding: EdgeInsets.all(15.0),
                  //margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    color: order.awaiting ? Colors.grey[400] : colors[order.username.substring(0,1)],
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                  child: !order.awaiting ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        order.username.substring(0,1),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 30
                        ),
                      )
                    ],
                  ) : Container(),
                )
              ],
            )
          ),
          ///Order details
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///Location info
                  Container(
                    child: Text(
                      order.location,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                      ),
                    ),
                  ),
                  ///Message & Time
                  Row(
                    children: [
                      ///Message
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            order.message,
                            style: TextStyle(
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ),
                      ///Timer icon & Time
                      Flexible(
                        flex: 2,
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          margin: EdgeInsets.only(left: 10.0),
                          padding: EdgeInsets.all(2.5),
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                            child: Row(
                              children: [
                                ///Timer icon
                                Container(
                                  child: Icon(
                                    Icons.timer,
                                    size: 18,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                ///Time
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 8,
                                  margin: EdgeInsets.only(left: 5.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      order.time,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ///Arrow
          Expanded(
            flex: 1,
            child: Container(
              //color: Colors.deepOrange,
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}