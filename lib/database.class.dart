class DatabaseModel {
  String? id, name, gender;
  int? age, phoneNo;
  List? hobby;

  DatabaseModel({
    this.id,
    this.name,
    this.age,
    this.phoneNo,
    this.gender,
    this.hobby,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    if (id != null) {
      data['id'] = id;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (age != null) {
      data['age'] = age;
    }
    if (phoneNo != null) {
      data['phoneNo'] = phoneNo;
    }
    if (gender != null) {
      data['gender'] = gender;
    }
    if (hobby != null) {
      data['hobby'] = hobby;
    }
    return data;
  }

  factory DatabaseModel.fromJson(Map<String, dynamic> json) => DatabaseModel(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        phoneNo: json['phoneNo'],
        gender: json['gender'],
        hobby: json['hobby'],
      );
}
