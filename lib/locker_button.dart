import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_project/id_screen.dart';
//import 'package:datn_project/locker_data.dart';

class LockerButton extends StatelessWidget {
  const LockerButton(this.idLocker, {super.key});
  final String idLocker;
  Stream<DocumentSnapshot> getLockerStatus(String lockerId) {
    return FirebaseFirestore.instance
        .collection('elockers')
        .doc(lockerId)
        .snapshots();
  }

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getLockerStatus(idLocker),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Hiển thị loading khi chưa có dữ liệu
        }
        var data = snapshot.data!.data() as Map<String, dynamic>?;

        bool status = data?['status']; // Lấy trạng thái locker

        return GestureDetector(
          onTap: () {
            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IdScreen(idLocker)),
            );
          },
          child: Stack(
            children: [
              // Vẽ dấu X nếu isXVisible == true
              CustomPaint(
                size: Size(100, 100), // Kích thước nút
                painter: XPainter(status), // Truyền trạng thái vẽ X
              ),
              // Nút hình vuông có viền đen
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 244, 245, 247).withOpacity(0.3),
                  border:
                      Border.all(color: Colors.black, width: 2), // Viền đen 2px
                ),
                child: Text(
                  idLocker,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Hàm đóng/mở locker
//   void toggleLocker(String lockerId, bool status) {
//     FirebaseFirestore.instance.collection('elockers').doc(lockerId).update({
//       'status': !status,
//     });
//   }
}

class XPainter extends CustomPainter {
  final bool isXVisible;

  XPainter(this.isXVisible);

  @override
  void paint(Canvas canvas, Size size) {
    if (isXVisible) {
      final paint = Paint()
        ..color = Colors.red // Màu của dấu X
        ..strokeWidth = 0 // Độ dày đường chéo
        ..style = PaintingStyle.stroke;

      // Vẽ hai đường chéo tạo thành dấu X
      canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
      canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant XPainter oldDelegate) {
    return oldDelegate.isXVisible !=
        isXVisible; // Vẽ lại nếu trạng thái thay đổi
  }
}




// import 'package:flutter/material.dart';
// import 'package:datn_project/id_screen.dart';


// class LockerButton extends StatelessWidget {
//   const LockerButton(this.isXVisible, this.idLocker, this.numbers, {super.key});
//   final String idLocker;
//   final String numbers;
//   final bool isXVisible;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => IdScreen(idLocker)),
//         );
//       },
//       child: Stack(
//         children: [
//           // Vẽ dấu X nếu isXVisible == true
//           CustomPaint(
//             size: Size(100, 100), // Kích thước nút
//             painter: XPainter(isXVisible), // Truyền trạng thái vẽ X
//           ),
//           // Nút hình vuông có viền đen
//           Container(
//             width: 100,
//             height: 100,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 244, 245, 247).withOpacity(0.3),
//               border: Border.all(color: Colors.black, width: 2), // Viền đen 2px
//             ),
//             child: Text(
//               numbers,
//               style: TextStyle(fontSize: 18, color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class XPainter extends CustomPainter {
//   final bool isXVisible;

//   XPainter(this.isXVisible);

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (isXVisible) {
//       final paint = Paint()
//         ..color = Colors.red // Màu của dấu X
//         ..strokeWidth = 0 // Độ dày đường chéo
//         ..style = PaintingStyle.stroke;

//       // Vẽ hai đường chéo tạo thành dấu X
//       canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
//       canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant XPainter oldDelegate) {
//     return oldDelegate.isXVisible !=
//         isXVisible; // Vẽ lại nếu trạng thái thay đổi
//   }
// }
