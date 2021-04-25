class Address{
  String _address,_phone,_pin;

  Address(this._address, this._phone, this._pin);

  get pin => _pin;

  set pin(value) {
    _pin = value;
  }

  get phone => _phone;

  set phone(value) {
    _phone = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }
}