import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/crud_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CrudService service = CrudService();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController qtyCtrl = TextEditingController();


  bool showFavorites = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Firebase Cuesta'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(showFavorites ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() {
                showFavorites = !showFavorites;
              });
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => openAddDialog(context),
      ),

      body: StreamBuilder<QuerySnapshot>(
  stream: showFavorites ? service.getFavorites() : service.getItems(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return const Center();
    }

    final docs = snapshot.data!.docs;

    if (docs.isEmpty) {
      return const Center(
        child: Text('No items found.', style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final item = docs[index];
        final data = item.data() as Map<String, dynamic>;
        final bool isFav = data['favorite'] ?? false;

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

            // NAME
            title: Text(
              data['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // QUANTITY
            subtitle: Text(
              'Quantity: ${data['quantity']}',
              style: const TextStyle(fontSize: 16),
            ),

            // ACTION BUTTONS
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // FAVORITE TOGGLE
                IconButton(
                  icon: Icon(
                    isFav ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    service.toggleFavorite(item.id, isFav);
                  },
                ),

                // EDIT BUTTON
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => openEditDialog(context, item),
                ),

                // DELETE BUTTON
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(context, item.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  },
),

    );
  }

  // ============================
  // DELETE CONFIRMATION
  // ============================
  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                service.deleteItem(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ============================
  // ADD ITEM POPUP
  // ============================
  void openAddDialog(BuildContext context) {
    nameCtrl.clear();
    qtyCtrl.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: qtyCtrl,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                final name = nameCtrl.text;
                final qty = int.tryParse(qtyCtrl.text) ?? 0;

                service.addItem(name, qty);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ============================
  // EDIT ITEM POPUP
  // ============================
  void openEditDialog(BuildContext context, DocumentSnapshot item) {
    nameCtrl.text = item['name'];
    qtyCtrl.text = item['quantity'].toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: qtyCtrl,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                final name = nameCtrl.text;
                final qty = int.tryParse(qtyCtrl.text) ?? 0;

                service.updateItem(item.id, name, qty);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
