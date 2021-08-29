/// Package imports
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// db_connect
import 'package:mysql1/mysql1.dart' as mysql;

/// Local imports
import '../../../../../../model/sample_view.dart';
import '../../../../../../model/mysql.dart';
import '../../../../../../model/product.dart';

/// Renders the chart with custom zooming buttons sample.
class ButtonZooming2 extends SampleView {
  /// Creates the chart with custom zooming buttons.
  const ButtonZooming2(Key key) : super(key: key);

  @override
  _ButtonZooming2State createState() => _ButtonZooming2State();
}

/// State class of the chart with custom zooming buttons.
class _ButtonZooming2State extends SampleViewState {
  _ButtonZooming2State();
  late ZoomPanBehavior _zoomPan;

  var db = Mysql();
  List<ProductSmartPlug1> productSmartPlugList = [];
  void _getSmartPlug() {
    // getConnection() -> future는 비동기로 진행하겠다라는 뜻
    // _getSmartPlug  돌리고 -> 돌리자 마자
    db.getConnection().then((conn) {
      String sql =
          "select date_format(datetime, '%Y-%m-%d %H:00') DateTime, round(sum(amp), 2) amp from db.Smart_plug where id NOT IN (111) and date_format(datetime, '%Y-%m-%d %H:00') is not null and datetime NOT IN ('2020-11-01 00:00:00') group by date_format(db.Smart_plug.datetime, '%Y-%m-%d %H:00')";

      conn.query(sql).then((results) {
        for (var column in results) {
          setState(() {
            print(column);
            ProductSmartPlug1 productSmartPlug1 =
                ProductSmartPlug1(column[0], column[1]);

            productSmartPlugList.add(productSmartPlug1);
          });
        }
        print("queryResult1 " + productSmartPlugList.length.toString());

        print("queryResult3 " + productSmartPlugList.length.toString());
      });
    });
  }

