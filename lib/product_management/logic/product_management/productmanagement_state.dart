part of 'productmanagement_bloc.dart';

abstract class ProductmanagementState extends Equatable {
  const ProductmanagementState();

  @override
  List<Object> get props => [];
}

class ProductmanagementInitial extends ProductmanagementState {}

class ProductActionLoading extends ProductmanagementState {}

class ProductActionCompleted extends ProductmanagementState {}

class ProductActionFailed extends ProductmanagementState {}
