///Dart import
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

/// Package imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

/// Barcode import
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// Local import
import '../../../../model/model.dart';
import '../../../../model/sample_view.dart';
import '../../../../model/mysql.dart';
import '../../../../model/product.dart';

/// render data grid widget
class StylingDataGrid extends SampleView {
  /// Creates data grid widget
  const StylingDataGrid({Key? key}) : super(key: key);

  @override
  _StylingDataGridState createState() => _StylingDataGridState();
}

class _StylingDataGridState extends SampleViewState {
  /// Supported to notify the panel visibility
  final ValueNotifier<bool> frontPanelVisible = ValueNotifier<bool>(true);
  void _subscribeToValueNotifier() => panelOpen = frontPanelVisible.value;
  bool panelOpen = false;

  /// Determine to decide whether the device in landscape or in portrait
  bool isLandscapeInMobileView = false;

  /// Required for SfDataGrid to obtain the row data.
  late _StylingDataGridSource stylingDataGridSource;

  /// Determine to set the gridLineVisibility of SfDataGrid.
  late String gridLinesVisibility;

  /// Determine to set the gridLineVisibility of SfDataGrid.
  late GridLinesVisibility gridLineVisibility;

  late bool isWebOrDesktop;

  /// GridLineVisibility strings for drop down widget.
  final List<String> _encoding = <String>[
    'both',
    'horizontal',
    'none',
    'vertical',
  ];

  void _onGridLinesVisibilityChanges(String item) {
    gridLinesVisibility = item;
    switch (gridLinesVisibility) {
      case 'both':
        gridLineVisibility = GridLinesVisibility.both;
        break;
      case 'horizontal':
        gridLineVisibility = GridLinesVisibility.horizontal;
        break;
      case 'none':
        gridLineVisibility = GridLinesVisibility.none;
        break;
      case 'vertical':
        gridLineVisibility = GridLinesVisibility.vertical;
        break;
    }
    setState(() {});
  }

  List<GridColumn> getColumns() {
    const TextStyle textStyle =
        TextStyle(color: Color.fromRGBO(255, 255, 255, 1));

    // web 화면 출력 관련 코드 지우고 앱 화면 출력 코드만 남김
    // chart 상단의 파란 컬럼 내용
    return <GridColumn>[
      GridColumn(
        columnName: 'storeId',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: const Text(
            'Store ID',
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'name',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Name',
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'phone',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Phone',
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'location',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Location',
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ];
  }

  SfDataGridTheme _buildDataGrid(GridLinesVisibility gridLineVisibility) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          brightness: model.themeData.brightness,
          headerHoverColor: Colors.white.withOpacity(0.3),
          headerColor: model.backgroundColor),
      child: SfDataGrid(
        source: stylingDataGridSource,
        columnWidthMode: ColumnWidthMode.fill,
        gridLinesVisibility: gridLineVisibility,
        columns: getColumns(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isWebOrDesktop = model.isWeb || model.isDesktop;
    stylingDataGridSource =
        _StylingDataGridSource(model: model, isWebOrDesktop: isWebOrDesktop);
    gridLinesVisibility = 'horizontal';
    gridLineVisibility = GridLinesVisibility.horizontal;
    panelOpen = frontPanelVisible.value;
    frontPanelVisible.addListener(_subscribeToValueNotifier);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isLandscapeInMobileView = !isWebOrDesktop &&
        MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return ListView(shrinkWrap: true, children: <Widget>[
        ListTile(
          title: Text(
            model.isWebFullView
                ? 'Grid lines \nvisibility'
                : 'Grid lines visibility',
            softWrap: false,
            style: TextStyle(fontSize: 16.0, color: model.textColor),
          ),
          trailing: Theme(
            data: ThemeData(canvasColor: model.bottomSheetBackgroundColor),
            child: DropdownButton<String>(
                value: gridLinesVisibility,
                items: _encoding.map((String value) {
                  return DropdownMenuItem<String>(
                      value: (value != null) ? value : 'none',
                      child: Text(value,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: model.textColor)));
                }).toList(),
                onChanged: (dynamic value) {
                  _onGridLinesVisibilityChanges(value);
                  stateSetter(() {});
                }),
          ),
        ),
      ]);
    });
  }

  //차트 외각 디자인
  BoxDecoration drawBorder() {
    final BorderSide borderSide = BorderSide(
        width: 1.0,
        color: model.themeData.brightness == Brightness.light
            ? const Color.fromRGBO(0, 0, 0, 0.26)
            : const Color.fromRGBO(255, 255, 255, 0.26));

    // Restricts the right side border when Datagrid has gridlinesVisibility
    // to both and vertical to maintains the border thickness.
    switch (gridLineVisibility) {
      case GridLinesVisibility.none:
      case GridLinesVisibility.horizontal:
        return BoxDecoration(
            border: Border(
                left: borderSide, right: borderSide, bottom: borderSide));
      case GridLinesVisibility.both:
      case GridLinesVisibility.vertical:
        return BoxDecoration(
            border: Border(left: borderSide, bottom: borderSide));
    }
  }

  // 여기까지 디자인이라 이 위에 db 선언해도 의미 없음
  @override
  Widget build(BuildContext context) {
    return Container(
        color: model.themeData.brightness == Brightness.light
            ? const Color(0xFFFAFAFA)
            : null,
        child: Card(
            margin: isWebOrDesktop
                ? const EdgeInsets.all(24.0)
                : const EdgeInsets.all(16.0),
            clipBehavior: Clip.antiAlias,
            elevation: 1.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DecoratedBox(
                  decoration: drawBorder(),
                  child: _buildDataGrid(gridLineVisibility)),
            )));
  }
}

