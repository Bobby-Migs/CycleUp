import 'package:flutter/material.dart';
import 'package:cycle_up/components/databaseManager.dart';
import 'package:cycle_up/Admin/runningRentals.dart';
import 'package:cycle_up/Admin/RentalListNav.dart';

class DisplayRunningRentals extends StatefulWidget {
  @override
  _DisplayRunningRentalsState createState() => _DisplayRunningRentalsState();
}

class _DisplayRunningRentalsState extends State<DisplayRunningRentals> {
  List userRentalList = [];
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await databaseManager().getDisplayedRentalList();

    if(resultant == null){
      print('Unable to retrieve');
    }else {
      setState(() {
        userRentalList = resultant;
      });
    }
  }
  get index => null;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: userRentalList.length,
        itemBuilder: (context, index) {
          return RentalListBody(
            prod_name: userRentalList[index]['bikeName'],
            prod_picture: userRentalList[index]['picture'],
            prod_price: userRentalList[index]['price'],
            ownerName: userRentalList[index]['ownerName'],
            borrowerName: userRentalList[index]['borrowerName'],
            userEmail: userRentalList[index]['userEmail'],
            address: userRentalList[index]['address'],
            contactNum: userRentalList[index]['contactNum'],
            dayHr: userRentalList[index]['days'],
            type: userRentalList[index]['type'],
            borrowerDocID: userRentalList[index]['borrowerDocID'],

          );
        }
    );
  }
}



class RentalListBody extends StatefulWidget {
  final prod_name;
  final prod_picture;
  final prod_price;
  final ownerName;
  final borrowerName;
  final userEmail;
  final address;
  final contactNum;
  final dayHr;
  final type;
  final borrowerDocID;

  RentalListBody({
    this.prod_name,
    this.prod_picture,
    this.prod_price,
    this.ownerName,
    this.borrowerName,
    this.userEmail,
    this.address,
    this.contactNum,
    this.dayHr,
    this.type,
    this.borrowerDocID,
  });

  @override
  _RentalListBodyState createState() => _RentalListBodyState();
}

class _RentalListBodyState extends State<RentalListBody> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // <<<<<<<<<<<< LEADING SECTION >>>>>>>>>>>>>
        // leading: new Image.network(cart_prod_picture, width: 80.0, height: 80.0,),

        // <<<<<<<<<<<<< TITLE SECTION >>>>>>>>>>>>
        title: Row(
          children: [
            Container(

                width: MediaQuery.of(context).size.width /2,
                child: Text('By: '+ widget.borrowerName)
            ),
            // Container(
            //   //width: MediaQuery.of(context).size.width /3,
            //   // alignment: Alignment.topLeft,
            //   padding: const EdgeInsets.fromLTRB(0, 2, 0,2),
            //   child: MaterialButton(
            //     child: Text('View', style: TextStyle(color: Colors.red),),
            //     onPressed: ()=> Navigator.of(context).push(new MaterialPageRoute(
            //       // here we are passing the values of the product to the RentailListDetails page
            //       builder: (context) => new RentalListDetails(
            //         prod_name: widget.prod_name,
            //         prod_price: widget.prod_price,
            //         prod_picture: widget.prod_picture,
            //         ownerName: widget.ownerName,
            //         borrowerName: widget.borrowerName,
            //         userEmail: widget.userEmail,
            //         address: widget.address,
            //         contactNum: widget.contactNum,
            //         dayHr: widget.dayHr,
            //         type: widget.type,
            //         borrowerDocID: widget.borrowerDocID,
            //       ),
            //     )),
            //   ),
            // ),
            MaterialButton(
              minWidth: 1,
              onPressed: (){
                databaseManager().deleteRental(this.widget.borrowerDocID);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> RentalListHome()));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => runningRentals()));
              },
              child: Text('x', style: TextStyle(color: Colors.grey),),
            ),
          ],
        ),

        //<<<<<<<<<<<<< SUBTITLE SECTION >>>>>>>>>>
        subtitle: new Column(
          children: <Widget>[

            //<<<<<<<<<<<<< THIS SECTION IS FOR THE RENTAL PRICE >>>>>>>>>>>>>>>>
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                "Email: ${widget.userEmail}",
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(

            ),

          ],
        ),
      ),
    );

  }
}

