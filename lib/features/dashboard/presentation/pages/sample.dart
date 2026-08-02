import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DragExamplePage()));

class DragExamplePage extends StatefulWidget {
  const DragExamplePage({super.key});

  @override
  State<DragExamplePage> createState() => _DragExamplePageState();
}

class _DragExamplePageState extends State<DragExamplePage> {
  bool isDropped = false;
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🛍️ Draggable Product Example")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LongPressDraggable<String>(
              data: "Product 1",
              feedback: _buildProductCard(opacity: 0.8),
              childWhenDragging: _buildProductCard(opacity: 0.4),
              child: _buildProductCard(),
            ),
          ),
          const SizedBox(height: 80),
          DragTarget<String>(
            onAccept: (value) {
              setState(() {
                isDropped = true;
                cartCount++;
              });
            },
            builder: (context, candidateData, rejectedData) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: 200,
                height: 120,
                decoration: BoxDecoration(
                  color: isDropped ? Colors.green[300] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDropped ? Colors.green : Colors.black38,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    isDropped
                        ? "✅ Added! ($cartCount)"
                        : "🛒 Drop Product Here",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              // color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 40, color: Colors.blueAccent),
            SizedBox(height: 8),
            Text(
              "Product 1",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text("₹499", style: TextStyle(fontSize: 16, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
