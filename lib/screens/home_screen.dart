import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/country_provider.dart';
import 'country_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var addCountryList = context.watch<CountryProvider>().addedCourrencyList;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Convert'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: addCountryList.length + 1,
          itemBuilder:(context, index){
            if (index == addCountryList.length){
                    return TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (context) => const Countries_List()
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlue,),
                      child: const Text('Add Currency', style: TextStyle(color: Colors.black)),
                    );
                  }
                  
            final currentSelectedCountry = addCountryList[index];
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue,width: 2), 
                        borderRadius: BorderRadius.circular(10)),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.black,

                        // child: Image(
                        //   image: NetworkImage('abc'),
                        //   fit: BoxFit.fill
                        // ),
                      ),
                      title: Text(
                        currentSelectedCountry.countryName.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          context.read<CountryProvider>().removeFromList(currentSelectedCountry);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,),
                        child: const Text('Remove', style: TextStyle(color: Colors.red)),
                      )
            ),
                  );
          }),
      ) 
    );
  }
}
