// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cart/helper/cart_amount_calculator.dart';
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
    emit(AddToCartLoading());
    try {
      _cartData = await _cartRepository.fetchCartProductsFromServerCart();
      cartItem = _cartData.length;
      emit(
        CartUpdated(
            cartProducts: _cartData,
            cartTotalPrice: calculateTotalAmountofCart(_cartData)),
      );
    } catch (e) {
      emit(
        CartUpdated(
            cartProducts: _cartData,
            cartTotalPrice: calculateTotalAmountofCart(_cartData)),
      );
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
      emit(CartUpdated(
        cartProducts: _cartData,
        cartTotalPrice: calculateTotalAmountofCart(_cartData),
      ));
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
      final isProductAlreadyinCart = await _cartRepository
          .isProductAlreadyInCart(productId: product.productId!);
      if (isProductAlreadyinCart) {
        ShowSnackBar.showSnackBar(
          context,
          "${product.productName} is already in the cart.",
        );
      } else {
        await _cartRepository.addProductToServerCart(product: product);
        await fetchProductsofServerCart(context: context); //Refresh the cart

        ShowSnackBar.showSnackBar(
          context,
          "${product.productName} added to cart.",
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () async {
                await deleteProductfromServerCart(
                  product: product,
                  context: context,
                );
              }),
        );
      }
      return;
    } catch (e) {
      ShowSnackBar.showSnackBar(context, "Unable to add the product to cart.");
    }
  }
}
