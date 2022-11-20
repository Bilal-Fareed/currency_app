import 'package:currency_app/models/country_model.dart';
import 'package:currency_app/presentation/widgets/add_currency_button.dart';
import 'package:currency_app/provider/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Convert'),
        ),
      ),
      body: Consumer<CountryProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            itemCount: provider.addedCourrencyList.length + 1,
            itemBuilder: (context, index) {
              if (index == provider.addedCourrencyList.length) {
                return const AddCurrencyButton();
              }
              return Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.red,
                  ),
                ),
                key: ValueKey<CountryDataModel>(provider.addedCourrencyList[index]),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.endToStart) {
                    provider.removeFromList(provider.addedCourrencyList[index]);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      leading: Text(
                        '${provider.addedCourrencyList[index].imageUrl}',
                        style: const TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      title: Text(
                        provider.addedCourrencyList[index].currencyCode.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                           Text('1 USD = 1.34 AED'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
