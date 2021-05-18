class CartProduct {
  var _color, _payment, _picture, _quantity, _size, _Name, _UID,_indvPrice;

  CartProduct(this._color, this._payment, this._picture, this._quantity,
      this._size, this._Name, this._UID);

  factory CartProduct.fromJson(dynamic json) {
    return CartProduct(json['color'], json['payment'], json['picture'],
        json['quantity'], json['size'], json['name'], json['UID']);
  }

  Map<String, dynamic> toJson() => {
        'name': _Name,
        'color': _color,
        'payment': _payment,
        'picture': _picture,
        'quantity': _quantity,
        'size': _size,
        'UID': _UID
      };

  get UID => _UID;

  get name => _Name;

  get size => _size;

  get quantity => _quantity;

  get picture => _picture;

  get payment => _payment;

  get color => _color;
}
