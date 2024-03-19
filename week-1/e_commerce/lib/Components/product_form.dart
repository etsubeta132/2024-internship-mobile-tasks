import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'package:e_commerce/Screens/product_list.dart';


class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  File? _image;
  final _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _catagoryController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.blue,
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_image != null) ...[
              Image.file(_image!),
              const SizedBox(height: 16),
            ],
            Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 227, 224, 224),
                ),
                height: 150,
                width: 200,
                child: TextButton(
                  style: TextButton.styleFrom(
                    iconColor: Colors.black,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: _pickImage,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image),
                      SizedBox(
                        width: 24,
                      ),
                      Text('Upload image')
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('name: '),
                const SizedBox(width: 16),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 227, 224, 224),
                    border: InputBorder.none
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Catagory: '),
                const SizedBox(width: 16),
                TextField(
                  controller: _catagoryController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 227, 224, 224),
                    border: InputBorder.none
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Price: '),
                const SizedBox(width: 16),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 227, 224, 224),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.attach_money)),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Description: '),
                const SizedBox(width: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 227, 224, 224),
                    border: InputBorder.none
                  ),
                  maxLines: 3,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                onPressed: () {
                  setState(() {
                    final String title = _titleController.text;
                    final String catagory = _catagoryController.text;
                    final String description = _descriptionController.text;
                    final double price =
                        double.tryParse(_priceController.text) ?? 0;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductList()));
                },
                child: const Text('ADD')),
            const SizedBox(height: 16),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.red))),
                onPressed: () {
                  setState(() {
                    final String title = _titleController.text;
                    final String category = _catagoryController.text;
                    final String description = _descriptionController.text;
                    final double price =
                        double.tryParse(_priceController.text) ?? 0;
                  });
                },
                child: const Text('DELETE')),
          ],
        ),
      ),
    );
  }
}
