// mqtt_service.dart
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:test_firebase3/file_management.dart';

class MqttService {
  late MqttServerClient client;
  // Function(String)? onMessageReceived;

    void _saveData(String doc, String message) async {

      List<String> tachChuoi = message.split(" ");
      String phan1 = tachChuoi[0]; // "SttDoor"
      String phan2 = tachChuoi.sublist(1).join(" "); // "mo cua"
  
      print("Phần 1: $phan1");
      print("Phần 2: $phan2");
    if(phan1 == 'release'){
      FirebaseFirestore.instance
        .collection('elockers')
        .doc(doc)
        .update({
      'SttDoor' : false,
      'SttDH' : false,
      'id' : "",
      'status' : false,
      'name' : "",
    });
    }else{
          bool boolValue = phan2.toLowerCase() == 'true'; // chuyển thành boolean
          FirebaseFirestore.instance.collection('elockers').doc(doc).update({phan1: boolValue,});
    }
  }
  // void setMessageCallback(Function(String) callback) {
  //   onMessageReceived = callback;
  // }
  // Khởi tạo MQTT client
  Future<void> connect() async {
    client = MqttServerClient('broker.emqx.io', "tannghia");
    client.keepAlivePeriod = 60;
    client.autoReconnect = true;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = (String topic) {
      print("MQTT subcribed to $topic");
    };
    
    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print(e.toString());
    }

    client.subscribe("elocker/locker1", MqttQos.atLeastOnce);

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print("connect MQTT successfully");
       client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> mqttReceivedMessage) {
        
        String topicReceived = mqttReceivedMessage[0].topic;
        final recMess = mqttReceivedMessage[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print("topic $topicReceived");
        String lastSegment = topicReceived.split('/').last;
        // onMessageReceived?.call(payload);
        print("message $payload");
        print("Locker ID: $lastSegment");
        _saveData(lastSegment, payload);
        print("================================");
      });
    }else{
       print('failed to connect MQTT');
      client.disconnect();
    }
  }
  
  void onConnected() {
    print("connected");
  }
  void onDisconnected() {
    print("disconnected");
  }
    void disconnect() {
    client.disconnect();
  }

  void subscribeMQTT(String topic) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
    client.subscribe(topic, MqttQos.atLeastOnce);
    }else{
      print("error subcribe");
    }
  }
 

  void publishMQTT(String topic, String message) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
      print('Đã gửi tin nhắn: $message');
    }
    else{
      print("error publish");
    }
  }
}