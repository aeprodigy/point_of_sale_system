import 'package:flutter/material.dart';
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:point_on_sale_system/providers/product_provider.dart';
import 'package:point_on_sale_system/views/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //providers registration
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=> ProductProvider()..loadProducts()),
        ChangeNotifierProvider(create: (_)=> CartProvider()),

      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
