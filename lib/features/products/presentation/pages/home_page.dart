import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../auth/presentation/cubit/home_session_cubit.dart';
import '../bloc/products_bloc.dart';
import '../widgets/home/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProductsBloc>()..add(const ProductsStarted()),
        ),
        BlocProvider(
          create: (_) =>
              getIt<HomeSessionCubit>()
                ..restoreUserName(fallbackUserName: username),
        ),
      ],
      child: const HomeView(),
    );
  }
}
