import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shakwa/Core/cache_helper.dart';

// دالة لمعالجة الرسائل في الخلفية (يجب أن تكون خارج الكلاس وخارج Main)
@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // إعداد قناة الإشعارات المحلية للأندرويد
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  // الوظيفة الرئيسية لتهيئة الإشعارات
  Future<void> initNotifications() async {
    // 1. طلب الإذن (مهم جداً لـ iOS و Android 13+)
    await _firebaseMessaging.requestPermission();

    // 2. الحصول على التوكن (لإرسال إشعارات لهذا الجهاز تحديداً)
    final fCMToken = await _firebaseMessaging.getToken();
    CacheHelper().saveData(key: 'fcm', value: fCMToken);
    print('FCM Token: $fCMToken');

    // 3. تهيئة الإشعارات المحلية
    initLocalNotifications();

    // 4. إعداد معالج الخلفية
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // 5. الاستماع للرسائل والتطبيق مفتوح (Foreground)
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/ic_launcher', // تأكد من وجود الأيقونة
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });

    // 6. التعامل مع فتح التطبيق من الإشعار
    initPushNotifications();
  }

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        // هنا يمكنك التوجيه لصفحة معينة عند الضغط على الإشعار المحلي
        final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
        handleMessage(message);
      },
    );

    final platform =
        _localNotifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotifications() async {
    // التعامل مع فتح التطبيق من حالة Terminated
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // التعامل مع فتح التطبيق من حالة Background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // هنا تضع كود التوجيه (Navigation)
    // مثال: navigatorKey.currentState?.pushNamed('/notification_screen', arguments: message);
    print('تم فتح الإشعار: ${message.notification?.title}');
  }
}
