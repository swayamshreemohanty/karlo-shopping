import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/my_order/logic/my_order/myorder_cubit.dart';
import 'package:shopping_app/my_order/widget/my_order_widget.dart';
import 'package:shopping_app/utility/loading_indicator.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);
  static const routeName = '/my_order_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Orders",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            fontWeight: FontWeight.w700,
            fontFamily: 'Lato',
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<List<CartProductSummary?>>(
        stream: context.read<MyorderCubit>().fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          } else {
            final logs = snapshot.data ?? [];
            if (logs.isEmpty) {
              return const Center(
                child: Text("No orders found."),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: logs.length,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: ScaleAnimation(
                    child: Card(
                      child: MyOrderWidget(
                        cartproductsummary: logs[index]!,
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
