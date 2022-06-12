import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/cart/logic/cart_management/cart_management_cubit.dart';
import 'package:shopping_app/utility/loading_indicator.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _cartItemNumberStyle() => TextStyle(
          fontSize: 10.sp,
          color: Colors.white,
        );
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.red,
      ),
      constraints: BoxConstraints(
        minWidth: 16.w,
        minHeight: 16.w,
      ),
      child: BlocBuilder<CartManagementCubit, CartManagementState>(
        builder: (context, state) {
          if (state is CartUpdated) {
            return Text(
              state.cartProducts.length.toString(),
              textAlign: TextAlign.center,
              style: _cartItemNumberStyle(),
            );
          } else if (state is AddToCartLoading) {
            return SizedBox(
                height: 8.h,
                width: 8.w,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: LoadingIndicator(
                    color: Colors.white,
                    strokeWidth: 2.w,
                  ),
                ));
          } else {
            return Text(
              "0",
              textAlign: TextAlign.center,
              style: _cartItemNumberStyle(),
            );
          }
        },
      ),
    );
  }
}
