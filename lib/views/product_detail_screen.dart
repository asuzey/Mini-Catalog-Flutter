import 'package:material_ui/material_ui.dart';

import '../models/products_model.dart';

// route arguments icin tasiyici sinif
class ProductDetailArgs {
  final Data findProduct;
  final Set<int> cartIds;

  ProductDetailArgs({required this.findProduct, required this.cartIds});
}

// urun detay sayfasi
class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/detail';

  final Data findProduct;
  final Set<int> cartIds;

  const ProductDetailScreen({
    super.key,
    required this.findProduct,
    required this.cartIds,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // urun sepette mi
  bool get isInCart => widget.cartIds.contains(widget.findProduct.id);

  // sepete ekle ve snackbar goster
  void addToCart() {
    if (widget.findProduct.id == null) return;
    setState(() {
      widget.cartIds.add(widget.findProduct.id!);
    });

    // alttan cikan bildirim
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${widget.findProduct.name} added to cart'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.findProduct;
    final specs = product.specs ?? {};

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // tasma olmasin diye kaydirma
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.image ?? '',
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 350,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? '',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.tagline ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.description ?? '',
                            // iki yana yasli
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          if (specs.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            const Text(
                              'Specifications',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // specs leri kutu kutu gosteriyoruz
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: specs.entries
                                  .map((e) => buildSpecBox(e.key, '${e.value}'))
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildBottomBar(product),
          ],
        ),
      ),
    );
  }

  Widget buildSpecBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildBottomBar(Data product) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Row(
        children: [
          Text(
            product.price ?? '',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              // sepetteyse buton pasif
              onPressed: isInCart ? null : addToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                disabledBackgroundColor: Colors.grey.shade400,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isInCart ? 'In Cart' : 'Add to Cart',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
