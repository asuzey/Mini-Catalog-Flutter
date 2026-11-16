import 'package:material_ui/material_ui.dart';

import 'views/home_screen.dart';
import 'views/product_detail_screen.dart';

// uygulama buradan basliyor
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Catalog',
      // debug yazisini kaldirdik
      debugShowCheckedModeBanner: false,

      // basit tema siyah beyaz
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        useMaterial3: true,
      ),

      // ilk acilan sayfa
      home: const HomeScreen(),

      // detay sayfasina arguments ile veri tasiyoruz
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final args = settings.arguments as ProductDetailArgs;
          return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              findProduct: args.findProduct,
              cartIds: args.cartIds,
            ),
          );
        }
        return null;
      },
    );
  }
}
