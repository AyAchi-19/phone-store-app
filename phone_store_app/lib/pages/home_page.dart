import 'package:flutter/material.dart';
import 'product_details_page.dart';
import 'cart_page.dart';

class Phone {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final String description;
  final List<String> specs;

  Phone({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.specs,
  });
}

class HomePage extends StatelessWidget {
  final List<Phone> phones = [
    Phone(
      id: '1',
      name: 'iPhone 15 Pro',
      brand: 'Apple',
      price: 999.0,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'The most advanced iPhone yet with titanium design',
      specs: ['A17 Pro chip', '48MP camera', 'Titanium build', 'Action Button'],
    ),
    Phone(
      id: '2',
      name: 'Samsung Galaxy S24',
      brand: 'Samsung',
      price: 799.0,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'AI-powered smartphone with incredible camera',
      specs: ['Snapdragon 8 Gen 3', '50MP camera', '120Hz display', 'AI features'],
    ),
    Phone(
      id: '3',
      name: 'Google Pixel 8',
      brand: 'Google',
      price: 699.0,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Pure Android experience with computational photography',
      specs: ['Google Tensor G3', '50MP camera', '7 years updates', 'Magic Eraser'],
    ),
    Phone(
      id: '4',
      name: 'OnePlus 12',
      brand: 'OnePlus',
      price: 899.0,
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Flagship performance with OxygenOS',
      specs: ['Snapdragon 8 Gen 3', '50MP camera', '100W charging', 'Haptic feedback'],
    ),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Store'),
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
      body: Column(
        children: [
          // Categories section
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryChip('All', true),
                _buildCategoryChip('Apple', false),
                _buildCategoryChip('Samsung', false),
                _buildCategoryChip('Google', false),
                _buildCategoryChip('OnePlus', false),
              ],
            ),
          ),

          // Featured banner
          Container(
            height: 120,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                '🎉 Special Offer!\nUp to 20% off on selected phones',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Products list
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: phones.length,
              itemBuilder: (context, index) {
                final phone = phones[index];
                return _buildPhoneCard(context, phone);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          // TODO: Implement category filtering
        },
        backgroundColor: Colors.grey.shade200,
        selectedColor: Colors.blue.shade200,
        checkmarkColor: Colors.blue,
      ),
    );
  }

  Widget _buildPhoneCard(BuildContext context, Phone phone) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(phone: phone),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phone image
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const Icon(
                Icons.phone_android,
                size: 60,
                color: Colors.grey,
              ),
            ),

            // Phone details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phone.brand,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phone.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${phone.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
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

