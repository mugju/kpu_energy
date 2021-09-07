/// Package import
import 'package:flutter/material.dart';

/// Local imports
import '../../../../model/sample_view.dart';
// import '../../../../model/mysql.dart';
// import '../../../../model/product.dart';

// /// db_connect
// import 'package:mysql1/mysql1.dart' as mysql;

/// Renders the doughnut chart with legend
class StoreInfo extends SampleView {
  /// Creates the doughnut chart with legend
  const StoreInfo(Key key) : super(key: key);

  @override
  _StoreInfoState createState() => _StoreInfoState();
}

class _StoreInfoState extends SampleViewState {
  _StoreInfoState();

  // var db = Mysql();
  // List<ProductStore> productStoreList = [];
  // void _getStore() {
  //   db.getConnection().then((conn) {
  //     String sql = 'SELECT * FROM STORE';
  //     conn.query(sql).then((results) {
  //       for (var column in results) {
  //         setState(() {
  //           ProductStore productStore =
  //               new ProductStore(column[0], column[1], column[2], column[3]);
  //           productStoreList.add(productStore);
  //           print(productStoreList[0].storeId);
  //           print(productStoreList[0].name);
  //           print(productStoreList[0].location);
  //           print(productStoreList[0].phone);
  //         });
  //       }
  //     });
  //   });
  // }

  // @override
  // initState() {
  //   super.initState();
  //   _getStore();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Color(0xffffffff),
                offset: Offset(0.0, 6.0),
                blurRadius: 0,
                spreadRadius: 0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 150,
                width: 360,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: '[매장 정보]',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                   Divider(
                      // Divider -> 공간을 나누는 선
                      height:
                          60.0, // height ->  높이 설정 -> 위와 아래 사이의 간격이 합쳐서 60.0 이라는 뜻(위 아래로 각 30px)
                      color: Colors.blue[600], // color -> 색상 설정
                      thickness: 1, // thickness -> 선의 굵기
                      endIndent:
                          20.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                    ),
                    RichText(
                      
                      text: const TextSpan(
                        text: '매장 아이디 : 11',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      // Divider -> 공간을 나누는 선
                      height:
                          60.0, // height ->  높이 설정 -> 위와 아래 사이의 간격이 합쳐서 60.0 이라는 뜻(위 아래로 각 30px)
                      color: Colors.blue[600], // color -> 색상 설정
                      thickness: 1, // thickness -> 선의 굵기
                      endIndent:
                          20.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                    ),
                    RichText(
                      text: const TextSpan(
                        text: '매장 명: 토스피아',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      // Divider -> 공간을 나누는 선
                      height:
                          60.0, // height ->  높이 설정 -> 위와 아래 사이의 간격이 합쳐서 60.0 이라는 뜻(위 아래로 각 30px)
                      color: Colors.blue[600], // color -> 색상 설정
                      thickness: 1, // thickness -> 선의 굵기
                      endIndent:
                          20.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                    ),
                    RichText(
                      text: const TextSpan(
                        text: 'Phone :  1234-1234',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      // Divider -> 공간을 나누는 선
                      height:
                          60.0, // height ->  높이 설정 -> 위와 아래 사이의 간격이 합쳐서 60.0 이라는 뜻(위 아래로 각 30px)
                      color: Colors.blue[600], // color -> 색상 설정
                      thickness: 1, // thickness -> 선의 굵기
                      endIndent:
                          20.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                    ),
                    RichText(
                      text: const TextSpan(
                        text: '매장 위치 :  시흥',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      // Divider -> 공간을 나누는 선
                      height:
                          60.0, // height ->  높이 설정 -> 위와 아래 사이의 간격이 합쳐서 60.0 이라는 뜻(위 아래로 각 30px)
                      color: Colors.blue[600], // color -> 색상 설정
                      thickness: 1, // thickness -> 선의 굵기
                      endIndent:
                          20.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
