import 'package:flutter/material.dart';
import 'package:cycle_up/pages/product_details.dart';
import 'package:cycle_up/components/databaseManager.dart';
import 'package:intl/intl.dart';
import 'package:cycle_up/components/cart_products.dart';
class Notifcations extends StatefulWidget {


  @override
  _NotifcationsState createState() => _NotifcationsState();
}


class _NotifcationsState extends State<Notifcations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.2,
          backgroundColor: Colors.red,
          title: Text('Notifications'),
          actions: <Widget>[

          ],
        ),

        body: new ListView(
            children: <Widget>[
              Container(
                height:560.0,
                child: myNotifications(),
              ),
            ]
        )



    );
  }
}

class myNotifications extends StatefulWidget {

  @override
  _myNotificationsState createState() => _myNotificationsState();
}
class _myNotificationsState extends State<myNotifications> {

  List userNotificationList = [];
  //DateTime selectedDate = DateTime.now();


  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await databaseManager().getNotification();

    if(resultant == null){
      print('Unable to retrieve');
    }else {
      setState(() {
        userNotificationList = resultant;
      });
    }
  }
  get index => null;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: userNotificationList.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 4),),
        itemBuilder: (BuildContext context, int index) {
          return Notif(
            ownerName: userNotificationList[index]['ownerName'],
            borrowerName: userNotificationList[index]['borrowerName'],
            bikeName: userNotificationList[index]['bikeName'],
            message: userNotificationList[index]['message'],
            dateRented: userNotificationList[index]['dateRented'],
            rentalDueDate:userNotificationList[index]['rentalDueDate'],
          );
        }
        );
  }
}

class Notif extends StatelessWidget {
  final f = new DateFormat('yyyy-MM-dd');

  final prod_name;
  final prod_picture;
  final prod_price;
  final ownerName;
  final borrowerName;
  final userEmail;
  final address;
  final contactNum;
  final rentalDate;
  final bikeName;
  final message;
  final dateRented;
  final rentalDueDate;

  Notif(
      {
        this.prod_name,
        this.prod_picture,
        this.prod_price,
        this.ownerName,
        this.borrowerName,
        this.userEmail,
        this.address,
        this.contactNum,
        this.rentalDate,
        this.bikeName,
        this.message,
        this.dateRented,
        this.rentalDueDate
      });


  @override
  Widget build(BuildContext context) {
    int rentDate = dateRented.hashCode;
    var date = DateTime.fromMicrosecondsSinceEpoch(dateRented.microsecondsSinceEpoch);

    var formattedDate = DateFormat.yMMMd().format(date);

    return Card(
      child: Hero(
          tag: new Text("hero 1"),
          child: Material(
            child: InkWell(
               // onTap: (){
               //   print(rentalDate);
               //   print(formattedDate);
               // },
              child: GridTile(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,5,0,10),
                          child: Text('Date: '+formattedDate , textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                    Text(message),
                  ],
                ),
                  // footer: Container(
                  //     color: Colors.white70,
                  //     child: new Row(children: <Widget>[
                  //       Expanded(
                  //         child: Text(ownerName),
                  //       ),
                  //       new Text(borrowerName)
                  //     ],)
                  // ),

              ),
            ),
          )),
    );
  }

}
