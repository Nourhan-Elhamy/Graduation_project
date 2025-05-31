import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/user/presentation/tabs/orders/data/repo/orders_repo.dart';
import 'features/splash/presentation/views/splash_screen.dart';
import 'features/user/presentation/tabs/cart/data/repos/cart_repo.dart';
import 'features/user/presentation/tabs/cart/presentation/controller/cart_cubit.dart';
import 'features/user/presentation/tabs/orders/presentation/controller/orders_cubit.dart';
import 'features/user/presentation/tabs/wish_tab/data/controller/wishlist_cubit.dart';
import 'features/user/presentation/tabs/wish_tab/data/repo/wishlist_repo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() {
  runApp(
    ScreenUtilInit(
        designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CartCubit(CartRepo()),
            ),
            BlocProvider(
              create: (context) => WishlistCubit(WishlistRepository()),
            ),
            BlocProvider(
              create: (context) => OrderCubit(OrderRepo()),
            ),
            BlocProvider(
              create: (context) => CartCubit(CartRepo())..getCart(),
            ),
          ],
          child: const MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: AppColors.lightTheme,
      ),
    );
  }
}
