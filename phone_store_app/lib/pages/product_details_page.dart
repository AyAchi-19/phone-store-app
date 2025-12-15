import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cart_page.dart';

class ProductDetailsPage extends StatelessWidget {
  final Phone phone;

  const ProductDetailsPage({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(phone.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phone image section
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: const Icon(
                Icons.phone_android,
                size: 150,
                color: Colors.grey,
              ),
            ),

            // Phone details section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand and name
                  Text(
                    phone.brand,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    phone.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price
                  Text(
                    '\$${phone.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    phone.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Specifications
                  const Text(
                    'Key Specifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...phone.specs.map((spec) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          spec,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 32),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Add to cart functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${phone.name} added to cart!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // TODO: Buy now functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Buy now feature coming soon!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

