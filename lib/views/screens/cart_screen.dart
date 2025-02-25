import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:point_on_sale_system/views/pages/home_page.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItem = cartProvider.cartItems;
    return Scaffold(
      body: cartItem.isEmpty
          ? Center(child: Text('Cart Is Empty'))
          : Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.angleLeft),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Checkout',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cartProvider
                                .removeFromCart(cartProvider.cartItems.last);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.trashCan,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItem.length,
                    itemBuilder: (context, index) {
                      final items = cartItem[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                          leading: Image.asset(items.image),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                items.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.subtract,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '0',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          trailing: Column(
                            children: [
                              Text("\$${items.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey[500]!, // Border color
                                    width: 3.0, // Border thickness
                                  ),
                                ),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.close,
                                    color: Colors.grey[500],
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
