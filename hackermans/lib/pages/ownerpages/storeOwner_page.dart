import 'package:flutter/material.dart';
import 'package:hackermans/pages/ownerpages/scanQRCode_page.dart';
import 'package:hackermans/src/HTTPRequests.dart';
import 'package:hackermans/styles.dart';


class StorePage extends StatefulWidget{
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  HTTPRequest request = HTTPRequest();

  int storeId = 2;
  int currentUser;
  int maxUser = 50;
  bool loading = true;

  initState(){
    super.initState();
    getCurrentCount(storeId);
  }

  Widget _scanQRCodeButton(BuildContext context){
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: (currentUser == maxUser) ? null : () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (BuildContext context) => ScanQRCodePage())
              );
            },
            child: Card(
              color: (currentUser == maxUser) ? Colors.grey : Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bluetooth_searching, color: Colors.white,),
                    SizedBox(width: 10),
                    Text('Scan QR code', style: Styles.textBoldWhite,)
                  ]
                ),
              )
            ),
          )
        )
      ]
    );
  }

  /*
  Widget _maintainState(BuildContext context){
    getCurrentCount(storeId);
    return Container(height: 0, width: 0);
  }
  */

  void getCurrentCount(int storeId) async {
    await request.getCounter(storeId)
      .then((value) {
        this.currentUser = value;
        setState(() {
          loading = false;
        });
      })
      .catchError((e) {
        print(e.toString());
    });                       
  }

  Widget _counterBody(context){
    return Expanded(
      child: Column(
        children: <Widget>[
          Spacer(),
          Center(child: Text(currentUser.toString(), style: Styles.bigInfo,)),
          Center(child: Text('Customers', style: Styles.text,)),
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Expanded(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        if (currentUser > 0) currentUser -= 1;
                      });
                    },                    child: Card(
                      color: !(currentUser == maxUser) ? Colors.grey : Colors.blue,
                      child: Center(child: Text('-', style: Styles.bigInfoWhite,)),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        if (currentUser < maxUser) currentUser += 1;
                      });
                    },
                    child: Card(
                      color: (currentUser == maxUser) ? Colors.grey : Colors.blue,
                      child: Center(child: Text('+', style: Styles.bigInfoWhite,)),
                    ),
                  ),
                )
              ]
            ),
          ),
          Spacer(),
          _scanQRCodeButton(context)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: (currentUser == maxUser) ? Colors.red : Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Migros Rapperswil', style: Styles.headerLight,),
                      Spacer(),
                      Text('Logout', style: Styles.smalltext,),
                    ],
                  ),
                  (loading) ? WaitingBody() : _counterBody(context),
                ],
              ),
            ),
          ),
        ),
        //_maintainState(context),
      ]
    );
  }
}

class WaitingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }  
}
