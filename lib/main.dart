import 'package:flip_cart_demo/features/auth/account_method_screen/bloc/account_method_bloc.dart';
import 'package:flip_cart_demo/features/auth/phone_number_screen/bloc/phone_number_bloc.dart';
import 'package:flip_cart_demo/features/auth/welcome_screen/bloc/welcome_bloc.dart';
import 'package:flip_cart_demo/features/auth/welcome_screen/pages/welcome_pages.dart';
import 'package:flip_cart_demo/features/categories/presentation/bloc/category_bloc.dart';
import 'package:flip_cart_demo/features/dashboard/presentation/bloc/product_bloc.dart';
// import 'package:flip_cart_demo/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flip_cart_demo/core/databases/cache/cache_helper.dart';
import 'package:flip_cart_demo/core/di/init_dependencies.dart';
import 'package:flip_cart_demo/features/user/presentation/cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  await initDependencies(); // ✅ registers everything globally

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()..eitherFailureOrUser(1)),
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => sl<CategoryBloc>()),
        BlocProvider(create: (_) => WelcomeBloc()),
        BlocProvider(create: (_) => AccountMethodBloc()),
        BlocProvider(
          create: (_) => PhoneNumberBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          canvasColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        // home: Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: DashboardPage(),
        // ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // child: DashboardPage(),
              child: WelcomePage(),
            ),
          ),
        ),
      ),
    );
  }
}
