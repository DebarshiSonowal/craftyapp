class CartProduct {
  var _color,
      _payment,
      _picture,
      _quantity,
      _size,
      _Name,
      _UID,
      _indvPrice,
      _Id;

  CartProduct(this._color, this._payment, this._picture, this._quantity,
      this._size, this._Name, this._UID, this._Id);

  factory CartProduct.fromJson(dynamic json) {
    return CartProduct(json['color'], json['payment'], json['picture'],
        json['quantity'], json['size'], json['name'], json['UID'], json['Id']);
  }

  Map<String, dynamic> toJson() => {
        'name': _Name,
        'color': _color,
        'payment': _payment,
        'picture': _picture,
        'quantity': _quantity,
        'size': _size,
        'UID': _UID,
        'Id': _Id.toString()
      };

  get UID => _UID;

  get name => _Name;

  get size => _size;

  get quantity => _quantity;

  get picture => _picture;

  get payment => _payment;

  get color => _color;

  set setQuantity(value) {
    _quantity = value;
  }

  get Id => _Id;
}
