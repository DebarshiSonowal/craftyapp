class Razorpay{
  var _Id,_Key;

  Razorpay(this._Id, this._Key);
  factory Razorpay.fromJson(dynamic json){
    return Razorpay(json['ID'], json['KEY']);
  }

  get Key => _Key;

  get Id => _Id;
}