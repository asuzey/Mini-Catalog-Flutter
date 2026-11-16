import 'dart:developer';

import 'package:material_ui/material_ui.dart';

import '../components/product_card.dart';
import '../models/products_model.dart';
import '../services/api_service.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

// ana sayfa urun listesi
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // sayfa degiskenleri
  final ApiService apiService = ApiService();
  List<Data> allProducts = [];
  bool isLoading = false;
  String errorMessage = '';
  String searchText = '';
  // sepetteki urunlerin id leri set oldugu icin tekrar etmez
  Set<int> cartIds = {};

  @override
  // build dan once urunleri cekiyoruz
  void initState() {
    super.initState();
    loadProducts();
  }

  // try catch finally ile urunleri yukluyoruz
  Future<void> loadProducts() async {
    try {
      setState(() => isLoading = true);
      final productModel = await apiService.fetchProducts();
      setState(() => allProducts = productModel.data ?? []);
      log('urunler getirildi');
    } catch (e) {
      setState(() => errorMessage = 'Failed to load products');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // arama icin filtreleme
    final products = allProducts
        .where(
          (p) =>
              (p.name ?? '').toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discover',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () {
                      // sepet sayfasina gecis
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(
                            allProducts: allProducts,
                            cartIds: cartIds,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Text(
                'Find your perfect device.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              TextField(
                // her harfte liste guncellenir
                onChanged: (value) => setState(() => searchText = value),
                decoration: InputDecoration(
                  hintText: 'Search products',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  ApiService.bannerUrl,
                  height: 80,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              // grid icin expanded sart yoksa hata verir
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : GridView.builder(
                        // her satirda 2 urun
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final findProduct = products[index];
                          return GestureDetector(
                            onTap: () {
                              // detay sayfasina named route ile gecis
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: ProductDetailArgs(
                                  findProduct: findProduct,
                                  cartIds: cartIds,
                                ),
                              );
                            },
                            child: ProductCard(findProduct: findProduct),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
