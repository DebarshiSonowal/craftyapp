class Ads{
  var _Id,_picture;

  Ads(this._Id, this._picture);
factory Ads.fromJson(dynamic json){
  return Ads(json['Id'], json['picture']);
}
  get picture => _picture;

  get Id => _Id;
}