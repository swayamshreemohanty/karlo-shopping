// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cart/logic/cart_management/cart_management_cubit.dart';
import 'package:shopping_app/cart/model/cart_product_model.dart';
import 'package:shopping_app/cart/repository/cart_repository.dart';
import 'package:shopping_app/cart/repository/checkout_repository.dart';
import 'package:shopping_app/utility/show_snak_bar.dart';
part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CartManagementCubit cartManagementCubit;
  CheckoutCubit({
    required this.cartManagementCubit,
  }) : super(CheckoutInitial());

  Future<void> checkOut(
    BuildContext context, {
    required List<CartProductModel> cartProducts,
    required String cartTotalPrice,
  }) async {
    emit(CheckoutLoading());
    try {
      await CheckOutRepository().addProductsFromCartToOrder(
        cartProducts: CartProductSummary(
          cartProductsList: cartProducts,
          orderCreatedAt: DateTime.now(),
          totalPrice: cartTotalPrice,
        ),
      );
      for (var cartproduct in cartProducts) {
        CartRepository()
            .deleteProductsFromServerCart(product: cartproduct.product);
      }
      emit(CheckoutCompleted());
      await cartManagementCubit.fetchProductsofServerCart(context: context);
      ShowSnackBar.showSnackBar(context, 'successful payment');
      //Close the Cart Screen
      Navigator.pop(context);
    } catch (e) {
      emit(CheckoutFailed());
      ShowSnackBar.showSnackBar(context, 'Unable to checkout');
    }
  }
}
