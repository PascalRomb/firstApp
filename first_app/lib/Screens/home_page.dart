import 'package:flutter/gestures.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:first_app/Utils/Connector.dart';
import 'package:first_app/Models/post.dart';
import 'package:first_app/Models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);
  final String title;
  final User user;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  
  List<Post> posts;
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  Offset offset = Offset.zero;
  void _onRefresh() async{
    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));
    posts = await Connector.listAllPosts();
    //users.insert(0, (users.length+1).toString());
    if(mounted)setState((){
      
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));
    
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  _getListLength(){
    if(posts != null) return posts.length;
    return 0;
  }

  //idea for id
  _getText(){
    if (widget.user != null) return widget.user.toJson().toString();
    return "titolino";
  }

  _getElapsedTime(String date){
    var prova = DateTime.now().difference(DateTime.parse(date));
    var elapsed_time = prova.inSeconds;
    var type = "s";
    if(prova.inSeconds >= 60) {
      elapsed_time = prova.inMinutes;
      type="m";
    } if(elapsed_time >= 60) {
      elapsed_time = prova.inHours;
      type="h";
    } if(elapsed_time >= 24) {
      elapsed_time = prova.inDays;
      type="d";
    } if(elapsed_time >= 30) { //months
      elapsed_time = (elapsed_time/30).floor();
      type="M";
    } if(elapsed_time >= 30) { //years
      elapsed_time = (elapsed_time/365).floor();
      type="Y";
    }
    return elapsed_time.toString() + type;
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
                  child: Center(child: Text( _getText())) //idea for id
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
                  return Dismissible(
                    background: Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/4, top: 80),
                      child: Text("Swiped!")
                    ),
                    confirmDismiss: (value) async {
                      Connector.swipePost(posts[index].toJson()).then((response) {
                        if(response.statusCode == 200)
                          setState(() {
                            posts[index].swipe += 1;                       
                          });
                      });
                      return Future.value(false);
                    },                  
                    key: Key(posts[index].toString()),
                    direction: DismissDirection.startToEnd,
                    movementDuration: const Duration(milliseconds: 100),
                    child: ListTile(
                        title: Container(
                          padding: EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            color: Colors.red
                          ),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(posts[index].username + " says: "),
                              //Divider(height: 10),
                              Text(posts[index].body),
                              //Divider(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(posts[index].swipe.toString() + " swipe"),
                                  Text(_getElapsedTime(posts[index].datetime.toString()))
                                ],)
                            ],
                          ),
                          height: 160,
                        ),
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
