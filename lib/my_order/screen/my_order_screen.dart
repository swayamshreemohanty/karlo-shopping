// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/home/widgets/app_bar_header.dart';
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
        title: const AppBarHeader(title: "Orders"),
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Card(
                        child: MyOrderWidget(
                          cartproductsummary: logs[index]!,
                        ),
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
