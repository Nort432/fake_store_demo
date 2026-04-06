import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/products_bloc.dart';
import '../widgets/home/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductsBloc>()..add(const ProductsStarted()),
      child: const HomeView(),
    );
  }
}
