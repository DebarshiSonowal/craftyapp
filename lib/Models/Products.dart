class Products {
  var _Id,
      _Name,
      _Description,
      _Short,
      _Categories,
      _Color,
      _Image,
      _Price,
      _Size,
      _Tags,
      _Gender;

  Products(
      this._Id,
      this._Name,
      this._Description,
      this._Short,
      this._Categories,
      this._Color,
      this._Image,
      this._Price,
      this._Size,
      this._Tags,
      this._Gender);

  factory Products.fromJson(dynamic json) {
    return Products(
        json['ID'],
        json['Name'],
        json['Description'],
        json['Short description'],
        json['Categories'],
        json['Color'],
        json['Images'],
        json['Price'],
        json['Size'],
        json['Tags'],
        json['Gender']);
  }

  get Tags => _Tags;

  get Short => _Short;

  get Size => _Size;

  get Price => _Price;

  get Image => _Image;

  get Color => _Color;

  get Gender => _Gender;

  get Categories => _Categories;

  get Description => _Description;

  get Name => _Name;

  get Id => _Id;
}
