import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/cart/logic/cart_management/cart_management_cubit.dart';
import 'package:shopping_app/cart/logic/checkout/checkout_cubit.dart';
import 'package:shopping_app/cart/widget/cart_item_widget.dart';
import 'package:shopping_app/home/widgets/app_bar_header.dart';
import 'package:shopping_app/utility/loading_indicator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cart_screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _noItemInCart = Image.asset(
    "assets/EmptyCart.png",
    width: 100.w,
    height: 150.h,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const AppBarHeader(title: "Your Cart"),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: 450.w,
            child: BlocBuilder<CartManagementCubit, CartManagementState>(
              builder: (context, state) {
                if (state is CartUpdated) {
                  if (state.cartProducts.isEmpty) {
                    return _noItemInCart;
                  } else {
                    return Column(children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.cartProducts.length,
                          itemBuilder: (_, index) => CartItemWidget(
                            cartproduct: state.cartProducts[index],
                            cartScreenContext: context,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(mainAxisSize: MainAxisSize.min, children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                state.cartTotalPrice,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Lato',
                                ),
                              )
                            ]),
                            ElevatedButton(
                              style: ButtonStyle(
                                // foregroundColor: MaterialStateProperty.all(
                                //   Colors.white,
                                // ),
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                context.read<CheckoutCubit>().checkOut(
                                      context,
                                      cartProducts: state.cartProducts,
                                      cartTotalPrice: state.cartTotalPrice,
                                    );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40.w,
                                  vertical: 15.h,
                                ),
                                child:
                                    BlocBuilder<CheckoutCubit, CheckoutState>(
                                  builder: (context, state) {
                                    if (state is CheckoutLoading) {
                                      return SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: const LoadingIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "Checkout",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }
                } else if (state is AddToCartInitial) {
                  return _noItemInCart;
                } else {
                  return const LoadingIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
