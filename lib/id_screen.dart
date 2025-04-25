import 'dart:math';

import 'package:flutter/material.dart';
import 'package:datn_project/infor_screen.dart';
// import 'package:datn_project/locker_data.dart';
import 'package:datn_project/locker_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdScreen extends StatefulWidget {
  const IdScreen(this.lockersNumber, {super.key});
  final String lockersNumber;

  @override
  State<IdScreen> createState() {
    return _IdScreenState();
  }
}

class _IdScreenState extends State<IdScreen> {
  bool status = false;
  String id = "";
  void readData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Đọc dữ liệu từ document "locker1" trong collection "lockers"
    DocumentSnapshot snapshot =
        await firestore.collection('elockers').doc(widget.lockersNumber).get();

    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>; // Ép kiểu về Map
      setState(() {
        status = data['status']; // Lấy giá trị của 'status'
        id = data['id'];
      });

      // lockers[widget.lockersNumber] = status;
      // lockersId[widget.lockersNumber] = id;
      print('Locker status: $status');
      print('locker id: $id');
      // print(' status: ${lockers[widget.lockersNumber]}');
      // print(' id: ${lockersId[widget.lockersNumber]}');
    } else {
      print('Document không tồn tại!');
    }
  }

  void saveData(bool status, String id, String name) async {
    FirebaseFirestore.instance
        .collection('elockers')
        .doc(widget.lockersNumber)
        .update({
      'status': status,
      'id': id,
      'name': name,
    });
  }
  void saveTime(String fieldTime) async {
    FirebaseFirestore.instance
        .collection('elockers')
        .doc(widget.lockersNumber)
        .update({
      fieldTime: FieldValue.serverTimestamp(),
    });
  }

  var _saveId = '';
  void _saveIdInput(String inputValue) {
    _saveId = inputValue;
  }
  var _saveName = '';
  void _saveNameInput(String inputValue) {
    _saveName = inputValue;
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Lỗi"),
        content: Text("ID không đúng, vui lòng nhập lại."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Đóng hộp thoại
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void showIdDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Lỗi"),
        content: Text("vui lòng đăng kí ID hoặc nhập Họ Tên."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Đóng hộp thoại
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _updateLockerSaveId() {
    if (!status) {
      if(_saveName != "" && _saveId != ""){
        saveData(true, _saveId, _saveName);
        saveTime("RegAt");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InforScreen(widget.lockersNumber)));
      }else{
        showIdDialog(context);
      }
    } else {
      if (id == _saveId) {
        saveTime("loginAt");
        print('dung');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InforScreen(widget.lockersNumber)));
      } else {
        showErrorDialog(context);
        print("sai");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    print("trang thai:$status");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child:  Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "eLocker",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                status ? "Nhập ID để đăng nhập" : "Nhập ID để đăng ký",
                style: TextStyle(fontSize: 16)
              ),
              SizedBox(
                height: 12,
              ),
              // TextField(
              //   onChanged: _saveIdInput,
              //   maxLength: 10,
              // ),
              if(!status)
              SizedBox(
                width: 250, // Đặt chiều rộng mong muốn
                child: TextField(
                  onChanged: _saveNameInput,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), // Thêm viền
                    hintText: 'Nhập Họ Tên',
                  ),
                ),
              ),

              SizedBox(
                width: 250, // Đặt chiều rộng mong muốn
                child: TextField(
                  onChanged: _saveIdInput,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), // Thêm viền
                    hintText: 'Nhập ID',
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _updateLockerSaveId();
                },
                icon: Icon(Icons.login),
                label: Text(status ? "Đăng nhập" : "Đăng ký"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(180, 40),
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     _updateLockerSaveId();
              //   },
              //   style: TextButton.styleFrom(foregroundColor: Colors.black),
              //   child: Text(
              //     status ? "Đăng nhập" : "Đăng ký",
              //     //style: TextStyle(fontSize: 18),
              //   ),
              // ),
              SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LockerScreen()));
                },
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text(
                  "🔙 Back",
                  //style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}