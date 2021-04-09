class Categories{

  var _name,_image,_Id;

  Categories(this._name, this._image, this._Id);

  factory Categories.fromJson(dynamic json){
    return Categories(json['name'], json['picture'],json['Id']);
  }
  get image => _image;

  get Id => _Id;

  get name => _name;
}