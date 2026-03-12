import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../models/product/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Base.c500),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.category,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Base.c600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.star, size: 18),
                const SizedBox(width: 4),
                Text(
                  product.rating.rate.toString(),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(width: 8),
                Text(
                  '(${product.rating.count})',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Base.c600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}