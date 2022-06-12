// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'productmanagement_bloc.dart';

abstract class ProductmanagementEvent extends Equatable {
  const ProductmanagementEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends ProductmanagementEvent {
  final ProductModel product;
  final BuildContext context;
  const AddProduct({
    required this.product,
    required this.context,
  });
}

class EditProduct extends ProductmanagementEvent {
  final ProductModel product;
  final BuildContext context;

  const EditProduct({
    required this.product,
    required this.context,
  });
}

class DeleteProduct extends ProductmanagementEvent {
  final ProductModel product;
  final BuildContext context;

  const DeleteProduct({
    required this.product,
    required this.context,
  });
}
