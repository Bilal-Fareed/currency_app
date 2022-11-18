import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../provider/country_provider.dart';

// ignore: camel_case_types
class Countries_List extends StatefulWidget {
  const Countries_List({super.key});

  @override
  State<Countries_List> createState() => _Countries_ListState();
}

// ignore: camel_case_types
class _Countries_ListState extends State<Countries_List> {
  @override
  Widget build(BuildContext context) {
    var countries = context.watch<CountryProvider>().countries;
    var addedCourrencyList = context.watch<CountryProvider>().addedCourrencyList;

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Icon(CupertinoIcons.back)
          ),
        title: const Center(child: Text('Select Currency')),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Done'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final currentSelectedCountry = countries[index];

                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.black,
                      // child: Image(
                      //   image: NetworkImage(currentCountry.imageUrl.toString()),
                      //   fit: BoxFit.fill
                      // ),
                    ),
                    title: Text(
                      currentSelectedCountry.countryName.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        addedCourrencyList.contains(currentSelectedCountry)
                            ? CupertinoIcons.clear
                            : CupertinoIcons.add,
                        size: 20,
                      ),
                      onPressed: () => {
                        if (!addedCourrencyList.contains(currentSelectedCountry))
                          {
                            context.read<CountryProvider>().addToList(currentSelectedCountry)
                          }
                        else
                          {
                            context.read<CountryProvider>().removeFromList(currentSelectedCountry)
                          }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
