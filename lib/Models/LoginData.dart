class LoginData{
  String _password,_email;
  int _googleId;

  LoginData(this._password, this._email, this._googleId);

  int get googleId => _googleId;

  get email => _email;

  String get password => _password;
}