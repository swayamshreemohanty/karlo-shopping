import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/product_management/widgets/product_showcase_tile.dart';

class MyOrderWidget extends StatelessWidget {
  final CartProductSummary cartproductsummary;
  const MyOrderWidget({
    Key? key,
    required this.cartproductsummary,
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 150.h,
              width: 100.w,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartproductsummary.cartProductsList.length,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: ScaleAnimation(
                    child: Card(
                      child: Column(
                        children: [
                          ProductImage(
                            product: cartproductsummary
                                .cartProductsList[index].product,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartproductsummary
                                        .cartProductsList[index]
                                        .product
                                        .productName,
                                    overflow: TextOverflow.ellipsis,
                                    style: _titleTextStyle(),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    "M.R.P ${cartproductsummary.cartProductsList[index].product.productPrice}",
                                    overflow: TextOverflow.ellipsis,
                                    style: _priceTextStyle(),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
