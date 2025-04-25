import 'package:datn_project/mqtt_service.dart';

final MqttService mqttService = MqttService();

  Future<void> connectMqtt() async {
    await mqttService.connect();
  }