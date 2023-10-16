
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_app/models/product_model.dart';
import 'package:http_app/repo/repo.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key, required this.productData}) : super(key: key);

  final Products productData;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {}),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Center(
                child: Image.network(
                  widget.productData.image.toString(),
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productData.title.toString(),
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 10,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.productData.rating!.rate.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    widget.productData.category.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.productData.description.toString(),
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.currency_rupee,
                        size: 12,
                      ),
                      Text(
                        widget.productData.price.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      ApiRepo().updateProducts('Updated product name',
                          widget.productData.id.toString(), '500');
                          Get.snackbar('message', '''Product updated successfully
                          ${widget.productData.title}
                          ''');

                    },
                    child: const Text('Update')),
                TextButton(
                    onPressed: () {
                      setState(() { 
                        ApiRepo()
                            .deleteProduct(widget.productData.id.toString());
                            Get.snackbar('message', '''Product deleted successfully
                            ${widget.productData.id}''');
                      });
                    },
                    child: const Text('Delete')),
              ],
            )
          ],
        ),
      ),
    );
  }
}