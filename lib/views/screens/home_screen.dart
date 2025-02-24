import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/views/widgets/text_field_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> categories = [
    {'icon': FontAwesomeIcons.bowlFood, 'label': 'All'},
    {'icon': FontAwesomeIcons.burger, 'label': 'Burger'},
    {'icon': FontAwesomeIcons.breadSlice, 'label': 'Sandwiches'},
    {'icon': FontAwesomeIcons.wineGlass, 'label': 'Drinks'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          //Text Menu
          Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.angleLeft),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Menu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          // THE SEARCH FILTER
          const TextFieldInput(),
          const SizedBox(height: 20),
          // CATEGORIES FILTER (Now each inside an individual container with uniform width & height)
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category['label'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category['label'];
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 120,
                      //margin: const EdgeInsets.symmetric(horizontal: 1.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            blurRadius: 5,
                            spreadRadius: 3,
                            offset: const Offset(4, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            category['icon'],
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            category['label'],
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color:
                                  isSelected ? Colors.white : Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
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
