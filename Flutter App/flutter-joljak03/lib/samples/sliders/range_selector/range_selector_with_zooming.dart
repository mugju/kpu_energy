///Dart import
import 'dart:math';

///Package imports
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' hide TextDirection;

///Chart import
import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;

///Core import
import 'package:syncfusion_flutter_core/core.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Slider import
import 'package:syncfusion_flutter_sliders/sliders.dart';

///Local import
import '../../../model/sample_view.dart';
import '../../../../model/mysql.dart';
import '../../../../model/product.dart';

/// db_connect
import 'package:mysql1/mysql1.dart' as mysql;

/// Renders the range selector with line chart zooming option
class RangeSelectorZoomingPage extends SampleView {
  /// Renders the range selector with line chart zooming option
  const RangeSelectorZoomingPage(Key key) : super(key: key);

  @override
  _RangeSelectorZoomingPageState createState() =>
      _RangeSelectorZoomingPageState();
}

class _RangeSelectorZoomingPageState extends SampleViewState
    with SingleTickerProviderStateMixin {
  _RangeSelectorZoomingPageState();

  final DateTime min = DateTime(2020, 08, 01),
      max = DateTime(2020, 11, 01); // min 값과 max 값 설정

  List<ChartSampleData> chartData = <ChartSampleData>[];
  late RangeController rangeController; //late 는 선언을 지연시키겠다는 것. 선언 나중에 하겠다.
  late SfCartesianChart columnChart, splineChart;
  late List<ChartSampleData> columnData,
      splineSeriesData; // 위의 columnData, 아래의 splineSeriesData 선언

  bool enableDeferredUpdate = true; // 지연 업데이트 초기 설정



  List<ProductSmartPlug1> productSmartPlugList = [];

  var db = Mysql();

  void _getSmartPlug() {
    // getConnection() -> future는 비동기로 진행하겠다라는 뜻
    // _getSmartPlug  돌리고 -> 돌리자 마자
    db.getConnection().then((conn) {
      String sql =
          "select date_format(datetime, '%Y-%m-%d') DateTime, round(sum(amp), 3) amp from db.Airconditioner where date_format(datetime, '%Y-%m-%d') is not null group by date_format(db.Airconditioner.datetime, '%Y-%m-%d')";

      conn.query(sql).then((results) {
        for (var column in results) {
          setState(() {
            print(column);
            ProductSmartPlug1 productSmartPlug1 =
                ProductSmartPlug1(column[0], column[1]);

            productSmartPlugList.add(productSmartPlug1);
          });
        }
        print("queryResult " + productSmartPlugList.length.toString());

        result(); // 이 result는 db가 다 돌고 리스트의 데이터가 다 쌓인 다음 호출되는 것
      });
    });
  }

  void result() {
    rangeController = RangeController(
      //변경해야 함
      start: DateTime(2020, 09, 15), //2017-06-28 00:00:00.000Z
      end: DateTime(2020, 10, 15), // 2017-10-16 00:00:00.000Z
    );

    // for (int i = 0; i < 91; i++) {
    //   chartData.add(ChartSampleData(
    //       x: DateTime(2020, 08, 01).add(Duration(days: i)),
    //       y: Random().nextInt(190) + 50));
    // }

    //이걸 사용하려면 아래의 그래프 두개의 datasource를 splineSeriesData 에서 chartData로 변경해줘야 함

    print("queryResult2 " + productSmartPlugList.length.toString());

    for (int i = 0; i < productSmartPlugList.length; i++) {
      chartData.add(
        ChartSampleData(
            x: DateTime(2020, 08, 01).add(Duration(days: i)),
            y: productSmartPlugList[i].amp),
      );
    }



    // splineSeriesData얘가 무조건 초기화 한번 되어야지 아래있는 build가 돈다.
    // 이 [] 대 괄호 안에 이렇게 여러개 요소를 넣을 수 있는 거 보면 for문도 가능하다는 것을 인지 하자.
    splineSeriesData = <ChartSampleData>[
      for (var i = 0; i < productSmartPlugList.length; i++)
        ChartSampleData(
            x: DateTime.parse(productSmartPlugList[i].datetime!), // !는 null이 아니라고 확신을 주는 것
            y: productSmartPlugList[i].amp),
    ];

    // 아래 컬럼 차트
    // 이건 아래 작은 그래프고 이후에 큰 그래프에서 한번더 xValueMapper, yValueMapper로 그린다.
    // 같은 값을 두고 다른 그래프 두개를 그리는 느낌
    // 그 두개의 그래프를 연결하는 코드 찾는게 관건
    columnChart = SfCartesianChart(
      // 여기에 zoom start, zoom end 있는데 활용은 아직 모름
      margin: const EdgeInsets.all(0),
      primaryXAxis: DateTimeAxis(
          isVisible: false,
          maximum: DateTime(2020, 10, 31)), // maximum 데이터로 출력할 년도수
      primaryYAxis:
          NumericAxis(isVisible: false), // 아래 데이터 바의 y축 값 표시 제거 속성 중요x
      plotAreaBorderWidth: 0, // 없어도 되는데 있으면 테두리를 없애줌 중요x
      series: <SplineAreaSeries<ChartSampleData, DateTime>>[
        SplineAreaSeries<ChartSampleData, DateTime>(
          dataSource: splineSeriesData, //SplineAreaSeries가 필수로 요구하는 속성 splineSeriesData은 아래 샘플 데이터를 의미
          // chartData 사용할때 교체하는 곳

          borderColor: const Color.fromRGBO(0, 193, 187, 1), // 아래 데이터 바 위 색상
          color: const Color.fromRGBO(163, 226, 224, 1), // 아래 데이터 바 아래 색상
          borderDrawMode: BorderDrawMode.excludeBottom,
          borderWidth: 1,
          xValueMapper: (ChartSampleData sales, _) =>
              sales.x as DateTime, //x 좌표는 시간으로 나열?
          yValueMapper: (ChartSampleData sales, _) => sales.y, // y좌표들 나열?
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _getSmartPlug();

    //이 result의 목적은 아래의 build를 초기화 반드시 한번 해주기 위해서 존재
    // 이 result는 아무 의미없는 값이 들어가겠지만 아래의 build가 필수로 데이터를 필요로 하기 때문에 오류를 막기 위해 존재
    result(); // 이 result를 실행하는 중에서도 db에는 데이터가 비동기라 아직 없는 상태이다.
  }

  // 위에 실제 chart
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isLightTheme = themeData.brightness ==
        Brightness.light; // 아마 시스템 색 관련 정보 받고 동일하게 출력하기 위한 코드

    //MediaQuery: 하위 항목에 MediaQueryData를 제공하는 위젯을 만든다.
    //MediaQueryData: 명시적 값들 사용하여 미디어 쿼리에 대한 데이터 생성
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    splineChart = SfCartesianChart(
      title: ChartTitle(text: 'Smart Energy Manager Chart'),
      plotAreaBorderWidth: 0, // 큰 chart 테두리 굵기임

      tooltipBehavior: TooltipBehavior(
          // 작은 사각형 툴팁 출력하는 코드
          animationDuration: 0,
          shadowColor: Colors.transparent,
          enable: true),
      primaryXAxis: DateTimeAxis(
          labelStyle: const TextStyle(),
          isVisible: false,

          // 시작할때 큰 그래프의 시작과 끝 부분 정의
          minimum: DateTime(2020, 08, 01), //2017-06-28 00:00:00.000Z
          maximum: DateTime(2020, 08, 31), //2017-10-16 00:00:00.000Z
          rangeController: rangeController),

      // y 축에 대한 설정 -> 현재는 그래프가 y축을 뚫고 들어갈 수 있게 해놨다.
      primaryYAxis: NumericAxis(
        labelPosition: ChartDataLabelPosition.inside,
        labelAlignment: LabelAlignment.end,
        majorTickLines: const MajorTickLines(size: 0),
        axisLine: const AxisLine(color: Colors.transparent),
      ),
      series: <SplineSeries<ChartSampleData, DateTime>>[
        SplineSeries<ChartSampleData, DateTime>(
          name: 'Amp', //눌렀을 때 나오는 작은 창 글자
          dataSource: splineSeriesData, //얘는 null 아닌값이 무조건 들어있어야 하기때문에 null값이 들어가면 에러가 난다.
          color: const Color.fromRGBO(0, 193, 187, 1), // 위의 그래프 색 속성
          animationDuration: 1000, //애니메이션 지연 속성 천천히 나온다.
          xValueMapper: (ChartSampleData sales, _) =>
              sales.x as DateTime, // 여기서 x 값 전달해서 출력
          yValueMapper: (ChartSampleData sales, _) =>
              sales.y, // 여기서 y 값 전달해서 출력
        )
      ],
    );
    final Widget page = Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        color: // 건들필요 x
            model.isWebFullView ? model.cardThemeColor : model.cardThemeColor,
        child: Center(
          child: Column(
            children: <Widget>[
              // Expanded : 자식(Child)이 사용 가능한 공간을 채우도록 행(Row), 열(Column) 또는 유연한영역(Flex)의 자식을 확장하는 위젯.
              Expanded(
                child: Container(
                    //mediaQueryData 이게 위의 mediaQueryData
                    // 아마도 웹, 앱 별 다양한 크기의 화면을 구현하기 위해 Expanded를 쓴게 아닌지 추측
                    width: mediaQueryData.orientation == Orientation.landscape
                        ? model.isWebFullView
                            ? mediaQueryData.size.width * 0.7
                            : mediaQueryData.size.width
                        : mediaQueryData.size.width,
                    padding: const EdgeInsets.fromLTRB(5, 20, 15, 25),
                    child: splineChart),
              ),

              // 셀렉터 선택기의 테마를 적용하기 위함
              SfRangeSelectorTheme(
                  data: SfRangeSelectorThemeData(

                      // 텍스트는 라이트, 다크 테마에 따라 색이 바뀐다.
                      activeLabelStyle: TextStyle(
                          fontSize: 10,
                          color: isLightTheme ? Colors.black : Colors.white),
                      inactiveLabelStyle: TextStyle(
                          fontSize: 10,
                          color: isLightTheme
                              ? Colors.black
                              : const Color.fromRGBO(170, 170, 170, 1)),

                      // 아래의 막대 색 속성
                      activeTrackColor: const Color.fromRGBO(255, 125, 30, 1),
                      inactiveRegionColor: isLightTheme
                          ? Colors.white.withOpacity(0.75)
                          : const Color.fromRGBO(33, 33, 33, 0.75),

                      // 막대 끝 엄지들 색 속성
                      thumbColor: Colors.white,

                      //아마 테두리 속성
                      thumbStrokeColor: const Color.fromRGBO(255, 125, 30, 1),
                      thumbStrokeWidth: 2.0,
                      overlayRadius: 1,
                      overlayColor: Colors.transparent),
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(0),
                    width: mediaQueryData.orientation == Orientation.landscape
                        ? model.isWebFullView
                            ? mediaQueryData.size.width * 0.7
                            : mediaQueryData.size.width
                        : mediaQueryData.size.width,
                    child: Center(
                      // 아래 컬럼 chart 패딩으로 위치 조절
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 15, 15),
                        child: SfRangeSelector(
                          // 위에서 지정했던 시작과 끝
                          //min 2017, 01, 01 / max 2018, 01, 01
                          min: min,
                          max: max,
                          interval: 1, // 그래프 단계는 월 단위가 최소인듯 하다.
                          enableDeferredUpdate: enableDeferredUpdate, //지연시키는 속성
                          deferredUpdateDelay: 1000, //딜레이 속도
                          labelPlacement: LabelPlacement
                              .betweenTicks, // 아래 그래프 끝쪽 덜나가게 하는듯?
                          dateIntervalType: DateIntervalType.months, //건들필요 x
                          controller: rangeController, //건들면 안됨 중요함
                          showTicks: true, // 아래 범위별 막대 출력 속성
                          showLabels: true, // 라벨 글자 출력하는
                          enableIntervalSelection: true, //모르겠음
                          dragMode:
                              SliderDragMode.both, // 엄지 뿐만 아니라 범위도 드래그 가능하도록 함

                          // 라벨 포맷을 정해주는 속성
                          // 이게 없으면 기존 날짜가 다닥다닥 붙어 표시된다.
                          // 이건 중요하니까 다시 깊게 보자
                          labelFormatterCallback:
                              (dynamic actualLabel, String formattedText) {
                            // 라벨 형식을 Feb, Apr 형식으로 설정함
                            String label = DateFormat.MMM().format(actualLabel);

                            //응용 프로그램에 따라 라벨 크기를 다르게 설정
                            //isWebFullView: 응용 프로그램이 웹/linuxOS/windowsOS/macOS에서 실행 중인지 확인
                            label = (model.isWebFullView &&
                                    mediaQueryData.size.width <= 1000)
                                ? label[0]
                                : label;
                            return label;
                          },

                          onChanged: (SfRangeValues values) {},
                          // 컬럼 차트 패딩
                          child: Container(
                            height: 75,
                            padding: const EdgeInsets.all(0),
                            margin: const EdgeInsets.all(0),
                            child: columnChart,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ));

    // 이거도 아마 크기 설정
    return Scaffold(
      body: mediaQueryData.orientation == Orientation.landscape &&
              !model.isWebFullView
          ? Center(
              child: SingleChildScrollView(
                child: Container(height: 400, child: page),
              ),
            )
          : page,
    );
  }

  // 세팅 관련 위젯
  @override
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return Row(children: <Widget>[
        Text('Enable deferred update  ',
            style: TextStyle(
              color: model.textColor,
              fontSize: 16,
            )),
        Padding(
            padding: const EdgeInsets.all(10.0), // 설정 박스 높이
            child: Container(
                width: 90,
                child: CheckboxListTile(
                    activeColor: model.backgroundColor,
                    value: enableDeferredUpdate,
                    onChanged: (bool? value) {
                      setState(() {
                        enableDeferredUpdate = value!;
                        stateSetter(() {});
                      });
                    }))),
      ]);
    });
  }
}
