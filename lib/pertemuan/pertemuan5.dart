import 'package:flutter/material.dart';

// Model data
class Product {
  final String name;
  final double price;
  final String imageUrl;
  final int rating;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });
}

// Cart Item model
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class ListviewPage extends StatefulWidget {
  @override
  _ListviewPageState createState() => _ListviewPageState();
}

class _ListviewPageState extends State<ListviewPage> {
  final List<Product> products = [
    Product(
      name: 'Smartphone XYZ',
      price: 3500000,
      imageUrl:
          'https://images.unsplash.com/photo-1598327106026-d9521da673d1?q=80&w=327&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      rating: 4,
    ),
    Product(
      name: 'Laptop ABC',
      price: 8500000,
      imageUrl:
          'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      rating: 5,
    ),
    Product(
      name: 'Headphone Pro',
      price: 500000,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      rating: 3,
    ),
    Product(
      name: 'Smartwatch GT',
      price: 1200000,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=389&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      rating: 4,
    ),
  ];

  List<CartItem> cart = [];

  void addToCart(Product product) {
    setState(() {
      // Check if product already in cart
      int existingIndex = cart.indexWhere(
        (item) => item.product.name == product.name,
      );

      if (existingIndex != -1) {
        // Increase quantity if already in cart
        cart[existingIndex].quantity++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${product.name} quantity increased to ${cart[existingIndex].quantity}',
            ),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        // Add new item to cart
        cart.add(CartItem(product: product));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.name} added to cart'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  void removeFromCart(int index) {
    setState(() {
      CartItem removedItem = cart.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${removedItem.product.name} removed from cart'),
          duration: Duration(seconds: 1),
        ),
      );
    });
  }

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        cart[index].quantity = newQuantity;
      }
    });
  }

  double getTotalPrice() {
    return cart.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  void showCart() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Your cart is empty')));
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Shopping Cart',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        CartItem item = cart[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.product.imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 30,
                                      ),
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          color: Colors.grey[200],
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value:
                                                  loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                  : null,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        );
                                      },
                                ),
                              ),
                            ),
                            title: Text(item.product.name),
                            subtitle: Text(
                              'Rp ${item.product.price.toStringAsFixed(0)}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, size: 20),
                                  onPressed: () {
                                    if (item.quantity > 1) {
                                      updateQuantity(index, item.quantity - 1);
                                      setStateModal(() {});
                                    } else {
                                      removeFromCart(index);
                                      setStateModal(() {});
                                    }
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, size: 20),
                                  onPressed: () {
                                    updateQuantity(index, item.quantity + 1);
                                    setStateModal(() {});
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    removeFromCart(index);
                                    setStateModal(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp ${getTotalPrice().toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Checkout'),
                                content: Text(
                                  'Total payment: Rp ${getTotalPrice().toStringAsFixed(0)}\n\nThank you for shopping!',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Close'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        cart.clear();
                                      });
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Payment successful! Thank you for shopping',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text('Pay Now'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            'Checkout',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: showCart),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${cart.length}',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.image_not_supported, size: 40),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rp ${product.price.toStringAsFixed(0)}'),
                  Row(
                    children: List.generate(5, (starIndex) {
                      return Icon(
                        starIndex < product.rating
                            ? Icons.star
                            : Icons.star_border,
                        size: 16,
                        color: Colors.amber,
                      );
                    }),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  addToCart(product);
                },
                child: const Text('Beli'),
              ),
            ),
          );
        },
      ),
    );
  }
}
