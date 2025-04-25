import 'package:flutter/material.dart';
import 'package:datn_project/locker_button.dart';
import 'package:datn_project/connect_mqtt.dart';
// import 'package:datn_project/mqtt_service.dart';

//import 'package:datn_project/locker_data.dart';

const lockersNumber1 = ['locker1', 'locker2', 'locker3'];
const lockersNumber2 = ['locker4', 'locker5', 'locker6'];

class LockerScreen extends StatefulWidget {
  const LockerScreen({super.key});
  @override
  State<LockerScreen> createState() {
    return _LockerScreenState();
  }
}

class _LockerScreenState extends State<LockerScreen> {
  static bool _hasConnected = false;
  @override
  void initState() {
    super.initState();
    if (!_hasConnected) {
      connectMqtt();
      _hasConnected = true;
    }
    
  }
  // Future<void> _connectMqtt() async {
  //   await mqttService.connect();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "eLocker",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...lockersNumber1.map((items) {
                      //... dùng để [[1,2,3],4] khi dùng [1,2,3,4]
                      return LockerButton(items);
                    }),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...lockersNumber2.map((items) {
                      //... dùng để [[1,2,3],4] khi dùng [1,2,3,4]
                      return LockerButton(items);
                    }),
                  ],
                )
              ],
            ),
          )),
    );
  }
}



// class _LockerScreenState extends State<LockerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             decoration: BoxDecoration(color: Colors.deepPurple),
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text("eLocker"),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => IdScreen("locker1")));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius
//                                 .zero, // Không bo góc => Nút vuông hoặc chữ nhật
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 40, vertical: 40), // Kích thước nút
//                         ),
//                         child: Text("tu 1"),
//                       ),

//                       SizedBox(
//                         width: 5,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => IdScreen("locker2")));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius
//                                 .zero, // Không bo góc => Nút vuông hoặc chữ nhật
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 40, vertical: 40), // Kích thước nút
//                         ),
//                         child: Text("tu 2"),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => IdScreen("locker3")));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius
//                                 .zero, // Không bo góc => Nút vuông hoặc chữ nhật
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 40, vertical: 40), // Kích thước nút
//                         ),
//                         child: Text("tu 3"),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => IdScreen("locker4")));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius
//                                 .zero, // Không bo góc => Nút vuông hoặc chữ nhật
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 40, vertical: 40), // Kích thước nút
//                         ),
//                         child: Text("tu 4"),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => IdScreen("locker5")));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius
//                                 .zero, // Không bo góc => Nút vuông hoặc chữ nhật
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 40, vertical: 40), // Kích thước nút
//                         ),
//                         child: Text("tu 5"),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => IdScreen("locker6")));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius
//                                 .zero, // Không bo góc => Nút vuông hoặc chữ nhật
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 40, vertical: 40), // Kích thước nút
//                         ),
//                         child: Text("tu 6"),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )),
//       );
//   }
// }