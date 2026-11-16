import 'package:material_ui/material_ui.dart';

// sepetteki urun satiri
class MiniCardTile extends StatelessWidget {
  final String name;
  final String tagline;
  final String price;
  final String imageUrl;
  // silme fonksiyonu disaridan geliyor
  final VoidCallback onRemove;

  const MiniCardTile({
    super.key,
    required this.name,
    required this.tagline,
    required this.price,
    required this.imageUrl,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 56,
                height: 56,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported_outlined),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // yazilar ortadaki alani kaplasin
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  tagline,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(price, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            tooltip: 'Remove',
            icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
