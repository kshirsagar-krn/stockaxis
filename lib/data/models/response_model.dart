class ResponseModel {
  final String _message;
  final dynamic _data;
  ResponseModel(this._message, [this._data]);

  String get message => _message;
  dynamic get data => _data;

  Map<String, dynamic> toJson() => {
    "message": _message,
    "data": _data,
  };
}
