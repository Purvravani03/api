import 'dart:convert';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  String str = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("canrancy_data"),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: t1,
                readOnly: true,
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                      print('Select currency: ${currency.code}');
                      t1.text = currency.code;
                      setState(() {});
                    },
                  );
                },
                decoration: InputDecoration(
                    hintText: "Enter carancy title",
                    border: OutlineInputBorder()),
              )),
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: t2,
                readOnly: true,
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                      print('Select currency: ${currency.code}');
                      t2.text = currency.code;
                      setState(() {});
                    },
                  );
                },
                decoration: InputDecoration(
                    hintText: "Enter to title", border: OutlineInputBorder()),
              )),
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: t3,
                decoration: InputDecoration(
                    hintText: "Enter amount title",
                    border: OutlineInputBorder()),
              )),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                String from, to, amo;
                from = t1.text;
                to = t2.text;
                amo = t3.text;
                var url =
                    Uri.parse('https://purv1.000webhostapp.com/conrancy.php');
                var response = await http.post(url,
                    body: {'from': '$from', 'to': '$to', 'amo': '$amo'});
                print('Response status: ${response.statusCode}');
                print(response.body);
                Map m = jsonDecode(response.body);
                str = m['result'].toString();
                setState(() {});
              },
              child: Text("submit")),
          Container(
            color: Colors.transparent,
            child: Text(
              str,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),

        ],
      ),
    );
  }
}
