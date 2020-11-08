import 'package:home_exercise/models/order_model.dart';
import 'package:home_exercise/services/repository.dart';
import 'package:rxdart/rxdart.dart';

///ORder bloc
class OrdersBloc {
  final _ordersFetcher = PublishSubject<List<OrderModel>>();
  final _awaitingsFetcher = PublishSubject<List<OrderModel>>();

  Stream<List<OrderModel>> get orders => _ordersFetcher.stream;
  Stream<List<OrderModel>> get awaitings => _awaitingsFetcher.stream;

  void getOrders(String restaurantId) async => _ordersFetcher.sink.add(await Repository.getOrders(restaurantId));
  void getAwaitings(String restaurantId) async => _awaitingsFetcher.sink.add(await Repository.getAwaitings(restaurantId));

  dispose() {
    _ordersFetcher.close();
    _awaitingsFetcher.close();
  }
}