import 'package:flutter/material.dart';

main() {
  final ThemeData theme = ThemeData(
      primaryColor: Colors.indigo,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(foregroundColor: Colors.white),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: Colors.indigo,
        onSecondary: Colors.indigoAccent,
        primary: Colors.indigo,
        secondary: Colors.indigoAccent,
        background: Colors.black,
        error: Colors.red,
        onBackground: Colors.black12,
        onError: Colors.green,
        onSurface: Colors.blue,
        surface: Colors.blueAccent,
      ));
  runApp(MaterialApp(
    title: 'Simple Interest Calculator',
    home: const SIform(),
    debugShowCheckedModeBanner: false,
    theme: theme,
  ));
}

class SIform extends StatefulWidget {
  const SIform({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SIformState();
  }
}

class _SIformState extends State<SIform> {
  final _formKey = GlobalKey<FormState>();
  final _currency = ['Naira', 'Dollar', 'Euros'];
  var _currentItemSelected = 'Naira';
  final _minpadding = 5.0;

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minpadding * 2),
          child: ListView(children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: _minpadding, bottom: _minpadding),
              child: TextFormField(
                style: textStyle,
                keyboardType: TextInputType.number,
                controller: principalController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter principal amount';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Input the Principal e.g 1200',
                    labelStyle: textStyle,
                    errorStyle: const TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minpadding, bottom: _minpadding),
              child: TextFormField(
                style: textStyle,
                keyboardType: TextInputType.number,
                controller: roiController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter rate of interest';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    hintText: 'In Percentage',
                    labelStyle: textStyle,
                    errorStyle: const TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minpadding, bottom: _minpadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: termController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter time in years';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in the years',
                          labelStyle: textStyle,
                          errorStyle: const TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                  Container(
                    width: _minpadding * 5,
                  ),
                  Expanded(
                    child: DropdownButton(
                      style: textStyle,
                      items: _currency.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (newSelectedValue) {
                        setState(() {
                          _currentItemSelected = newSelectedValue!;
                        });
                      },
                      value: _currentItemSelected,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minpadding, bottom: _minpadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColorDark,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondary, // foreground
                      ),
                      child: const Text(
                        'Calculate',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            displayResult = _calculateTotalReturns();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColorLight,
                        backgroundColor:
                            Theme.of(context).primaryColorDark, // foreground
                      ),
                      child: const Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minpadding, bottom: _minpadding),
              child: Text(
                displayResult,
                textScaleFactor: 1.5,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = const AssetImage('images/mon.png');
    Image image = Image(
      image: assetImage,
      width: 125,
      height: 125,
    );
    return Container(
      margin: EdgeInsets.all(_minpadding * 10),
      child: image,
    );
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);

    double roi = double.parse(roiController.text);

    double term = double.parse(termController.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment would be worth $totalAmountPayable $_currentItemSelected';

    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currency[0];
  }
}
