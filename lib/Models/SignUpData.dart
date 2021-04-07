class SignUpData{
  String _password,_email,_name,_gender;
  int _googleId;

  SignUpData(this._password, this._email, this._name, this._googleId,this._gender);

  int get googleId => _googleId;

  get name => _name;

  get gender => _gender;

  get email => _email;

  String get password => _password;
}