import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/product_management/widgets/product_showcase_tile.dart';

class MyOrderWidget extends StatelessWidget {
  final CartProductSummary cartproductsummary;
  const MyOrderWidget({
    Key? key,
    required this.cartproductsummary,
  }) : super(key: key);

  _titleTextStyle() => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      );

  _priceTextStyle() => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
      );
  _header() => GoogleFonts.poppins(
          textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
      ));
  _titleContentTextStyle() => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Order Id: ',
                style: _header(),
              ),
              Text(
                cartproductsummary.orderId!,
                style: _titleContentTextStyle(),
              ),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Quantity: ',
                style: _header(),
              ),
              Text(
                cartproductsummary.cartProductsList.length.toString(),
                style: _titleContentTextStyle(),
              ),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Order Time: ',
                style: _header(),
              ),
              Text(
                DateFormat('yyyy-MM-dd kk:mm')
                    .format(cartproductsummary.orderCreatedAt!),
                style: _titleContentTextStyle(),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ListView.builder(
            shrinkWrap: true,
            itemCount: cartproductsummary.cartProductsList.length,
            itemBuilder: (context, index) =>
                AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: ScaleAnimation(
                child: Row(
                  children: [
                    SizedBox(
                        height: 80.h,
                        width: 120.w,
                        child: ProductImage(
                          product: cartproductsummary
                              .cartProductsList[index].product,
                        )),
                    SizedBox(width: 20.w),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartproductsummary
                                .cartProductsList[index].product.productName,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
