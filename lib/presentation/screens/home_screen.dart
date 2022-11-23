import 'package:currency_app/models/currency.dart';
import 'package:currency_app/presentation/screens/currency_convertor_screen.dart';
import 'package:currency_app/presentation/widgets/add_currency_button.dart';
import 'package:currency_app/provider/currency_provider.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text('Convert'),
          ),
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
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        itemCount: provider.addedCurrencyList.length + 1,
                        itemBuilder: (context, index) {
                          if (index == provider.addedCurrencyList.length) {
                            return const AddCurrencyButton();
                          } else {
                            return Dismissible(
                              direction: provider.addedCurrencyList.length <= 2 ? DismissDirection.none : DismissDirection.endToStart,
                              background: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.red,
                                ),
                              ),
                              key: ValueKey<Currency>(provider.addedCurrencyList[index]),
                              onDismissed: (DismissDirection direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  await provider.removeFromList(provider.addedCurrencyList[index]);
                                }
                              },
                              child: GestureDetector(
                                onLongPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CurrencyConvertorScreen(),
                                    ),
                                  );
                                },
                                onTap: () async {
                                  if (!(provider.baseCurrency == provider.addedCurrencyList[index])) {
                                    await provider.changeBaseCurrency(provider.addedCurrencyList[index]);
                                   
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                      border: !provider.isBaseCurrency(provider.addedCurrencyList[index])
                                          ? Border.all(
                                              color: Colors.grey,
                                            )
                                          : Border.all(
                                              color: const Color.fromARGB(255, 18, 97, 162),
                                              width: 3.0,
                                            ),
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                                      leading: Text(
                                        '${provider.addedCurrencyList[index].countryEmoji}',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      title: Text(
                                        provider.addedCurrencyList[index].currencyCode.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          !provider.isBaseCurrency(provider.addedCurrencyList[index])
                                              ? Text(
                                                  '${provider.enteredAmount} ${provider.baseCurrency?.currencyCode} = ${provider.getSingleRate(provider.addedCurrencyList[index])} ${provider.addedCurrencyList[index].currencyCode}',
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      );
          },
        ),
      ),
    );
  }
}
