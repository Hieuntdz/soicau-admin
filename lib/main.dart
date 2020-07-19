import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soicauadmin/store/app_store.dart';
import 'data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final globalKey = GlobalKey<ScaffoldState>();

  final dbRef = FirebaseDatabase.instance.reference().child("soicau");

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AppStore appStore = AppStore();

  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    inint();
    super.initState();
  }

  Future<void> inint() async {
    appStore.loadLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        body: SafeArea(
            top: true,
            bottom: true,
            left: true,
            right: true,
            child: Observer(
              builder: (context) {
                timeController.text = appStore.timeRandom.toString();
                return  Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Thoi gian quay (giây): ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: timeController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    saveTime(timeController);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.blue,
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "Lưu",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                      onTap: () {
                                        if (!appStore.isBac) {
                                          appStore.setIsBac(true);
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                        color: appStore.isBac
                                            ? Colors.blueGrey
                                            : Colors.grey,
                                        child: Text(
                                          "Miền Bắc",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )),
                                ),
                                Container(
                                  height: 50,
                                  width: 1,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                      onTap: () {
                                        if (appStore.isBac) {
                                          appStore.setIsBac(false);
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                        color: !appStore.isBac
                                            ? Colors.blueGrey
                                            : Colors.grey,
                                        child: Text(
                                          "Miền Nam",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )),
                                )
                              ],
                            ),
                            Expanded(
                              flex: 1,
                              child: content(),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          save();
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Lưu",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )));
  }

  Widget content() {
    List<Data> listData =
        appStore.isBac ? appStore.listDataBac : appStore.listDataNam;
    return Container(
      child: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            Data data = listData[index];
            TextEditingController controller = new TextEditingController();
            controller.text = data.value == null ? "" : data.value;
            return Container(
              height: 60,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        data.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: controller,
                      onChanged: (valuex) {
                        data.value = valuex;
                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Future<void> save() {
    List<Data> dataList =
        appStore.isBac ? appStore.listDataBac : appStore.listDataNam;
    String childName = appStore.isBac ? "BAC" : "NAM";

    var json = jsonEncode(dataList.map((e) => Data.toJson(e)).toList());
    print("DATTTTTTTTTTTTTTT ${json.toString()}");
    dbRef.child(childName).set(json).then((_)  {
      print("Success");
      final snackBar = SnackBar(content: Text('Lưu thành công!'));
      globalKey.currentState.showSnackBar(snackBar);
      appStore.saveDataLocal(childName,json);
    }).catchError((onError) {
      print(onError);
      final snackBar = SnackBar(content: Text('Lưu thất bại!'));
      globalKey.currentState.showSnackBar(snackBar);
    });
  }

  void saveTime(TextEditingController timeController) {

    String value = timeController.text;
    double time = double.parse(value);

    print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
    dbRef.child("time").set(timeController.text).then((_) {
      print("Success");
      final snackBar = SnackBar(content: Text('Lưu thành công!'));
      globalKey.currentState.showSnackBar(snackBar);
      appStore.saveTimeLocal(time);
    }).catchError((onError) {
      print(onError);
      final snackBar = SnackBar(content: Text('Lưu thất bại!'));
      globalKey.currentState.showSnackBar(snackBar);
    });
  }
}
