class Profile{
  var _id,_name,_email,_address;
 var _phone,_pincode,_gender;

  Profile(this._id, this._name, this._email, this._address,
      this._phone, this._pincode,this._gender);

  factory Profile.fromJson(dynamic json){
    return Profile(
      json['userId'],
      json['name'],
      json['email'],
      json['address'],
      json['phone'],
      json['pincode'],
      json['gender'],
    );
  }

  get gender => _gender;

  get pincode => _pincode;

  int get phone => _phone;

  get address => _address;

  get email => _email;

  get name => _name;

  String get id => _id;
}