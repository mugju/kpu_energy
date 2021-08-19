import 'package:flutter/material.dart';

class DeveloperInfo extends StatelessWidget {
  const DeveloperInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeveloperInfo'),
      ),
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
                    Divider(
                          // Divider -> 공간을 나누는 선
                          height:
                              30.0, // height ->  높이 설정 -> 위와 아래 사이의 간격이 합쳐서 60.0 이라는 뜻(위 아래로 각 30px)
                          color: Colors.blue[600], // color -> 색상 설정
                          thickness: 1, // thickness -> 선의 굵기
                          endIndent:
                              30.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                        ),

                    RichText(
                          text: const TextSpan(
                            text: '학과: 컴퓨터 공학부',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                    ),
                    RichText(
                          text: const TextSpan(
                            text: 'Name : 김영민' ,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                    ),
                    RichText(
                          text: const TextSpan(
                            text: 'GitHub ID :TazeKim ',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                    ),

                    Divider(
                          // Divider -> 공간을 나누는 선
                          height: 60.0, // height ->  높이 설정 -> 위와 아래 사이의 간격이 합쳐서 60.0 이라는 뜻(위 아래로 각 30px)
                          color: Colors.blue[600], // color -> 색상 설정
                          thickness: 1, // thickness -> 선의 굵기
                          endIndent: 30.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                        ),

 
                        RichText(
                          text: const TextSpan(
                            text: '학과: 컴퓨터 공학부',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'Name : 김동혁',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'GitHub ID : mugju',
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
                              30.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                        ),
                        RichText(
                          text: const TextSpan(
                            text: '학과: 컴퓨터 공학부',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'Name : 김재현',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'GitHub ID : Nuhuhu',
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
                              30.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                        ),
                        RichText(
                          text: const TextSpan(
                            text: '학과: 컴퓨터 공학부',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'Name : 이영채',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: 'GitHub ID : 1q2w3e4r-kor',
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
                              30.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
                        ),
                    
                    
                  ],
                ),
              )
            ],
          )
        ],
      ),
    )
    );
  }
}