  @override
  void initState() {
    _zoomPan = ZoomPanBehavior(
      // 줌인 설정
      enableDoubleTapZooming: true,
      enablePanning: true,
      enablePinching: true,
      enableSelectionZooming: true,
    );
    super.initState();

    _getSmartPlug();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: model.cardThemeColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, isCardView ? 0 : 50),
          child: Container(child: _buildButtonZoomingChart()),
        ),
        floatingActionButton: isCardView
            ? null
            : Container(
                child: Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50, // 버튼 위치 설정
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: model.isWebFullView
                                  ? null
                                  : (MediaQuery.of(context).size.width / 7) *
                                      0.9,
                              padding: const EdgeInsets.fromLTRB(24, 15, 0, 0),
                              child: Tooltip(
                                // Plus
                                message: '줌 인',
                                child: IconButton(
                                  icon: Icon(Icons.add,
                                      color: model.backgroundColor),
                                  onPressed: () {
                                    _zoomPan.zoomIn();
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: model.isWebFullView
                                  ? null
                                  : (MediaQuery.of(context).size.width / 7) *
                                      0.9,
                              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: Tooltip(
                                message: '줌 아웃',
                                child: IconButton(
                                  icon: Icon(Icons.remove,
                                      color: model.backgroundColor),
                                  onPressed: () {
                                    _zoomPan.zoomOut();
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: model.isWebFullView
                                  ? null
                                  : (MediaQuery.of(context).size.width / 7) *
                                      0.9,
                              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: Tooltip(
                                message: '위쪽 이동',
                                child: IconButton(
                                  icon: Icon(Icons.keyboard_arrow_up,
                                      color: model.backgroundColor),
                                  onPressed: () {
                                    _zoomPan.panToDirection('top');
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: model.isWebFullView
                                  ? null
                                  : (MediaQuery.of(context).size.width / 7) *
                                      0.9,
                              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: Tooltip(
                                message: '아래쪽 이동',
                                child: IconButton(
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: model.backgroundColor),
                                  onPressed: () {
                                    _zoomPan.panToDirection('bottom');
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: model.isWebFullView
                                  ? null
                                  : (MediaQuery.of(context).size.width / 7) *
                                      0.9,
                              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: Tooltip(
                                message: '왼쪽 이동',
                                child: IconButton(
                                  icon: Icon(Icons.keyboard_arrow_left,
                                      color: model.backgroundColor),
                                  onPressed: () {
                                    _zoomPan.panToDirection('left');
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: model.isWebFullView
                                  ? null
                                  : (MediaQuery.of(context).size.width / 7) *
                                      0.9,
                              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: Tooltip(
                                message: '오른쪽 이동',
                                child: IconButton(
                                  icon: Icon(Icons.keyboard_arrow_right,
                                      color: model.backgroundColor),
                                  onPressed: () {
                                    _zoomPan.panToDirection('right');
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: model.isWebFullView
                                  ? null
                                  : (MediaQuery.of(context).size.width / 7) *
                                      0.9,
                              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: Tooltip(
                                message: '되돌리기',
                                child: IconButton(
                                  icon: Icon(Icons.refresh,
                                      color: model.backgroundColor),
                                  onPressed: () {
                                    _zoomPan.reset();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              ));
  }

  /// Returns the Cartesian chart with custom zooming buttons.
  SfCartesianChart _buildButtonZoomingChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis:
          DateTimeAxis(majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: getButtonZoomingSeries(isCardView),
      zoomPanBehavior: _zoomPan,
    );
  }

  List<ChartSampleData> getDateTimeData() {
    // splineSeriesData얘가 무조건 초기화 한번 되어야지 아래있는 build가 돈다.
    // 이 [] 대 괄호 안에 이렇게 여러개 요소를 넣을 수 있는 거 보면 for문도 가능하다는 것을 인지 하자.
    List<ChartSampleData> splineSeriesData = <ChartSampleData>[
      for (var i = 0; i < productSmartPlugList.length; i++)
        ChartSampleData(
            x: DateTime.parse(
                productSmartPlugList[i].datetime!), // !는 null이 아니라고 확신을 주는 것
            y: productSmartPlugList[i].amp),
    ];
    print("queryResult2 " + productSmartPlugList.length.toString());

    return splineSeriesData;
  }

  /// List holding the collection of chart series data points.
  // final List<ChartSampleData> zoomData = <ChartSampleData>[
  //   ChartSampleData(x: 1.5, y: 21),
  //   ChartSampleData(x: 2.2, y: 24),
  //   ChartSampleData(x: 3.32, y: 36),
  //   ChartSampleData(x: 4.56, y: 38),
  //   ChartSampleData(x: 5.87, y: 54),
  //   ChartSampleData(x: 6.8, y: 57),
  //   ChartSampleData(x: 8.5, y: 70),
  //   ChartSampleData(x: 9.5, y: 21),
  //   ChartSampleData(x: 10.2, y: 24),
  //   ChartSampleData(x: 11.32, y: 36),
  //   ChartSampleData(x: 14.56, y: 38),
  //   ChartSampleData(x: 15.87, y: 54),
  //   ChartSampleData(x: 16.8, y: 57),
  //   ChartSampleData(x: 18.5, y: 23),
  //   ChartSampleData(x: 21.5, y: 21),
  //   ChartSampleData(x: 22.2, y: 24),
  //   ChartSampleData(x: 23.32, y: 36),
  //   ChartSampleData(x: 24.56, y: 32),
  //   ChartSampleData(x: 25.87, y: 54),
  //   ChartSampleData(x: 26.8, y: 12),
  //   ChartSampleData(x: 28.5, y: 54),
  //   ChartSampleData(x: 30.2, y: 24),
  //   ChartSampleData(x: 31.32, y: 36),
  //   ChartSampleData(x: 34.56, y: 38),
  //   ChartSampleData(x: 35.87, y: 14),
  //   ChartSampleData(x: 36.8, y: 57),
  //   ChartSampleData(x: 38.5, y: 70),
  //   ChartSampleData(x: 41.5, y: 21),
  //   ChartSampleData(x: 41.2, y: 24),
  //   ChartSampleData(x: 43.32, y: 36),
  //   ChartSampleData(x: 44.56, y: 21),
  //   ChartSampleData(x: 45.87, y: 54),
  //   ChartSampleData(x: 46.8, y: 57),
  //   ChartSampleData(x: 48.5, y: 54),
  //   ChartSampleData(x: 49.56, y: 38),
  //   ChartSampleData(x: 49.87, y: 14),
  //   ChartSampleData(x: 51.8, y: 57),
  //   ChartSampleData(x: 54.5, y: 32),
  //   ChartSampleData(x: 55.5, y: 21),
  //   ChartSampleData(x: 57.2, y: 24),
  //   ChartSampleData(x: 59.32, y: 36),
  //   ChartSampleData(x: 60.56, y: 21),
  //   ChartSampleData(x: 62.87, y: 54),
  //   ChartSampleData(x: 63.8, y: 23),
  //   ChartSampleData(x: 65.5, y: 54)
  // ];

  /// Returns the list of chart series which need to render
  /// on the chart with custom zooming buttons.
  List<LineSeries<ChartSampleData, DateTime>> getButtonZoomingSeries(
      bool isTileView) {
    return <LineSeries<ChartSampleData, DateTime>>[
      LineSeries<ChartSampleData, DateTime>(
          dataSource: getDateTimeData(),
          xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          width: 2)
    ];
  }
}
