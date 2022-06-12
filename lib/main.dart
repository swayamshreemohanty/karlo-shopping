import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/authentication/logic/authentication/google_authentication_bloc.dart';
import 'package:shopping_app/authentication/logic/login/google_login_bloc.dart';
import 'package:shopping_app/authentication/repository/google_auth_repository.dart';
import 'package:shopping_app/authentication/screen/sign_in_screen.dart';
import 'package:shopping_app/cart/logic/cart_management/cart_management_cubit.dart';
import 'package:shopping_app/config/routes/application_page_routes.dart';
import 'package:shopping_app/firebase_options.dart';
import 'package:shopping_app/home/repository/user_role.dart';
import 'package:shopping_app/home/screens/home_screen.dart';
import 'package:shopping_app/product_management/logic/product_management/productmanagement_bloc.dart';
import 'package:shopping_app/utility/loading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authenticationBloc = GoogleAuthenticationBloc(
    googleAuthenticationRepository: GoogleAuthenticationRepository(),
  );

  @override
  void initState() {
    _authenticationBloc.add(AppStarted());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRoleRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _authenticationBloc),
          BlocProvider<GoogleLoginBloc>(
            create: (context) => GoogleLoginBloc(
              googleAuthenticationBloc:
                  BlocProvider.of<GoogleAuthenticationBloc>(context),
              googleAuthenticationRepository: GoogleAuthenticationRepository(),
            ),
          ),
          BlocProvider<ProductmanagementBloc>(
            create: (context) => ProductmanagementBloc(),
          ),
          BlocProvider<CartManagementCubit>(
            create: (context) => CartManagementCubit(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: Size(
            WidgetsBinding.instance.window.physicalSize.width /
                WidgetsBinding.instance.window.devicePixelRatio,
            WidgetsBinding.instance.window.physicalSize.height /
                WidgetsBinding.instance.window.devicePixelRatio,
          ),
          builder: (_, child) => MaterialApp(
            title: 'Karlo Shopping',
            theme: ThemeData(
              primarySwatch: Colors.amber,
            ),
            home: BlocBuilder<GoogleAuthenticationBloc,
                GoogleAuthenticationState>(
              builder: (buildContext, state) {
                if (state is AuthenticationUninitialized) {
                  return const LoadingScreen();
                } else if (state is AuthenticationAuthenticated) {
                  return const HomeScreen();
                } else if (state is AuthenticationUnauthenticated) {
                  return const SignInScreen();
                } else {
                  return const LoadingScreen();
                }
              },
            ),
            onGenerateRoute: ScreenRouter().onGeneratedRouter,
          ),
        ),
      ),
    );
  }
}
