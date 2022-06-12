import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shopping_app/cart/logic/cart_management/cart_management_cubit.dart';
import 'package:shopping_app/cart/screen/cart_screen.dart';
import 'package:shopping_app/cart/widget/shopping_cart_badge.dart';
import 'package:shopping_app/home/repository/user_role.dart';
import 'package:shopping_app/home/widgets/app_bar_header.dart';
import 'package:shopping_app/home/widgets/app_drawer.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/product_management/logic/product_management/productmanagement_bloc.dart';
import 'package:shopping_app/product_management/widgets/product_showcase_tile.dart';
import 'package:shopping_app/utility/firebase_current_user_data.dart';
import 'package:shopping_app/utility/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<UserRoleRepository>().fetchuserRole();
    context
        .read<CartManagementCubit>()
        .fetchProductsofServerCart(context: context);
    super.initState();
  }

  final _shoppingBadge = Positioned(
    right: 5.w,
    top: 6.h,
    child: const Badge(),
  );
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const AppBarHeader(title: "Karlo Shopping"),
          centerTitle: true,
          elevation: 0,
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (() {
                Navigator.pushNamed(context, CartScreen.routeName);
              }),
              child: AbsorbPointer(
                child: Stack(children: [
                  IconButton(
                    iconSize: 30.sp,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                  BlocBuilder<CartManagementCubit, CartManagementState>(
                    builder: (context, state) {
                      if (state is CartUpdated) {
                        if (state.cartProducts.isEmpty) {
                          return const Text("");
                        } else {
                          return _shoppingBadge;
                        }
                      } else if (state is AddToCartLoading &&
                          BlocProvider.of<CartManagementCubit>(context)
                                  .cartItem !=
                              0) {
                        return _shoppingBadge;
                      } else {
                        return const Text("");
                      }
                    },
                  ),
                ]),
              ),
            )
          ],
        ),
        drawer: AppDrawer(
          userDetails: FirebaseCurrentUserData().userDetails!,
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
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: ScaleAnimation(
                      child: Card(
                        child: Stack(alignment: Alignment.center, children: [
                          ProductShowCaseTile(product: logs[index]!),
                          Positioned(
                            top: 0.h,
                            left: 0.w,
                            child: IconButton(
                                iconSize: 25.sp,
                                color: Colors.black,
                                onPressed: () {
                                  context
                                      .read<CartManagementCubit>()
                                      .addProducttoServerCart(
                                        product: logs[index]!,
                                        context: context,
                                      );
                                },
                                icon: const Icon(Icons.add_shopping_cart)),
                          )
                        ]),
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
