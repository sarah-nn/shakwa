import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/Network/Api/api_consumer.dart';
import 'package:shakwa/Data/Models/noti_model.dart';

class NotiRepo {
  final Api dio;

  NotiRepo(this.dio);

  Future<List<NotificationModel>> getAllNotifications() async {
    final response = await dio.get(EndPoints.allNotification);

    final List data = response['data'];

    return data.map((json) => NotificationModel.fromJson(json)).toList();
  }
}
