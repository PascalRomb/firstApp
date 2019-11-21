class User{
  String username;
  String password;
  String firstname;
  String lastname;
  String email;
  //TODO dovrei fare meglio il costruttore con i campi privati che rimangano privati
  //tipo id e session_id potrebbero servirmi
  User({this.firstname, this.lastname, this.email, this.username, this.password});
  //TODO: fromJson, maybe with id and sessionId
  User.fromJson(Map json){
    this.firstname = json['firstname'];
    this.lastname = json['lastname'];
    this.username = json['username'];
    this.password = json['password'];
    this.email = json['email'];
  }
  //TODO forse solo le cose che posto
  Map toJson(){
    return {'firstname' : this.firstname,'lastname' : this.lastname,
            'username' : this.username, 'email' : this.email,
            'password' : this.password   
    };
  }
}

