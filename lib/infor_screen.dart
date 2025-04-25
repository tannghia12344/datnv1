import 'package:flutter/material.dart';
import 'package:datn_project/locker_screen.dart';
import 'package:datn_project/locker_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_project/connect_mqtt.dart';


class InforScreen extends StatefulWidget {
  const InforScreen(this.lockersNumber, {super.key});
  final String lockersNumber;
  @override
  State<InforScreen> createState() {
    return _InforScreenState();
  }
}

class _InforScreenState extends State<InforScreen> {
  // void _saveData(bool status, String id) async {
  //   lockers[widget.lockersNumber] = status;
  //   lockersId[widget.lockersNumber] = id;
  //   FirebaseFirestore.instance
  //       .collection('elockers')
  //       .doc(widget.lockersNumber)
  //       .set({
  //     'status': status,
  //     'id': id,
  //   });
  // }

  //   void _saveData(bool status) async {
  //   FirebaseFirestore.instance
  //       .collection('elockers')
  //       .doc(widget.lockersNumber)
  //       .update({
  //     'active': status,
  //   });
  // }

  Stream<DocumentSnapshot> getLockerStatus(String lockerId) {
    return FirebaseFirestore.instance
        .collection('elockers')
        .doc(lockerId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getLockerStatus(widget.lockersNumber),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Hiển thị loading khi chưa có dữ liệu
        }
        var data = snapshot.data!.data() as Map<String, dynamic>?;

        bool sttDoor = data?['SttDoor']; // Lấy trạng thái locker
        bool sttDH = data?['SttDH']; // Lấy trạng thái locker
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'elocker',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("trạng thái tủ: ${sttDoor ? '🔓 Cửa đang mở' : '🔒 Cửa đang đóng'}", style: TextStyle(fontSize: 16)),
                  // SizedBox(
                  //   height: 40,
                  // ),
                  Text("trạng thái đơn hàng: ${sttDH ? '📦 Có đơn hàng' : '❌ Không có đơn hàng'}", style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {mqttService.publishMQTT('elocker', "${widget.lockersNumber.replaceAll("locker", "")} close");},
                    icon: Icon(Icons.lock),
                    label: Text("Đóng cửa"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {mqttService.publishMQTT('elocker', "${widget.lockersNumber.replaceAll("locker", "")} open");},
                    icon: Icon(Icons.lock_open),
                    label: Text("Mở cửa"),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     mqttService.publishMQTT('elocker', '1');
                  //   },
                  //   style: TextButton.styleFrom(foregroundColor: Colors.black),
                  //   child: Text(
                  //     "Mở cửa",
                  //     //style: TextStyle(fontSize: 18),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 40,
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     _saveData(false, "");
                  //   },
                  //   style: TextButton.styleFrom(foregroundColor: Colors.black),
                  //   child: Text(
                  //     "Lấy đồ",
                  //     //style: TextStyle(fontSize: 18),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      print(lockers);
                      print(lockersId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LockerScreen()));
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: Text("🔙 Quay lại"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
