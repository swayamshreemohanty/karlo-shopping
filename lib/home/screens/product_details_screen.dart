// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/home/widgets/app_bar_header.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/product_management/widgets/product_showcase_tile.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/product_details_screen';

  @override
  Widget build(BuildContext context) {
    final productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const AppBarHeader(title: "Details"),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                width: 450.w,
                height: 250.h,
                child: Hero(
                  tag: productModel.productImageUrl,
                  child: ProductImage(product: productModel),
                ),
              ),
              ProductDetails(
                header: "Product Name: ",
                content: productModel.productName,
              ),
              ProductDetails(
                header: "Product Price: ",
                content: productModel.productPrice,
              ),
              ProductDetails(
                header: "Product Description: ",
                content: productModel.productDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final String header;
  final String content;
  const ProductDetails({
    Key? key,
    required this.header,
    required this.content,
  }) : super(key: key);
  _header() => GoogleFonts.poppins(
          textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ));
  _titleContentTextStyle() => GoogleFonts.poppins(
          textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ));
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            Text(
              header,
              style: _header(),
            ),
            SizedBox(height: 5.h),
            Text(
              content,
              style: _titleContentTextStyle(),
            ),
          ],
        ),
      );
}
