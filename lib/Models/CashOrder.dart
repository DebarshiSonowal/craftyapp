import 'dart:math';

class CashOrder {
  static String s;
  var _stage,
      _orderId,
      _orderAmount,
      _tokenData,
      _customerName,
      _orderNote,
      _appId,
      _customerPhone,
      _customerEmail,
  _notifyUrl;

  CashOrder(){
    _orderId = getRandomNo();
  }


  static String getRandomNo() {
    var rng = new Random();
    s = 'order_'+rng.nextInt(1000000).toString();
    print("VBWE $s");
    return s;
  }

  Map<String, dynamic> toMap() {
    return {
      "orderId": s,
      "orderAmount": _orderAmount,
      "customerName": _customerName,
      "orderNote": _orderNote,
      "appId": _appId,
      "customerPhone": _customerPhone,
      "customerEmail": _customerEmail,
      "stage": _stage,
      "tokenData": _tokenData,
      "notifyUrl":_notifyUrl
    };
  }

  String toString() {
    return " \norderId" +
        orderId +
        " \norderAmount " +
        _orderAmount +
        " \ncustomerName " +
        _customerName +
        " \norderNote " +
        _orderNote +
        " \nappId " +
        _appId +
        " \ncustomerPhone " +
        _customerPhone +
        " \ncustomerEmail " +
        _customerEmail +
        " \nstage " +
        _stage+
        " \nnotifyurl " +
        _notifyUrl;
  }



  get customerEmail => _customerEmail;

  get customerPhone => _customerPhone;

  get appId => _appId;

  get orderNote => _orderNote;

  get customerName => _customerName;

  get notifyUrl => _notifyUrl;

  get tokenData => _tokenData;

  get orderAmount => _orderAmount;

  get orderId => {_orderId==null?getRandomNo():_orderId};

  String get stage => _stage;

  set orderId(value) {
    _orderId = value;
  }

  set notifyUrl(value) {
    _notifyUrl = value;
  }

  set stage(value) {
    _stage = value;
  }
  set customerEmail(value) {
    _customerEmail = value;
  }

  set customerPhone(value) {
    _customerPhone = value;
  }

  set orderNote(value) {
    _orderNote = value;
  }

  set customerName(value) {
    _customerName = value;
  }

  set tokenData(value) {
    _tokenData = value;
  }

  set orderAmount(value) {
    _orderAmount = value;
  }

  set appId(value) {
    _appId = value;
  }
}
