import 'package:flutter/material.dart';
import 'package:soicauadmin/const.dart';

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
  List<Data> listDataBac = Const.dataBAC;
  List<Data> listDataNam = Const.dataNAM;

  bool isBac = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                            onTap: () {
                              if (!isBac) {
                                setState(() {
                                  isBac = true;
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              color: isBac ? Colors.blueGrey : Colors.grey,
                              child: Text(
                                "Miền Bắc",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
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
                              if (isBac) {
                                setState(() {
                                  isBac = false;
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              color: !isBac ? Colors.blueGrey : Colors.grey,
                              child: Text(
                                "Miền Nam",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
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
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                color: Colors.blue,
                padding: EdgeInsets.all(20),
                child: Text(
                  "Lưu",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget content() {
    List<Data> listData = isBac ? listDataBac : listDataNam;
    return Container(
      child: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            Data data = listData[index];
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: new TextEditingController(),
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
}
