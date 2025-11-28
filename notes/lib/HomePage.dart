import 'dart:io';
import 'dart:typed_data' show Uint8List;
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
          if (!snapshot.hasData) return const Center();

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
              final String? imageUrl = data['imageUrl'];   // FIXED KEY

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),

                leading: imageUrl != null
    ? ClipRRect(
        borderRadius: BorderRadius.circular(8), 
        child: Image.network(
          imageUrl,
          width: 100,    
          height: 100,
          fit: BoxFit.contain,  
        ),
      )
    : Container(
        width: 100,
        height: 100,
        color: Colors.grey[300],
        child: const Icon(Icons.image, size: 40),
      ),


                  title: Text(
                    data['name'] ?? '',
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(
                    "Quantity: ${data['quantity'] ?? 0}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () =>
                            service.toggleFavorite(item.id, isFav),
                      ),

                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => openEditDialog(context, item),
                      ),

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

  // DELETE CONFIRMATION
  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this item?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
            onPressed: () {
              service.deleteItem(id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // ADD ITEM POPUP
  void openAddDialog(BuildContext context) {
    nameCtrl.clear();
    qtyCtrl.clear();
    
    File? selectedImageFile;
    Uint8List? selectedImageBytes;
    String? imageUrl;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateSB) {
          return AlertDialog(
            title: const Text("Add New Item"),
            content: SingleChildScrollView(
              child: Column(
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

                  const SizedBox(height: 12),

                if (selectedImageFile != null)
  ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.file(
      selectedImageFile!,
      width: 120,
      height: 120,
      fit: BoxFit.cover,
    ),
  )
else if (selectedImageBytes != null)
  ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.memory(
      selectedImageBytes!,
      width: 120,
      height: 120,
      fit: BoxFit.cover,
    ),
  ),


                  const SizedBox(height: 8),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload),
                    label: const Text("Upload Image"),
                    onPressed: () async {
                      final picked = await service.pickImageForAndImage();

if (picked != null) {
  setStateSB(() {
    selectedImageFile = picked.file;     // mobile
    selectedImageBytes = picked.bytes;   // web
    imageUrl = picked.url;               // Cloudinary URL
  });
}

                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text("Add"),
                onPressed: () async {
                  final name = nameCtrl.text.trim();
                  final qty = int.tryParse(qtyCtrl.text) ?? 0;

                  await service.addItemWithImage(
                    name,
                    qty,
                    imageUrl, // FIXED
                  );

                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // EDIT POPUP
  void openEditDialog(BuildContext context, DocumentSnapshot item) {
    nameCtrl.text = item['name'];
    qtyCtrl.text = item['quantity'].toString();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Item Name"),
            ),
            TextField(
              controller: qtyCtrl,
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Update"),
            onPressed: () {
              final name = nameCtrl.text.trim();
              final qty = int.tryParse(qtyCtrl.text) ?? 0;

              service.updateItem(item.id, name, qty);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
