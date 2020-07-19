import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const.dart';
import '../data.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  ObservableList<Data> listDataBac = new ObservableList();

  @observable
  ObservableList<Data> listDataNam = new ObservableList();

  @observable
  bool isBac = true;

  @observable
  double timeRandom = 15;

  @action
  setIsBac(bool value) {
    isBac = value;
  }

  @action
  setTimeRandom(double value) {
    this.timeRandom = timeRandom;
  }

  @action
  loadLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataBac = prefs.getString("BAC");
    String dataNam = prefs.getString("NAM");

    double time = prefs.getDouble("TIME");
    if(time != null){
      setTimeRandom(time);
    }

    if (dataBac != null && dataBac != "") {
      List<Data> data =
          (json.decode(dataBac) as List).map((i) => Data.fromJson(i)).toList();
      if (data != null && data.length > 0) {
        updateDataBac(data);
      }
    }

    if (dataNam != null && dataNam != "") {
      List<Data> data =
          (json.decode(dataNam) as List).map((i) => Data.fromJson(i)).toList();
      if (data != null && data.length > 0) {
        updateDataNam(data);
      }
    }
  }

  @action
  updateDataBac(List<Data> data) {
    this.listDataBac.clear();
    this.listDataBac.addAll(data);
  }

  @action
  updateDataNam(List<Data> data) {
    this.listDataNam.clear();
    this.listDataNam.addAll(data);
  }

  _AppStore() {
    updateDataBac(Const.dataBAC);
    updateDataNam(Const.dataNAM);
  }

  Future<void> saveDataLocal(String childName, String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(childName, json);
  }

  saveTimeLocal(double time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("TIME", time);
  }
}
