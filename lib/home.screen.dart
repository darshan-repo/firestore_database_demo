import 'package:firestore_database_demo/database.api.dart';
import 'package:firestore_database_demo/database.class.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtAgeController = TextEditingController();
  TextEditingController txtPhoneNoController = TextEditingController();
  String selectedId = '';
  bool isLoading = false;
  String gender = '', male = 'Male', female = 'Female';
  List<String> selectedHobby = [];
  bool isCricket = false;
  bool isFootball = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    isLoading = true;
    await DatabaseApi.fetchData();
    isLoading = false;
    setState(() {});
  }

  matchData() async {
    await DatabaseApi.matchData();
    setState(() {});
  }

  void clearData() {
    txtNameController.clear();
    txtAgeController.clear();
    txtPhoneNoController.clear();
    gender = '';
    if (isCricket == true) {
      isCricket = false;
    }
    if (isFootball == true) {
      isFootball = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  matchData();
                  setState(() {});
                },
                color: Colors.red[200],
                child: const Text('MatchData'),
              ),
              const SizedBox(height: 10),
              TextField(
                  controller: txtNameController,
                  decoration: const InputDecoration(hintText: 'Enter Name')),
              const SizedBox(height: 10),
              TextField(
                  controller: txtAgeController,
                  decoration: const InputDecoration(hintText: 'Enter Age')),
              const SizedBox(height: 10),
              TextField(
                  controller: txtPhoneNoController,
                  decoration:
                      const InputDecoration(hintText: 'Enter Phone No')),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Gender :', style: TextStyle(fontSize: 16)),
                  SizedBox(
                    width: 126,
                    child: RadioListTile(
                      title: const Text('Male'),
                      value: male,
                      groupValue: gender,
                      onChanged: (value) {
                        gender = male.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: RadioListTile(
                      title: const Text('Female'),
                      value: female,
                      groupValue: gender,
                      onChanged: (value) {
                        gender = female.toString();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Hobby : ', style: TextStyle(fontSize: 16)),
                  Checkbox(
                      value: isCricket,
                      onChanged: (value) {
                        isCricket = value!;
                        setState(() {});
                      }),
                  const Text('Cricket', style: TextStyle(fontSize: 16)),
                  Checkbox(
                      value: isFootball,
                      onChanged: (value) {
                        isFootball = value!;
                        setState(() {});
                      }),
                  const Text('Football', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      selectedHobby.clear();
                      isCricket == true
                          ? selectedHobby.add('Cricket')
                          : selectedHobby.remove('Cricket');
                      isFootball == true
                          ? selectedHobby.add('Football')
                          : selectedHobby.remove('Football');
                      DatabaseModel obj = DatabaseModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: txtNameController.text,
                        age: txtAgeController.text == ''
                            ? 0
                            : int.parse(txtAgeController.text),
                        phoneNo: txtPhoneNoController.text == ''
                            ? 0
                            : int.parse(txtPhoneNoController.text),
                        gender: gender,
                        hobby: selectedHobby,
                      );
                      await DatabaseApi.addData(obj: obj);
                      getData();
                      clearData();
                      setState(() {});
                    },
                    color: Colors.red[200],
                    child: const Text('Submit'),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      selectedHobby.clear();
                      isCricket == true
                          ? selectedHobby.add('Cricket')
                          : selectedHobby.remove('Cricket');
                      isFootball == true
                          ? selectedHobby.add('Football')
                          : selectedHobby.remove('Football');
                      DatabaseModel obj = DatabaseModel(
                        id: selectedId.toString(),
                        name: txtNameController.text,
                        age: txtAgeController.text == ''
                            ? 0
                            : int.parse(txtAgeController.text),
                        phoneNo: txtPhoneNoController.text == ''
                            ? 0
                            : int.parse(txtPhoneNoController.text),
                        gender: gender,
                        hobby: selectedHobby,
                      );
                      await DatabaseApi.updateData(obj: obj);
                      getData();
                      clearData();
                      setState(() {});
                    },
                    color: Colors.red[200],
                    child: const Text('Update'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                    notification.disallowIndicator();
                    return true;
                  },
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 2,
                            color: Colors.black54,
                          ),
                          itemCount: DatabaseApi.databaseModelData.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: UniqueKey(),
                              confirmDismiss: (direction) {
                                return showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                    icon: const Icon(Icons.delete),
                                    title: const Text("Remove"),
                                    content:
                                        const Text("Sure you want to Remove?"),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        color: Colors.red[200],
                                        child: const Text('Cancle'),
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          await DatabaseApi.deleteData(
                                              key: DatabaseApi
                                                  .databaseModelData[index].id
                                                  .toString());
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                          getData();
                                          setState(() {});
                                        },
                                        color: Colors.red[200],
                                        child: const Text('Ok'),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Material(
                                child: GestureDetector(
                                  onTap: () {
                                    txtNameController.text = DatabaseApi
                                        .databaseModelData[index].name!;
                                    txtAgeController.text = DatabaseApi
                                        .databaseModelData[index].age!
                                        .toString();
                                    txtPhoneNoController.text = DatabaseApi
                                        .databaseModelData[index].phoneNo!
                                        .toString();
                                    selectedId = DatabaseApi
                                        .databaseModelData[index].id!;
                                    gender = DatabaseApi
                                        .databaseModelData[index].gender!;
                                    selectedHobby.contains('Cricket')
                                        ? isCricket = true
                                        : isCricket = false;
                                    selectedHobby.contains('Football')
                                        ? isFootball = true
                                        : isFootball = false;
                                    setState(() {});
                                  },
                                  child: Card(
                                    color: Colors.red[200],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name : ${DatabaseApi.databaseModelData[index].name!}',
                                          ),
                                          Text(
                                              'Age : ${DatabaseApi.databaseModelData[index].age!.toString()}'),
                                          Text(
                                              'Phone No : ${DatabaseApi.databaseModelData[index].phoneNo!.toString()}'),
                                          Text(
                                              'Gender : ${DatabaseApi.databaseModelData[index].gender!}'),
                                          Row(
                                            children: [
                                              const Text('Hobby : '),
                                              Expanded(
                                                child: Row(
                                                  children: List.generate(
                                                    DatabaseApi
                                                        .databaseModelData[
                                                            index]
                                                        .hobby!
                                                        .length,
                                                    (index1) => Text(
                                                      '${DatabaseApi.databaseModelData[index].hobby![index1]} ',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
