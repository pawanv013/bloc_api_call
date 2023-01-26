import 'package:bloc_api_call/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Bloc Api Callings',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProductScreen(),
      ),
    );
  }
}
