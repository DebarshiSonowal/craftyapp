class ServerOrder {
  var _id, _entity, _amount, _amount_paid, _amount_due, _receipt, _offer_id,
      _status, _attempts, _notes, _created_at;

  ServerOrder(this._id,
      this._entity,
      this._amount,
      this._amount_paid,
      this._amount_due,
      this._receipt,
      this._offer_id,
      this._status,
      this._attempts,
      this._notes,
      this._created_at);

  factory ServerOrder.fromJson(dynamic json) {
    return ServerOrder(
      json["id"],
      json["entity"],
      json["amount"],
      json["amount_paid"],
      json["amount_due"],
      json["receipt"],
      json["offer_id"],
      json["status"],
      json["attempts"],
      json["notes"],
      json["created_at"],);
  }

  get created_at => _created_at;

  get notes => _notes;

  get attempts => _attempts;

  get status => _status;

  get offer_id => _offer_id;

  get receipt => _receipt;

  get amount_due => _amount_due;

  get amount_paid => _amount_paid;

  get amount => _amount;

  get entity => _entity;

  get id => _id;
}