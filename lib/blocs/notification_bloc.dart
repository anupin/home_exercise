import 'package:home_exercise/models/notification_model.dart';
import 'package:home_exercise/services/repository.dart';
import 'package:rxdart/rxdart.dart';

///Notification bloc
class NotificationBloc {
  final _notificationsFetcher = PublishSubject<List<NotificationModel>>();

  Stream<List<NotificationModel>> get notifications => _notificationsFetcher.stream;

  void getNotifications() async => _notificationsFetcher.sink.add(await Repository.getNotifications());

  dispose() {
    _notificationsFetcher.close();
  }
}