// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/model/product_model.dart';

class ProductShowCaseTile extends StatelessWidget {
  const ProductShowCaseTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() async {}),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 5.w,
          ),
          child: Column(
            children: [
              ProductImage(product: product),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          "Product: ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          )),
                        ),
                        Text(
                          product.productName,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        Text(
                          "M.R.P: ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          )),
                        ),
                        Text(
                          product.productPrice,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final ProductModel product;
  const ProductImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: CachedNetworkImage(
          fit: BoxFit.fitWidth,
          imageUrl: product.productImageUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
          errorWidget: (context, url, error) {
            return const Icon(Icons.error);
          }),
    );
  }
}
