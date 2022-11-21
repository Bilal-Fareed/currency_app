import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/currency_provider.dart';

// ignore: camel_case_types
class CurrencyList extends StatefulWidget {
  const CurrencyList({super.key});

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

// ignore: camel_case_types
class _CurrencyListState extends State<CurrencyList> {
  final _snackBar = const SnackBar(
    content: Text('You must have a minimum of two countries'),
  );

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
      body: Consumer<CurrencyProvider>(
        builder: (context, provider, _) {
          return provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : provider.hasError
                  ? Center(
                      child: Text(provider.errorMessage),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemCount: provider.currencies.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                hoverColor: Colors.grey[300],
                                splashColor: Colors.blue,
                                onTap: () => {
                                  if (!provider.contains(countryToCheck: provider.currencies[index]))
                                    {
                                      provider.addToList(provider.currencies[index]),
                                    }
                                  else
                                    {
                                      if (provider.addedCurrencyList.length <= 2)
                                        {
                                          ScaffoldMessenger.of(context).showSnackBar(_snackBar),
                                        }
                                      else
                                        {
                                          provider.removeFromList(provider.currencies[index]),
                                        }
                                    },
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Text(
                                      '${provider.currencies[index].countryEmoji}',
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    '${provider.currencies[index].currencyCode.toString()} - ${provider.currencies[index].currencyName.toString()}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  trailing: provider.contains(countryToCheck: provider.currencies[index])
                                      ? const Icon(
                                          Icons.done,
                                          color: Color.fromARGB(255, 12, 64, 108),
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