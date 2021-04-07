class Order {
  var _color,
  _date,
      _email,
      _payment,
      _products,
      _picture,
      _quantity,
      _price,
      _size,
      _status,
      _orderId,
      _UID,
      _name,
      _address,
      _pin,
      _phone,
      _trackingId;

  Order(
      this._color,
      this._date,
      this._name,
      this._email,
      this._payment,
      this._products,
      this._picture,
      this._price,
      this._quantity,
      this._size,
      this._status,
      this._orderId,
      this._UID,
      this._address,
      this._phone,
      this._pin,
      this._trackingId);

  factory Order.fromJson(dynamic json) {
    return Order(
        json["color"],
        json['date'],
        json["name"],
        json["email"],
        json["payment"],
        json["product"],
        json["picture"],
        json["price"],
        json["quantity"],
        json["size"],
        json["status"],
        json["orderId"],
        json["UID"],
        json["address"],
        json["phone"],
        json["pin"],
        json['trackingId']);
  }

  get address => _address;

  get UID => _UID;

  get trackingId => _trackingId;

  get orderId => _orderId;

  get name => _name;

  get price => _price;

  get status => _status;

  get size => _size;

  get quantity => _quantity;

  get picture => _picture;

  get products => _products;

  get date => _date;

  get payment => _payment;

  get email => _email;

  get color => _color;

  get pin => _pin;

  get phone => _phone;
}
