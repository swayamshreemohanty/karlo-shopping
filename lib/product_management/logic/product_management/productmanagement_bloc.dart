// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/product_management/repository/product_management_repository.dart';
import 'package:shopping_app/utility/show_snak_bar.dart';
part 'productmanagement_event.dart';
part 'productmanagement_state.dart';

class ProductmanagementBloc
    extends Bloc<ProductmanagementEvent, ProductmanagementState> {
  ProductmanagementBloc() : super(ProductmanagementInitial()) {
    void closeTheDialogBox(BuildContext context) {
      Navigator.pop(context);
    }

    on<ProductmanagementEvent>((event, emit) async {
      if (event is AddProduct) {
        emit(ProductActionLoading());
        try {
          await productManagementRepository.addProduct(
            productModel: event.product,
          );
          emit(ProductActionCompleted());
          ShowSnackBar.showSnackBar(
            event.context,
            "${event.product.productName} is added.",
          );
          closeTheDialogBox(event.context);
        } catch (e) {
          emit(ProductActionFailed());
          ShowSnackBar.showSnackBar(
            event.context,
            "Unable to add the product",
          );
          closeTheDialogBox(event.context);
        }
      } else if (event is EditProduct) {
        try {
          emit(ProductActionLoading());
          await productManagementRepository.editProduct(
            productModel: event.product,
          );
          emit(ProductActionCompleted());
          ShowSnackBar.showSnackBar(
            event.context,
            "${event.product.productName} is edited.",
          );
          closeTheDialogBox(event.context);
        } catch (e) {
          emit(ProductActionFailed());
          ShowSnackBar.showSnackBar(
            event.context,
            "Unable to edit the product.",
          );
          closeTheDialogBox(event.context);
        }
      } else if (event is DeleteProduct) {
        try {
          await productManagementRepository.deleteProduct(
            productModel: event.product,
          );
          ShowSnackBar.showSnackBar(
            event.context,
            "${event.product.productName} is deleted.",
          );
          closeTheDialogBox(event.context);
        } catch (e) {
          ShowSnackBar.showSnackBar(
            event.context,
            "Unable to delete the product.",
          );
          closeTheDialogBox(event.context);
        }
      }
    });
  }
  final productManagementRepository = ProductManagementRepository();

  Stream<List<ProductModel?>> fetchProducts() {
    return productManagementRepository.streamProductsLog();
  }
}
