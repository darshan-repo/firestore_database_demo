// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_database_demo/database.class.dart';

class DatabaseApi {
  static CollectionReference db =
      FirebaseFirestore.instance.collection('userData');

  static List<DatabaseModel> databaseModelData = [];
  static addData({required DatabaseModel obj}) async {
    obj.id = db.doc().id;
    await db.doc(obj.id).set(obj.toJson());
  }

  static Future<void> fetchData() async {
    databaseModelData.clear();
    var data = await FirebaseFirestore.instance.collection("userData").get();

    for (var element in data.docs) {
      databaseModelData.add(
        DatabaseModel.fromJson(element.data()),
      );
    }
  }

  static updateData({required DatabaseModel obj}) async {
    await db.doc(obj.id).update(obj.toJson());
  }

  static deleteData({required String key}) async {
    await db.doc(key).delete();
  }

  static matchData() async {
    // **** isEqualTo ****
    QuerySnapshot isEqualTo = await db.where('age', isEqualTo: 20).get();

    print('--isEqualTo----->> ${isEqualTo.docs.length}');
    for (var element in isEqualTo.docs) {
      print(
          '====isEqualTo=======>> ${element.id}  =============>> ${element.data()}');
    }
    print('');
    print(
        '=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n\n');

    // **** isGreaterThan ****
    QuerySnapshot isGreaterThan =
        await db.where('age', isGreaterThan: 50).get();
    print('--isGreaterThan----->> ${isGreaterThan.docs.length}');
    for (var element in isGreaterThan.docs) {
      print(
          '====isGreaterThan=======>> ${element.id}  =============>> ${element.data()}');
    }
    print('');
    print(
        '=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n\n');

    // **** isGreaterThanOrEqualTo ****
    QuerySnapshot isGreaterThanOrEqualTo =
        await db.where('age', isGreaterThanOrEqualTo: 62).get();
    print(
        '--isGreaterThanOrEqualTo----->> ${isGreaterThanOrEqualTo.docs.length}');
    for (var element in isGreaterThanOrEqualTo.docs) {
      print(
          '====isGreaterThanOrEqualTo=======>> ${element.id}  =============>> ${element.data()}');
    }
    print('');
    print(
        '=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n\n');

    // **** isLessThan ****
    QuerySnapshot isLessThan = await db.where('age', isLessThan: 62).get();
    print('--isLessThan----->> ${isLessThan.docs.length}');
    for (var element in isLessThan.docs) {
      print(
          '====isLessThan=======>> ${element.id}  =============>> ${element.data()}');
    }
    print('');
    print(
        '=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n\n');

    // **** isLessThanOrEqualTo ****
    QuerySnapshot isLessThanOrEqualTo =
        await db.where('age', isLessThanOrEqualTo: 62).get();
    print('--isLessThanOrEqualTo----->> ${isLessThanOrEqualTo.docs.length}');
    for (var element in isLessThanOrEqualTo.docs) {
      print(
          '====isLessThanOrEqualTo=======>> ${element.id}  =============>> ${element.data()}');
    }
    print('');
    print(
        '=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n\n');

    // **** isNotEqualTo ****
    QuerySnapshot isNotEqualTo = await db.where('age', isNotEqualTo: 62).get();
    print('--isNotEqualTo----->> ${isNotEqualTo.docs.length}');
    for (var element in isNotEqualTo.docs) {
      print(
          '====isNotEqualTo=======>> ${element.id}  =============>> ${element.data()}');
    }
    print('');
    print(
        '=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n\n');

    // **** whereIn ****
    QuerySnapshot whereIn = await db.where('hobby', whereIn: [
      ["Cricket"]
    ]).get();
    print('--whereIn----->> ${whereIn.docs.length}');
    for (var element in whereIn.docs) {
      print(
          '====whereIn=======>> ${element.id}  =============>> ${element.data()}');
    }
    print('');
    print(
        '=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n\n');

    // **** whereNotIn ****
    QuerySnapshot whereNotIn = await db.where('hobby', whereNotIn: [
      ["ABC"],
      ["Football"]
    ]).get();
    print('--whereNotIn----->> ${whereNotIn.docs.length}');
    for (var element in whereNotIn.docs) {
      print(
          '====whereNotIn=======>> ${element.id}  =============>> ${element.data()}');
    }
    print('');
    print(
        '=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n\n');
  }
}
