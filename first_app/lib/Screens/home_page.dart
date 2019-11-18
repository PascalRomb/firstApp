import 'package:first_app/Models/user.dart';
import 'package:first_app/Utils/Connector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  
  List<User> users;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));
    users = await Connector.listAllUsers();
    //users.insert(0, (users.length+1).toString());
    if(mounted)setState((){
      
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  _getListLength(){
    if(users != null) return users.length;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      color: Colors.blue
                  ),
                  child: Center(child: Text("altro container"))
            ),
            Expanded(
              child:SmartRefresher(
              enablePullDown: true,
              footer: ClassicFooter(),
              header: WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              //onLoading: _onLoading, potrei usarlo per caricare volta per volta anzichè fare tutto insieme
              child: ListView.builder(
                  itemCount: _getListLength(), //non mi piace ma non trovo altro
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap:() {  
                        //print(users[index]);
                        //Connector.listAllUsers();
                      },
                      title: Container(
                        padding: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Colors.red
                        ),
                        child:  Text(users[index].username + " says: "),
                        height: 100,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
      )
    );
  }
}
