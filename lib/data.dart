class Data {
  int id;
  String name;
  String value;

  Data({this.id, this.name, this.value});

  static Map<String, dynamic> toJson(Data data) {
    return <String, dynamic>{"id": data.id, "name": data.name, "value": data.value};
  }

  factory Data.fromJson(dynamic json) {
    return Data(id: json['id'] as int, name: json['name'] as String, value: json['value'] as String);
  }
}
