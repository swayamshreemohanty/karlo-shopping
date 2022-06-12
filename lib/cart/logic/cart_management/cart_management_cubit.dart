// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cart/model/cart_item_model.dart';
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

    Future<void> deleteProductfromServerCart({
      required ProductModel product,
      required BuildContext context,
    }) async {
      try {
        emit(AddToCartLoading());
        await _cartRepository.deleteProductsFromServerCart(
            productModel: product);

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
        //Cart item assign to 1 because to break the cartItem !=0 condition and
        //show the loading spinner on Bottom screen nav bar Shopping bag.
        cartItem = 1;
        emit(AddToCartLoading());
        await _cartRepository.addProductToServerCart(productModel: product);
        await fetchProductsofServerCart(context: context);
        ShowSnackBar.showSnackBar(context, "Product added to cart.");
      } catch (e) {
        ShowSnackBar.showSnackBar(
            context, "Unable to add the product to cart.");
      }
    }
  }
}
