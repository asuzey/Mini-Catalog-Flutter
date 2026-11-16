import 'package:material_ui/material_ui.dart';

import '../components/mini_card_tile.dart';
import '../models/products_model.dart';

// sepet sayfasi
class CartScreen extends StatefulWidget {
  final List<Data> allProducts;
  final Set<int> cartIds;

  const CartScreen({
    super.key,
    required this.allProducts,
    required this.cartIds,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // sepetteki urunleri buluyoruz
    final cartProducts = widget.allProducts
        .where((element) => widget.cartIds.contains(element.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Cart')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                // sepet bossa mesaj doluysa liste
                child: cartProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Your cart is empty',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Add items to start shopping',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final item = cartProducts[index];
                          return MiniCardTile(
                            name: item.name ?? '',
                            tagline: item.tagline ?? '',
                            price: item.price ?? '',
                            imageUrl: item.image ?? '',
                            // sepetten silme
                            onRemove: () {
                              setState(() => widget.cartIds.remove(item.id));
                            },
                          );
                        },
                      ),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                // odeme yok sadece buton
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
