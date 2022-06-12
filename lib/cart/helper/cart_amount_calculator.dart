import 'package:shopping_app/cart/model/cart_product_model.dart';

String calculateTotalAmountofCart(List<CartProductModel> cartItems) {
  int totalAmount = 0;
  for (var element in cartItems) {
    totalAmount += int.parse(element.product.productPrice);
  }
  return totalAmount.toString();
}
