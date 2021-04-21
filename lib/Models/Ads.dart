class Ads{
  var _Id,_picture,_tag;

  Ads(this._Id, this._picture,this._tag);
factory Ads.fromJson(dynamic json){
  return Ads(json['Id'], json['picture'], json['tag']);
}
  get picture => _picture;

  get tag => _tag;

  get Id => _Id;
}