/// Flutter package imports
import 'package:flutter/material.dart';

/// Barcode imports
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

/// Local imports
import '../../model/sample_view.dart';

/// Widget of the one dimensional barcodes.
class OneDimensionalBarcodes extends SampleView {
  /// Creates one dimensional barcodes.
  const OneDimensionalBarcodes({Key? key}) : super(key: key);
  @override
  _OneDimensionalBarcodesState createState() => _OneDimensionalBarcodesState();
}

class _OneDimensionalBarcodesState extends SampleViewState {
  _OneDimensionalBarcodesState();

  @override
  Widget build(BuildContext context) {
    EdgeInsets _padding = const EdgeInsets.fromLTRB(0, 20, 0, 0);
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      _padding = const EdgeInsets.fromLTRB(0, 20, 0, 0);
    } else {
      final double _margin = (MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 0.6) /
          2;

      _padding = EdgeInsets.fromLTRB(_margin, 20, _margin, 0);
    }
    return Scaffold(
      backgroundColor:
          model.isWebFullView ? Colors.transparent : model.cardThemeColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
        child: Padding(
          padding: _padding,
          child: Container(child: getOneDimensionalBarcodes(context)),
        ),
      ),
    );
  }

  /// Returns the one dimensional barcodes
  Widget getOneDimensionalBarcodes(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildSampleWidget(context)),
    );
  }

  /// Returns the one dimensional barcodes for web view.
  List<Widget> _buildWidgetForWeb(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);
    final Color _color = _themeData.brightness == Brightness.dark
        ? const Color(0xFF666666)
        : const Color(0xFFC4C4C4);
    return <Widget>[
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Codabar barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                    child: SfBarcodeGenerator(
                      textAlign: TextAlign.justify,
                      textSpacing: 10,
                      value: '123456789',
                      showValue: true,
                      symbology: Codabar(module: 1),
                    ),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('Codabar',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        r'Supports 0-9,-,$,:,/,.,+           '
                        '                                  ',
                        style: TextStyle(fontSize: 12)))
              ],
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Added Code39 barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 1, 10),
                    child: SfBarcodeGenerator(
                      textAlign: TextAlign.justify,
                      textSpacing: 10,
                      value: 'CODE39',
                      showValue: true,
                      symbology: Code39(module: 1),
                    ),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('Code39',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        r'Supports A-Z, 0-9,-, ., $, /, +, %, and space   '
                        '    ',
                        style: TextStyle(fontSize: 12)))
              ],
            ),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code39 Extended barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          // backgroundColor: Colors.red,
                          textSpacing: 10,
                          value: '051091',
                          showValue: true,
                          symbology: Code39Extended(module: 1),
                        ),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('Code39 Extended',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        'Supports only ASCII characters.           '
                        '            ',
                        style: TextStyle(fontSize: 12)))
              ],
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code93 barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 20, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          //    backgroundColor: Colors.red,
                          textSpacing: 10,
                          value: '01234567',
                          showValue: true,
                          symbology: Code93(module: 1),
                        ),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('Code93',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        r'Supports  A-Z, 0-9 , -, ., $, /, +, % and space',
                        style: TextStyle(fontSize: 12)))
              ],
            ),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added UPC-A barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 25, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textStyle: const TextStyle(fontSize: 10),
                          textSpacing: 3,
                          value: '72527273070',
                          showValue: true,
                          symbology: UPCA(module: 1),
                        ),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('UPC-A',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        'Supports 11 numbers as input                   '
                        '      ',
                        style: TextStyle(fontSize: 12)))
              ],
            ),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added UPC-E barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: Container(
                        child: SfBarcodeGenerator(
                      textAlign: TextAlign.justify,
                      textSpacing: 3,
                      value: '123456',
                      showValue: true,
                      symbology: UPCE(module: model.isWebFullView ? 2 : 1),
                    )),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('UPC-E',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        'Supports 6 numbers as input                    '
                        '     ',
                        style: TextStyle(fontSize: 12)))
              ],
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added EAN-8 barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 20, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 3,
                          value: '11223344',
                          showValue: true,
                          symbology: EAN8(module: 2),
                        ),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('EAN-8',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        'Supports 8 numbers as input                    ',
                        style: TextStyle(fontSize: 12)))
              ],
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added EAN-13 barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(7, 10, 35, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textStyle: const TextStyle(fontSize: 11),
                          textSpacing: 3,
                          value: '9735940564824',
                          showValue: true,
                          symbology: EAN13(module: 1),
                        ),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('EAN-13',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        'Supports 13 numbers as input                    ',
                        style: TextStyle(fontSize: 12)))
              ],
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code128 barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 20, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 10,
                          value: 'CODE128',
                          showValue: true,
                          symbology: Code128(module: 1),
                        ),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 1, 1),
                  child: Text('Code128',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(25, 2, 1, 10),
                    child: Text('Support 0-9 A-Z a-z and special character.   ',
                        style: TextStyle(fontSize: 12)))
              ],
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code128A barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 30, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 10,
                          value: 'CODE128A',
                          showValue: true,
                          symbology: Code128A(module: 1),
                        ),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('Code128A',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        'Support 0-9 A-Z and special character           ',
                        style: TextStyle(fontSize: 12)))
              ],
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code128B barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                    child: Container(
                        child: SfBarcodeGenerator(
                      textAlign: TextAlign.justify,
                      textSpacing: 10,
                      value: 'Code128B',
                      showValue: true,
                      symbology: Code128B(module: 1),
                    )),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                  child: Text('Code128B',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                    child: Text(
                        'Support 0-9 A-Z and special character           ',
                        style: TextStyle(fontSize: 12)))
              ],
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code128C barcode
            Container(
              child: Container(
                  width: 200,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 10,
                          value: '0123456',
                          showValue: true,
                          symbology: Code128C(module: 1),
                        ),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 1, 1),
                  child: Text('Code128C',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(25, 2, 1, 10),
                    child: Text(
                        'Support even number of digits                 ',
                        style: TextStyle(fontSize: 12)))
              ],
            )
          ],
        ),
      ),
    ];
  }

  /// Returns the one dimensional barcodes for mobile view.
  List<Widget> _buildWidgetForMobile(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);
    final Color _color = _themeData.brightness == Brightness.dark
        ? const Color(0xFF666666)
        : const Color(0xFFC4C4C4);
    return <Widget>[
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Codabar barcode
            Expanded(
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                child: SfBarcodeGenerator(
                  textAlign: TextAlign.justify,
                  textSpacing: 10,
                  value: '123456789',
                  showValue: true,
                  symbology: Codabar(),
                ),
              )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('Codabar',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text(r'Supports Supports 0-9,-,$,:,/,.,+',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code39 barcode
            Expanded(
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                child: SfBarcodeGenerator(
                  textAlign: TextAlign.justify,
                  textSpacing: 10,
                  value: 'CODE39',
                  showValue: true,
                  symbology: Code39(),
                ),
              )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('Code39',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text(
                          r'Supports A-Z, 0-9,-, ., $, /, +, %, and space ',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code39Extended barcode
            Expanded(
              child: Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          // backgroundColor: Colors.red,
                          textSpacing: 10,
                          value: '051091',
                          showValue: true,
                          symbology: Code39Extended(),
                        ),
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('Code39 Extended',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text('Supports only ASCII characters.',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code93 barcode
            Expanded(
              child: Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 10,
                          value: '01234567',
                          showValue: true,
                          symbology: Code93(),
                        ),
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('Code93',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text(r'A-Z, 0-9 , -, ., $, /, +, % and space',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added UPC-A barcode
            Expanded(
              child: Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 3,
                          value: '72527273070',
                          showValue: true,
                          textStyle: const TextStyle(fontSize: 11),
                          symbology: UPCA(),
                        ),
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('UPC-A',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text('Supports 11 numbers as input',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added UPC-E barcode
            Expanded(
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                child: Container(
                    child: SfBarcodeGenerator(
                  textAlign: TextAlign.justify,
                  textSpacing: 3,
                  value: '123456',
                  showValue: true,
                  symbology: UPCE(),
                )),
              )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('UPC-E',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text('Supports 6 numbers as input',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added EAN-8 barcode
            Expanded(
              child: Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 3,
                          value: '11223344',
                          showValue: true,
                          symbology: EAN8(),
                        ),
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('EAN-8',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text('Supports 8 numbers as input',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added EAN-13 barcode
            Expanded(
              child: Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 3,
                          value: '9735940564824',
                          showValue: true,
                          textStyle: const TextStyle(fontSize: 11),
                          symbology: EAN13(module: 1),
                        ),
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('EAN-13',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text('Supports 13 numbers as input',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code128 barcode
            Expanded(
              child: Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 10,
                          value: 'CODE128',
                          showValue: true,
                          symbology: Code128(),
                        ),
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('Code128',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text('Support 0-9 A-Z a-z and special character',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code128A barcode
            Expanded(
              child: Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 10,
                          value: 'CODE128A',
                          showValue: true,
                          symbology: Code128A(),
                        ),
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('Code128A',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text('Support 0-9 A-Z and special character',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code128B barcode
            Expanded(
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                child: Container(
                    child: SfBarcodeGenerator(
                  textAlign: TextAlign.justify,
                  textSpacing: 10,
                  value: 'Code128B',
                  showValue: true,
                  symbology: Code128B(),
                )),
              )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('Code128B',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text('Support 0-9 A-Z and special character',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Divider(height: 20.0, indent: 5.0, color: _color)),
      Container(
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Added Code128C barcode
            Expanded(
              child: Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                      child: Container(
                        child: SfBarcodeGenerator(
                          textAlign: TextAlign.justify,
                          textSpacing: 10,
                          value: '0123456',
                          showValue: true,
                          symbology: Code128C(),
                        ),
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    child: Text('Code128C',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 1, 10),
                      child: Text('Support even number of digits',
                          style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildSampleWidget(BuildContext context) {
    return model.isWebFullView
        ? _buildWidgetForWeb(context)
        : _buildWidgetForMobile(context);
  }
}
