part of 'cart_management_cubit.dart';

abstract class CartManagementState extends Equatable {
  const CartManagementState();

  @override
  List<Object> get props => [];
}

class AddToCartInitial extends CartManagementState {}

class AddToCartLoading extends CartManagementState {}

class CartUpdated extends CartManagementState {
  final List<CartProductModel> cartProducts;
  final String cartTotalPrice;
  const CartUpdated({
    required this.cartProducts,
    required this.cartTotalPrice,
  });
  @override
  List<Object> get props => [cartProducts];
}