// class _Employee {
//   _Employee(this.orderId, this.customerId, this.name, this.city, this.freight,
//       this.price);
//   final int orderId;
//   final int customerId;
//   final String name;
//   final String city;
//   final double freight;
//   final double price;
// }

//얘가 stateful 위젯이 아니라서 setState 사용 불가능
// 얘를 stateful로 바꿔줄지 아니면 setState를 대체할 코드 찾기
class _StylingDataGridSource extends DataGridSource {
  Mysql db = Mysql();

  final List<ProductStore> productStoreList = <ProductStore>[];

  void _getStore() {
    db.getConnection().then((conn) {
      String sql = 'SELECT * from Store';
      conn.query(sql).then((results) {
        for (var column in results) {
          ProductStore productStore = new ProductStore(column[0], column[1], column[2], column[3]);
          productStoreList.add(productStore);
          print(column[0]);
          print(column[1]);
          print(column[2]);
          print(column[3]);
          print("queryResult 0 : " + productStoreList.length.toString());
        }
        print("queryResult 1 : " + productStoreList.length.toString());
        buildDataGridRows();
        print("queryResult 2 : " + productStoreList.length.toString());
      });
      
    });
    
  }

  List<ProductStore> returnProductStoreList = <ProductStore>[];

  _StylingDataGridSource({required this.model, required this.isWebOrDesktop}) {
    //employees = getEmployees(100);

    _getStore();

  }

  final math.Random random = math.Random();
  final SampleModel model;

  // 얘는 수정해야 함
  //List<_Employee> employees = <_Employee>[];

  // 건들면 안될 것 같음
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  // _Employee 대체인데 동시에 두번 선언이 맞나? -> 아니다 값이 안들어 간다. 위에서 못끌고 온다

  final bool isWebOrDesktop;

  /// Build DataGridRow collection

  // 이부분 수정해서 값 추가히면 될듯 하다.
  void buildDataGridRows() {
    // 아예 여기를 지우고 for문으로 대체할지 고민해보기기
    print("queryResult 3 : " + productStoreList.length.toString());
    dataGridRows = returnProductStoreList.map<DataGridRow>((ProductStore productRow) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<int>(columnName: 'storeId', value: productRow.storeId!),
        DataGridCell<String>(columnName: 'name', value: productRow.name!),
        DataGridCell<String>(columnName: 'city', value: productRow.phone!),
        DataGridCell<String>(columnName: 'location', value: productRow.location!),
        
      ]);
    }).toList(growable: false);
    print("queryResult 4 : " + productStoreList.length.toString());
    //print("queryResult 4 : " + productStoreList[0].storeId.toString());
  }

  


    // Overrides
  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    
    //_getStore;
   
    print("queryResult 5 : " + productStoreList.length.toString());
    
    final int rowIndex = dataGridRows.indexOf(row);
    
    Color backgroundColor = Colors.transparent;
    if ((rowIndex % 2) == 0) {
      backgroundColor = model.backgroundColor.withOpacity(0.07);
    }

    return DataGridRowAdapter(color: backgroundColor, cells: <Widget>[
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.centerRight,
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.centerRight,
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  // _Employee data sets
  //
  // final List<String> names = <String>[
  //   'Folko',
  //   'Warth',
  //   'Alfki',
  //   'Frans',
  //   'Welli',
  //   'Folig',
  //   'Seves',
  //   'Furib',
  //   'Picco',
  //   'Linod',
  //   'Simob',
  //   'Vaffe',
  //   'Rascu',
  //   'Blonp',
  //   'Merep'
  // ];
  // final List<String> cities = <String>[
  //   'Graz',
  //   'Bruxelles',
  //   'Rosario',
  //   'Recife',
  //   'Campinas',
  //   'Montreal',
  //   'Tsawassen',
  //   'Resende',
  // ];
//
//   List<_Employee> getEmployees(int count) {
//     final List<_Employee> employeeData = <_Employee>[];
//     for (int i = 0; i < count; i++) {
//       employeeData.add(_Employee(
//         1000 + i,
//         1700 + i,
//         names[i < names.length ? i : random.nextInt(names.length - 1)],
//         cities[random.nextInt(cities.length - 1)],
//         random.nextInt(1000) + random.nextDouble(),
//         1500.0 + random.nextInt(100),
//       ));
//     }
//     return employeeData;
//   }
}
