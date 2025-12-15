import 'package:flutter/material.dart';
import 'home_page.dart';

class CartItem {
  final Phone phone;
  int quantity;

  CartItem({required this.phone, this.quantity = 1});
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Mock cart items - in a real app, this would come from a state management solution
  final List<CartItem> cartItems = [
    CartItem(
      phone: Phone(
        id: '1',
        name: 'iPhone 15 Pro',
        brand: 'Apple',
        price: 999.0,
        imageUrl: 'https://via.placeholder.com/150',
        description: 'The most advanced iPhone yet',
        specs: ['A17 Pro chip', '48MP camera'],
      ),
      quantity: 1,
    ),
    CartItem(
      phone: Phone(
        id: '2',
        name: 'Samsung Galaxy S24',
        brand: 'Samsung',
        price: 799.0,
        imageUrl: 'https://via.placeholder.com/150',
        description: 'AI-powered smartphone',
        specs: ['Snapdragon 8 Gen 3', '50MP camera'],
      ),
      quantity: 2,
    ),
  ];

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.phone.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : _buildCartWithItems(),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Add some phones to get started!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartWithItems() {
    return Column(
      children: [
        // Cart items list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return _buildCartItemCard(cartItem, index);
            },
          ),
        ),

        // Total and checkout section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Total price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Checkout button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showCheckoutDialog(context);
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
                    'Proceed to Checkout',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartItemCard(CartItem cartItem, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Phone image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.phone_android,
                size: 40,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 16),

            // Phone details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.phone.brand,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cartItem.phone.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${cartItem.phone.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Quantity controls
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (cartItem.quantity > 1) {
                            cartItem.quantity--;
                          }
                        });
                      },
                      iconSize: 20,
                    ),
                    Text(
                      '${cartItem.quantity}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          cartItem.quantity++;
                        });
                      },
                      iconSize: 20,
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      cartItems.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${cartItem.phone.name} removed from cart'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total items: ${cartItems.length}'),
              Text('Total amount: \$${totalPrice.toStringAsFixed(0)}'),
              const SizedBox(height: 16),
              const Text(
                'This is a demo app. In a real application, you would be redirected to a payment gateway.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order placed successfully!'),
                    duration: Duration(seconds: 3),
                  ),
                );
                // Clear cart
                setState(() {
                  cartItems.clear();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm Order'),
            ),
          ],
        );
      },
    );
  }
}

