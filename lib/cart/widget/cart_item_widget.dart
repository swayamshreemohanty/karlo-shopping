import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/cart/logic/cart_management/cart_management_cubit.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/product_management/widgets/product_showcase_tile.dart';

class CartItemWidget extends StatelessWidget {
  final CartProductModel cartproduct;
  final BuildContext cartScreenContext;
  const CartItemWidget({
    Key? key,
    required this.cartproduct,
    required this.cartScreenContext,
  }) : super(key: key);

  _titleTextStyle() => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      );

  _priceTextStyle() => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                        height: 80.h,
                        width: 100.w,
                        child: ProductImage(
                          product: cartproduct.product,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartproduct.product.productName,
                              overflow: TextOverflow.ellipsis,
                              style: _titleTextStyle(),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "M.R.P ${cartproduct.product.productPrice}",
                              overflow: TextOverflow.ellipsis,
                              style: _priceTextStyle(),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<CartManagementCubit>(context)
                        .deleteProductfromServerCart(
                      product: cartproduct.product,
                      context: cartScreenContext,
                    );
                  },
                  icon: const Icon(Icons.cancel))
            ],
          ),
        ),
      ),
    );
  }
}
