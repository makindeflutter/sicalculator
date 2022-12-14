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
  var _currency = ['Naira', 'Dollar', 'Euros'];
  var _currentItemSelected = 'Naira';
  final _minpadding = 5.0;
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minpadding * 2),
        child: ListView(children: <Widget>[
          getImageAsset(),
          Padding(
            padding: EdgeInsets.only(top: _minpadding, bottom: _minpadding),
            child: TextField(
              style: textStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Input the Principal e.g 1200',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: _minpadding, bottom: _minpadding),
            child: TextField(
              style: textStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'In Percentage',
                  labelStyle: textStyle,
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
                  child: TextField(
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Term',
                        hintText: 'Time in the years',
                        labelStyle: textStyle,
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
                      backgroundColor:
                          Theme.of(context).colorScheme.secondary, // foreground
                    ),
                    child: const Text('Calculate'),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColorLight,
                      backgroundColor:
                          Theme.of(context).primaryColorDark, // foreground
                    ),
                    child: const Text('Reset'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: _minpadding, bottom: _minpadding),
            child: const Text('TOdo Text'),
          ),
        ]),
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
}
