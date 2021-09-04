import 'package:flutter/foundation.dart';



import 'samples/chart/cartesian_charts/data_source/json.dart';
import 'samples/chart/cartesian_charts/data_source/list.dart';





import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/pinch_zooming.dart';

import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_with_custom_buttons.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_total_hour.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id1_1.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id1_2.dart';

import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id2_1.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id2_2.dart';

import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id3_1.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id3_2.dart';


import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id4_1.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id4_2.dart';

import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id5_1.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id5_2.dart';

import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id6_1.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id6_2.dart';

import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id7_1.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_id7_2.dart';

import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_24hour.dart';

import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_aircon1.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_aircon2.dart';

import 'samples/chart/circular_charts/chart_types/pie/default_pie_chart.dart';

import 'store_info.dart';




import 'samples/chart/circular_charts/legend/chart_with_legend.dart';
import 'samples/chart/circular_charts/legend/floating_legend.dart';
import 'samples/chart/circular_charts/legend/legend_with_various_options.dart';










import 'samples/sliders/range_selector/range_selector_with_zooming.dart';




/// Contains the output widget of sample
/// appropriate key and output widget mapped
Map<String, Function> getSampleWidget() {
  return <String, Function>{
    // cartesian charts
    




    //Legend

    'chart_with_legend': (Key key) => LegendDefault(key),
    'legend_with_various_options': (Key key) => LegendOptions(key),

    'circular_floating_legend': (Key key) => CircularFloatingLegend(key),



    //User Interaction

    'pinch_zooming': (Key key) => DefaultPanning(key),

    'zooming_with_custom_buttons': (Key key) => ButtonZooming(key),

    'zooming_total_hour': (Key key) => ButtonZooming2(key),
    'zooming_id1_1': (Key key) => ButtonZooming1_1(key),
    'zooming_id1_2': (Key key) => ButtonZooming1_2(key),


    'zooming_id2_1': (Key key) => ButtonZooming2_1(key),
    'zooming_id2_2': (Key key) => ButtonZooming2_2(key),

    'zooming_id3_1': (Key key) => ButtonZooming3_1(key),
    'zooming_id3_2': (Key key) => ButtonZooming3_2(key),

    'zooming_id4_1': (Key key) => ButtonZooming4_1(key),
    'zooming_id4_2': (Key key) => ButtonZooming4_2(key),

    'zooming_id5_1': (Key key) => ButtonZooming5_1(key),
    'zooming_id5_2': (Key key) => ButtonZooming5_2(key),

    'zooming_id6_1': (Key key) => ButtonZooming6_1(key),
    'zooming_id6_2': (Key key) => ButtonZooming6_2(key),

    'zooming_id7_1': (Key key) => ButtonZooming7_1(key),
    'zooming_id7_2': (Key key) => ButtonZooming7_2(key),

    'zooming_24hour': (Key key) => ButtonZooming24hour(key),

    'zooming_aircon1': (Key key) => AirConditioner1(key),
    'zooming_aircon2': (Key key) => AirConditioner2(key),
    





    //Data binding
    'local_list_data': (Key key) => LocalData(key),
    'local_json_data': (Key key) => JsonData(key),

    //Pie
    'default_pie_chart': (Key key) => PieDefault(key),











   

    // Range Selector Samples
    'range_selector_with_zooming': (Key key) => RangeSelectorZoomingPage(key),



    'store_information': (Key key) => StoreInfo(key),


  };
}
