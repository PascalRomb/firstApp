class Post{
  int id;
  DateTime datetime;
  int swipe;
  String body;
  String username;
  String id_user;

  Post({this.id_user, this.id, this.datetime, this.swipe, this.body, this.username});

  Post.fromJson(Map json){
    this.id = json['id'];
    this.datetime = DateTime.parse(json['datetime']);
    this.swipe = json['swipe'];
    this.body = json['body'];
    this.username = json['user']['username'];
  }

  Map toJson(){
    return {'id_user' : this.id_user ?? 0,
            'body' : this.body, 
            'id' : this.id
    };
  }
}