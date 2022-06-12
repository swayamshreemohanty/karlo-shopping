import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/product_management/logic/product_management/productmanagement_bloc.dart';
import 'package:shopping_app/utility/loading_indicator.dart';

class ProductManageDialog extends StatefulWidget {
  final ProductModel? editableProduct;
  final bool editproduct;
  const ProductManageDialog({
    Key? key,
    this.editableProduct,
    this.editproduct = false,
  }) : super(key: key);

  @override
  _ProductManageDialogState createState() => _ProductManageDialogState();
}

class _ProductManageDialogState extends State<ProductManageDialog> {
  final _formKey = GlobalKey<FormState>();
  late ProductModel product;
  final _productIdTextController = TextEditingController();
  final _productNameTextController = TextEditingController();
  final _productImageUrlTextController = TextEditingController();
  final _productPriceTextController = TextEditingController();
  final _productDescriptionTextController = TextEditingController();

  @override
  void initState() {
    if (widget.editableProduct != null) {
      product = widget.editableProduct!;
      _productIdTextController.text = product.productId ?? '';
      _productNameTextController.text = product.productName;
      _productImageUrlTextController.text = product.productImageUrl;
      _productPriceTextController.text = product.productPrice;
      _productDescriptionTextController.text = product.productDescription;
    } else {
      product = ProductModel.blankInitialize();
    }
    super.initState();
  }

  @override
  void dispose() {
    _productIdTextController.clear();
    _productNameTextController.clear();
    _productImageUrlTextController.clear();
    _productPriceTextController.clear();
    _productDescriptionTextController.clear();
    super.dispose();
  }

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      //close the soft keyboard after submit button click.
      FocusScope.of(context).unfocus();
      if (widget.editproduct) {
        context
            .read<ProductmanagementBloc>()
            .add(EditProduct(product: product, context: context));
      } else {
        product.createdAt = DateTime
            .now(); //Assign the time, when the user click the submit button.(only for newly added product)
        context
            .read<ProductmanagementBloc>()
            .add(AddProduct(product: product, context: context));
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ProductTextField(
                textCapitalization: TextCapitalization.words,
                productTextController: _productNameTextController,
                hintText: "Product Name",
                onChanged: (value) {
                  product.productName = value.trim();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field can't be empty";
                  }
                  return null;
                },
              ),
              ProductTextField(
                productTextController: _productImageUrlTextController,
                keyboardType: TextInputType.url,
                hintText: "Product Image URL",
                onChanged: (value) {
                  product.productImageUrl = value.trim();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field can't be empty";
                  }
                  return null;
                },
              ),
              ProductTextField(
                keyboardType: TextInputType.number,
                productTextController: _productPriceTextController,
                hintText: "Product price",
                onChanged: (value) {
                  product.productPrice = value.trim();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field can't be empty";
                  }
                  return null;
                },
              ),
              ProductTextField(
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                productTextController: _productDescriptionTextController,
                hintText: "Product description...",
                onChanged: (value) {
                  product.productDescription = value.trim();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field can't be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: _trySubmit,
                child:
                    BlocBuilder<ProductmanagementBloc, ProductmanagementState>(
                  builder: (context, state) {
                    if (state is ProductActionLoading) {
                      return const LoadingIndicator(
                        color: Colors.white,
                      );
                    } else {
                      return Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTextField extends StatelessWidget {
  final TextEditingController productTextController;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  const ProductTextField({
    Key? key,
    required this.productTextController,
    this.hintText,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    required this.validator,
    required this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: TextFormField(
        maxLines: maxLines,
        controller: productTextController,
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 20.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
