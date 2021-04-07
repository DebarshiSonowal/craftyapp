
class User{
var _name,_id,_email,_googleId;

User(this._name, this._id, this._email, this._googleId);
  factory User.fromJson(dynamic json) {
    return User(
      json['name'],
      json['_id'],
      json['email'],
      json['googleId']
  );}


  get googleId => _googleId;

  get email => _email;

  get id => _id;

  get name => _name;
}