import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/model/product_model.dart';

class ProductManageDialog extends StatefulWidget {
  final ProductModel? product;
  final bool editproduct;
  const ProductManageDialog({
    Key? key,
    this.product,
    this.editproduct = false,
  }) : super(key: key);

  @override
  _ProductManageDialogState createState() => _ProductManageDialogState();
}

class _ProductManageDialogState extends State<ProductManageDialog> {
  final _formKey = GlobalKey<FormState>();

  final _productIdTextController = TextEditingController();
  final _productNameTextController = TextEditingController();
  final _productImageUrlTextController = TextEditingController();
  final _productPriceTextController = TextEditingController();
  final _productDescriptionTextController = TextEditingController();

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      //close the soft keyboard after submit button click.
      FocusScope.of(context).unfocus();
      if (widget.editproduct) {
      } else {}
      Navigator.of(context).pop();
    }
    return;
  }

  @override
  void initState() {
    if (widget.product != null) {
      _productIdTextController.text = widget.product!.productId ?? '';
      _productNameTextController.text = widget.product!.productName;
      _productImageUrlTextController.text = widget.product!.productImageUrl;
      _productPriceTextController.text = widget.product!.productPrice;
      _productDescriptionTextController.text =
          widget.product!.productDescription;
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
                  _productNameTextController.text = value.trim();
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
                  _productImageUrlTextController.text = value.trim();
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
                  _productPriceTextController.text = value.trim();
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
                  _productDescriptionTextController.text = value.trim();
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
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
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