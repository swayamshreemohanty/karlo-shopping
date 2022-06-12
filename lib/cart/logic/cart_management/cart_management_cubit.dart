// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/cart/repository/cart_repository.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/utility/show_snak_bar.dart';
part 'cart_management_state.dart';

class CartManagementCubit extends Cubit<CartManagementState> {
  CartManagementCubit() : super(AddToCartInitial());
  final _cartRepository = CartRepository();
  int cartItem = 0;
  List<CartProductModel> _cartData = [];

  Future<void> fetchProductsofServerCart(
      {required BuildContext context}) async {
    try {
      emit(AddToCartLoading());
      _cartData = await _cartRepository.fetchCartProductsFromServerCart();
      cartItem = _cartData.length;
      emit(CartUpdated(cartProducts: _cartData));
    } catch (e) {
      emit(CartUpdated(cartProducts: _cartData));
    }
  }

  Future<void> deleteProductfromServerCart({
    required ProductModel product,
    required BuildContext context,
  }) async {
    try {
      emit(AddToCartLoading());
      await _cartRepository.deleteProductsFromServerCart(product: product);

      await fetchProductsofServerCart(context: context);
    } catch (e) {
      emit(CartUpdated(cartProducts: _cartData));
    }
  }

  Future<void> addProducttoServerCart({
    required ProductModel product,
    required BuildContext context,
  }) async {
    try {
      bool allowUndo = true;
      //Cart item assign to 1 because to break the cartItem !=0 condition and
      //show the loading spinner on Bottom screen nav bar Shopping bag.
      cartItem = 1;
      emit(AddToCartLoading());
      await _cartRepository.addProductToServerCart(product: product);
      await fetchProductsofServerCart(context: context);
      for (var element in _cartData) {
        if (element.product.productId == product.productId &&
            element.quantity > 1) {
          allowUndo = false;
        }
      }
      ShowSnackBar.showSnackBar(
        context,
        "Product added to cart.",
        action: allowUndo
            ? SnackBarAction(
                label: 'Undo',
                onPressed: () async {
                  await deleteProductfromServerCart(
                    product: product,
                    context: context,
                  );
                })
            : null,
      );
    } catch (e) {
      ShowSnackBar.showSnackBar(context, "Unable to add the product to cart.");
    }
  }
}
