import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'database/hive_utils.dart';
import 'database/table_constant.dart';

class HiveDBManager {

  //create single instance of Database
  static final HiveDBManager _singleton = HiveDBManager();

  //getter for class instance
  static HiveDBManager get instance => _singleton;

  late Box box;

  void onInitLocalDb() async {
    // initialize the hive local database
    box = await HiveUtil.openBox(TableConstant.localDB);
  }

  read(String key) {
    // for getting the table data
    final value = box.get(key);
    if (value != null) return json.decode(value);
    return null;
  }

  save(String key, value) async {
    // for storing in table
    try {
      await box.put(key, json.encode(value));
    } catch (e) {
      debugPrint("Save error : $e");
    }
  }
}
