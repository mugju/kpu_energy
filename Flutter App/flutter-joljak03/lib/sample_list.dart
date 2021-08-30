import 'package:flutter/foundation.dart';



import 'samples/chart/cartesian_charts/data_source/json.dart';
import 'samples/chart/cartesian_charts/data_source/list.dart';





import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/pinch_zooming.dart';

import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_with_custom_buttons.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_total_hour.dart';

import 'samples/chart/circular_charts/chart_types/pie/default_pie_chart.dart';




import 'samples/chart/circular_charts/legend/chart_with_legend.dart';
import 'samples/chart/circular_charts/legend/floating_legend.dart';
import 'samples/chart/circular_charts/legend/legend_with_various_options.dart';



import 'samples/datagrid/apperance/styling/datagrid_styling.dart';






import 'samples/datagrid/row_height/datagrid_row_height.dart';






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








    //Data binding
    'local_list_data': (Key key) => LocalData(key),
    'local_json_data': (Key key) => JsonData(key),

    //Pie
    'default_pie_chart': (Key key) => PieDefault(key),











   

    // Range Selector Samples
    'range_selector_with_zooming': (Key key) => RangeSelectorZoomingPage(key),


    //dataGridSample


    'styling_datagrid': (Key key) => StylingDataGrid(key: key),

    'row_height_datagrid': (Key key) => RowHeightDataGrid(key: key),
















  };
}
