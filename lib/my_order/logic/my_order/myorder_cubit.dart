import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/my_order/repository/my_order_repository.dart';

part 'myorder_state.dart';

class MyorderCubit extends Cubit<MyorderState> {
  MyorderCubit() : super(MyorderInitial());

  Stream<List<CartProductSummary?>> fetchOrders() {
    return MyOrderRepository().streamrOrdersLog();
  }
}
