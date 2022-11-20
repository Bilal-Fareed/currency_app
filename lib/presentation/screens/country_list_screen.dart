import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/country_provider.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.clear,
              size: 20.0,
            ),
          ),
        ),
        title: const Center(
          child: Text('Select Currency'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
          ),
        ],
      ),
      body: Consumer<CountryProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: provider.countries.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      hoverColor: Colors.grey[300],
                      splashColor: Colors.blue,
                      onTap: () => {
                        if (!provider.addedCourrencyList.contains(provider.countries[index]))
                          {
                            provider.addToList(provider.countries[index]),
                          }
                        else
                          {
                            provider.removeFromList(provider.countries[index]),
                          },
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Text(
                            '${provider.countries[index].imageUrl}',
                            style: const TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        title: Text(
                          '${provider.countries[index].currencyCode.toString()} - ${provider.countries[index].countryName.toString()}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        trailing: provider.addedCourrencyList.contains(provider.countries[index])
                            ? const Icon(
                                Icons.done,
                                color: Color.fromARGB(255, 27, 102, 163),
                              )
                            : const SizedBox(),
                      ),
                    );
                  },
                  separatorBuilder: ((context, index) {
                    return const Divider(
                      thickness: 1.5,
                      height: 15.0,
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
