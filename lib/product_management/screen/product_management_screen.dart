import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shopping_app/home/widgets/app_bar_header.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/product_management/logic/product_management/productmanagement_bloc.dart';
import 'package:shopping_app/product_management/widgets/product_management_dialog_widget.dart';
import 'package:shopping_app/product_management/widgets/product_showcase_tile.dart';
import 'package:shopping_app/utility/loading_indicator.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({Key? key}) : super(key: key);
  static const routeName = '/product_management';

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const AppBarHeader(title: "Products"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => const ProductManageDialog(),
          );
        },
      ),
      body: StreamBuilder<List<ProductModel?>>(
        stream: context.read<ProductmanagementBloc>().fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else {
            final logs = snapshot.data ?? [];
            if (logs.isEmpty) {
              return const Center(
                child: Text("No products found."),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: logs.length,
                itemBuilder: (_, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: ScaleAnimation(
                    child: Card(
                      child: Column(
                        children: [
                          ProductShowCaseTile(product: logs[index]!),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                tooltip: 'Edit Product',
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => ProductManageDialog(
                                      editableProduct: logs[index],
                                      editproduct: true,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                tooltip: 'Delete Product',
                                onPressed: () {
                                  context.read<ProductmanagementBloc>().add(
                                        DeleteProduct(
                                          product: logs[index]!,
                                          context: context,
                                        ),
                                      );
                                },
                                icon: const Icon(Icons.delete),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
