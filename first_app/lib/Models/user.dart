class User{
  String username;
  String password;
  String firstname;
  String lastname;
  String email;

  User({this.firstname, this.lastname, this.email, this.username, this.password});
  //TODO: fromJson, maybe with id and sessionId
  User.fromJson(Map json){
    this.firstname = json['firstname'];
    this.lastname = json['lastname'];
    this.username = json['username'];
    this.password = json['password'];
    this.email = json['email'];
  }
  Map toJson(){
    return {'firstname' : this.firstname,'lastname' : this.lastname,
            'username' : this.username, 'email' : this.email,
            'password' : this.password   
    };
  }
}

