<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월별 일일 절감량</title>
<!-- googleChart.js -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>


<!-- 데이트피커 -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$.datepicker.setDefaults({
		dateFormat : 'yy-mm-dd',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
				'9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		showMonthAfterYear : true,
		yearSuffix : '년'
	});

	$(function() {
		$("#datepicker").datepicker();
	});
</script>
</head>
<body>
<div align="center">
		<form name="home" method="post">
			<div align="center">
				<c:if test="${client != null }">
					<table border="1">
						<tr>
							<td>${client.getId()}님</td>
							<td><input type="submit" value="로그아웃" formaction="logout" /></td>
							<td><input type="submit" value="홈으로"
								formaction="<c:url value="home"/>" /></td>
						</tr>
					</table>
				</c:if>

				<c:if test="${client == null }">
					<script>
						alert("로그인 해주세요.");
						location.href
						"/team7/web/login";
					</script>
				</c:if>
			</div>
		</form>

		<form name="date" method="post">
			<table border="1">
				<tr>
					<td>날짜</td>
					<td><input id="datepicker" type="text" name="Date"></td>
					<td><input type="submit" value="확인" formaction="reduction_day" /></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- makeGraph -->
	<div id="Line_Controls_Chart">
		<!-- 라인 차트 생성할 영역 -->
		<div id="lineChartArea" style="padding: 0px 20px 0px 0px;"></div>
		<!-- 컨트롤바를 생성할 영역 -->
		<div id="controlsArea" style="padding: 0px 20px 0px 0px;"></div>
	</div>
</body>

<!-- googleChart.js script -->
<script type="text/javascript">
	var chartDrowFun = {

		chartDrow : function() {
			var chartData = '';

			//날짜형식 변경하고 싶으시면 이 부분 수정하세요.
			var chartDateformat = 'yyyy년MM월dd일';
			//라인차트의 라인 수
			var chartLineCount = 10;
			//컨트롤러 바 차트의 라인 수
			var controlLineCount = 10;

			function drawDashboard() {

				var data = new google.visualization.DataTable();
				//그래프에 표시할 컬럼 추가
				data.addColumn('datetime', '날짜');
				data.addColumn('number', '총 사용량');
				data.addColumn('number', '절감후 총 사용량')
				data.addColumn('number','절감률')

				var dateArray = new Array();
				var ampArray = new Array();
				var reductionAmpArray = new Array();

				<c:forEach items = "${total}" var = "vo">
				dateArray.push("${vo.datetime}");
				ampArray.push("${vo.amp}");
				</c:forEach>

				<c:forEach items = "${reductionTotal}" var = "vo">
				reductionAmpArray.push("${vo.amp}");
				</c:forEach>

				//그래프에 표시할 데이터
				var dataRow = [];

				for (var i = 0; i < dateArray.length; i++) { //랜덤 데이터 생성
					var amp = parseFloat(ampArray[i]) * 220;
					var reductionAmp = parseFloat(reductionAmpArray[i]) * 220;
					var percent = ((amp-reductionAmp)/amp)*100
					
					var str = dateArray[i].split(" ");

					dataRow = [
							new Date(str[0] + ", " + str[2] + " " + str[1]
									+ " " + str[5] + " " + str[3]), amp,
							reductionAmp, percent ];
					data.addRow(dataRow);
				}

				var chart = new google.visualization.ChartWrapper({
					chartType : 'LineChart',
					containerId : 'lineChartArea', //라인 차트 생성할 영역
					options : {
						title : '일일 시간당 절감된 전력량',
						isStacked : 'percent',
						focusTarget : 'category',
						height : 500,
						width : '100%',
						legend : {
							position : "top",
							textStyle : {
								fontSize : 13
							}
						},
						pointSize : 5,
						tooltip : {
							textStyle : {
								fontSize : 12
							},
							showColorCode : true,
							trigger : 'both'
						},
						hAxis : {
							format : chartDateformat,
							gridlines : {
								count : chartLineCount,
								units : {
									years : {
										format : [ 'yyyy년' ]
									},
									months : {
										format : [ 'MM월' ]
									},
									days : {
										format : [ 'dd일' ]
									},
									hours : {
										format : [ 'HH시' ]
									}
								}
							},
							textStyle : {
								fontSize : 12
							}
						},
						vAxis : {
							minValue : 0.5,
							viewWindow : {
								min : 0
							},
							gridlines : {
								count : -1
							},
							textStyle : {
								fontSize : 12
							}
						},
						animation : {
							startup : true,
							duration : 1000,
							easing : 'in'
						},
						annotations : {
							pattern : chartDateformat,
							textStyle : {
								fontSize : 15,
								bold : true,
								italic : true,
								color : '#871b47',
								auraColor : '#d799ae',
								opacity : 0.8,
								pattern : chartDateformat
							}
						}
					}
				});

				var control = new google.visualization.ControlWrapper({
					controlType : 'ChartRangeFilter',
					containerId : 'controlsArea', //control bar를 생성할 영역
					options : {
						ui : {
							chartType : 'LineChart',
							chartOptions : {
								chartArea : {
									'width' : '60%',
									'height' : 80
								},
								hAxis : {
									'baselineColor' : 'none',
									format : chartDateformat,
									textStyle : {
										fontSize : 12
									},
									gridlines : {
										count : controlLineCount,
										units : {
											years : {
												format : [ 'yyyy년' ]
											},
											months : {
												format : [ 'MM월' ]
											},
											days : {
												format : [ 'dd일' ]
											},
											hours : {
												format : [ 'HH시' ]
											}
										}
									}
								}
							}
						},
						filterColumnIndex : 0
					}
				});

				var date_formatter = new google.visualization.DateFormat({
					pattern : chartDateformat
				});
				date_formatter.format(data, 0);

				var dashboard = new google.visualization.Dashboard(document
						.getElementById('Line_Controls_Chart'));
				window.addEventListener('resize', function() {
					dashboard.draw(data);
				}, false); //화면 크기에 따라 그래프 크기 변경
				dashboard.bind([ control ], [ chart ]);
				dashboard.draw(data);

			}
			 
			google.charts.setOnLoadCallback(drawDashboard);

		}
	}

	$(document).ready(function() {
		google.charts.load('current', {
			'packages' : [ 'line', 'controls']
		});
		chartDrowFun.chartDrow(); //chartDrow() 실행
	});
</script>
</html>