import 'package:flutter/foundation.dart';



import 'samples/chart/cartesian_charts/data_source/json.dart';
import 'samples/chart/cartesian_charts/data_source/list.dart';

import 'samples/chart/cartesian_charts/legend/chart_with_customized_legend.dart';
import 'samples/chart/cartesian_charts/legend/legend_various_options.dart';

import 'samples/chart/cartesian_charts/real_time_charts/add_remove_data/add_remove_points.dart';
import 'samples/chart/cartesian_charts/real_time_charts/add_remove_data/add_remove_series.dart';
import 'samples/chart/cartesian_charts/real_time_charts/live_update/real_time_line_chart.dart';
import 'samples/chart/cartesian_charts/real_time_charts/live_update/real_time_spline_chart.dart';
import 'samples/chart/cartesian_charts/real_time_charts/live_update/vertical_live_chart.dart';
import 'samples/chart/cartesian_charts/real_time_charts/update_data_source.dart';

import 'samples/chart/cartesian_charts/technical_indicators/accumulation_distribution.dart';
import 'samples/chart/cartesian_charts/technical_indicators/atr_indicator.dart';
import 'samples/chart/cartesian_charts/technical_indicators/bollinger_indicator.dart';
import 'samples/chart/cartesian_charts/technical_indicators/ema_indicator.dart';
import 'samples/chart/cartesian_charts/technical_indicators/macd_indicator.dart';
import 'samples/chart/cartesian_charts/technical_indicators/momentum_indicator.dart';
import 'samples/chart/cartesian_charts/technical_indicators/rsi_indicator.dart';
import 'samples/chart/cartesian_charts/technical_indicators/sma_indicator.dart';
import 'samples/chart/cartesian_charts/technical_indicators/stochastic_indicator.dart';
import 'samples/chart/cartesian_charts/technical_indicators/tma_indicator.dart';
import 'samples/chart/cartesian_charts/trendline/default_trendline.dart';
import 'samples/chart/cartesian_charts/trendline/trendline_forecast.dart';
import 'samples/chart/cartesian_charts/user_interactions/add_point_on_click.dart';
import 'samples/chart/cartesian_charts/user_interactions/auto_scrolling.dart';
import 'samples/chart/cartesian_charts/user_interactions/crosshair.dart';
import 'samples/chart/cartesian_charts/user_interactions/events/data_point_events.dart';
import 'samples/chart/cartesian_charts/user_interactions/events/events.dart';
import 'samples/chart/cartesian_charts/user_interactions/events/navigation_with_events.dart';
import 'samples/chart/cartesian_charts/user_interactions/pagination.dart';
import 'samples/chart/cartesian_charts/user_interactions/selection/dynamic_selection.dart';
import 'samples/chart/cartesian_charts/user_interactions/selection/selection_modes.dart';
import 'samples/chart/cartesian_charts/user_interactions/tooltip/default_tooltip.dart';
import 'samples/chart/cartesian_charts/user_interactions/tooltip/tooltip_position.dart';
import 'samples/chart/cartesian_charts/user_interactions/tooltip/tooltip_template.dart';
import 'samples/chart/cartesian_charts/user_interactions/trackball/chart_with_trackball.dart';
import 'samples/chart/cartesian_charts/user_interactions/trackball/customized_trackball.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/pinch_zooming.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/selection_zooming.dart';
import 'samples/chart/cartesian_charts/user_interactions/zooming_and_panning/zooming_with_custom_buttons.dart';
import 'samples/chart/circular_charts/chart_types/doughnut/default_doughnut_chart.dart';
import 'samples/chart/circular_charts/chart_types/doughnut/doughnut_with_center_elevation.dart';
import 'samples/chart/circular_charts/chart_types/doughnut/doughnut_with_color_mapping.dart';
import 'samples/chart/circular_charts/chart_types/doughnut/doughnut_with_gradient.dart';
import 'samples/chart/circular_charts/chart_types/doughnut/doughnut_with_rounded_corners.dart';
import 'samples/chart/circular_charts/chart_types/doughnut/semi_doughnut_chart.dart';
import 'samples/chart/circular_charts/chart_types/pie/default_pie_chart.dart';
import 'samples/chart/circular_charts/chart_types/pie/pie_with_gradient.dart';
import 'samples/chart/circular_charts/chart_types/pie/pie_with_grouping.dart';
import 'samples/chart/circular_charts/chart_types/pie/pie_with_image.dart';
import 'samples/chart/circular_charts/chart_types/pie/pie_with_smart_labels.dart';
import 'samples/chart/circular_charts/chart_types/pie/pie_with_various_radius.dart';
import 'samples/chart/circular_charts/chart_types/pie/point_render_mode.dart';
import 'samples/chart/circular_charts/chart_types/pie/semi_pie_chart.dart';
import 'samples/chart/circular_charts/chart_types/radial_bar/customized_radial_bar_chart.dart';
import 'samples/chart/circular_charts/chart_types/radial_bar/default_radial_bar_chart.dart';
import 'samples/chart/circular_charts/chart_types/radial_bar/overfilled_radial_bar.dart';
import 'samples/chart/circular_charts/chart_types/radial_bar/radial_bar_with_gradient.dart';
import 'samples/chart/circular_charts/chart_types/radial_bar/radial_bar_with_legend.dart';
import 'samples/chart/circular_charts/export.dart';
import 'samples/chart/circular_charts/legend/chart_with_legend.dart';
import 'samples/chart/circular_charts/legend/floating_legend.dart';
import 'samples/chart/circular_charts/legend/legend_with_various_options.dart';
import 'samples/chart/circular_charts/user_interactions/dynamic_selection.dart';
import 'samples/chart/circular_charts/user_interactions/selection.dart';
import 'samples/chart/circular_charts/user_interactions/tooltip.dart';

import 'samples/datagrid/apperance/conditional_styling/datagrid_conditional_styling.dart';
import 'samples/datagrid/apperance/styling/datagrid_styling.dart';
import 'samples/datagrid/columns/datagrid_column_types.dart';
import 'samples/datagrid/columns/datagrid_custom_header.dart';
import 'samples/datagrid/columns/datagrid_stacked_header.dart';
import 'samples/datagrid/data_source/datagrid_json_data_source.dart';
import 'samples/datagrid/data_source/datagrid_list_data_source.dart';
import 'samples/datagrid/editing/datagrid_editing.dart';
import 'samples/datagrid/freeze_panes/datagrid_freeze_panes.dart';
import 'samples/datagrid/getting_started/datagrid_getting_started.dart';
import 'samples/datagrid/loadmore/datagrid_infinite_scrolling.dart';
import 'samples/datagrid/loadmore/datagrid_load_more.dart';
import 'samples/datagrid/paging/datagrid_paging.dart';
import 'samples/datagrid/pull_to_refresh/datagrid_pull_to_refresh.dart';
import 'samples/datagrid/real_time_update/datagrid_real_time_update.dart';
import 'samples/datagrid/row_height/datagrid_row_height.dart';
import 'samples/datagrid/selection/datagrid_selection.dart';
import 'samples/datagrid/sorting/datagrid_sorting.dart';
import 'samples/datagrid/swiping/datagrid_swiping.dart';






import 'samples/sliders/range_selector/range_selector_default_appearance.dart';
import 'samples/sliders/range_selector/range_selector_with_bar_chart.dart';
import 'samples/sliders/range_selector/range_selector_with_histogram_chart.dart';
import 'samples/sliders/range_selector/range_selector_with_selection.dart';
import 'samples/sliders/range_selector/range_selector_with_zooming.dart';




/// Contains the output widget of sample
/// appropriate key and output widget mapped
Map<String, Function> getSampleWidget() {
  return <String, Function>{
    // cartesian charts
    




    'default_trendlines_with_options': (Key key) => TrendLineDefault(key),
    'trendline_forecast_with_options': (Key key) => TrendLineForecast(key),

    //Legend
    'chart_with_customized_legend': (Key key) => LegendCustomized(key),
    'chart_with_legend': (Key key) => LegendDefault(key),
    'legend_with_various_options': (Key key) => LegendOptions(key),
    'cartesian_legend_various_options': (Key key) =>
        CartesianLegendOptions(key),
    'circular_floating_legend': (Key key) => CircularFloatingLegend(key),

    //Technical Indicators
    'accumulation_distribution': (Key key) => AdIndicator(key),
    'atr_indicator': (Key key) => ATRIndicator(key),
    'bollinger_indicator': (Key key) => BollingerIndicator(key),
    'ema_indicator': (Key key) => EMAIndicator(key),
    'momentum_indicator': (Key key) => MomentummIndicator(key),
    'rsi_indicator': (Key key) => RSIIndicator(key),
    'sma_indicator': (Key key) => SMAIndicator(key),
    'stochastic_indicator': (Key key) => StochasticcIndicator(key),
    'tma_indicator': (Key key) => TMAIndicator(key),
    'macd_indicator': (Key key) => MACDIndicator(key),

    //User Interaction
    'chart_with_crosshair': (Key key) => DefaultCrossHair(key),
    'selection_modes': (Key key) => DefaultSelection(key),
    'selection_index': (Key key) => SelectionIndex(key),
    'default_tooltip': (Key key) => DefaultTooltip(key),
    'chart_with_trackball': (Key key) => DefaultTrackball(key),
    'chart_with_trackball_template': (Key key) => TrackballTemplate(key),
    'pinch_zooming': (Key key) => DefaultPanning(key),
    'selection_zooming': (Key key) => DefaultZooming(key),
    'zooming_with_custom_buttons': (Key key) => ButtonZooming(key),
    'tooltip_position': (Key key) => CartesianTooltipPosition(key),
    'tooltip_template': (Key key) => TooltipTemplate(key),
    'circular_selection': (Key key) => CircularSelection(key),
    'circular_dynamic_selection': (Key key) => DynamicCircularSelection(key),
    'pie_tooltip_position': (Key key) => PieTooltipPosition(key),
    'events': (Key key) => Events(key),
    'data_points': (Key key) => DataPoints(key),
    'navigate_with_events': (Key key) => NavigationWithEvents(key),
    'chart_interactivity': (Key key) => InteractiveChart(key),
    'pagination': (Key key) => Pagination(key),
    'auto_scrolling': (Key key) => AutoScrollingChart(key),

    //Dynamic updates
    'add_remove_points': (Key key) => AddDataPoints(key),
    'add_remove_series': (Key key) => AddSeries(key),
    'real_time_spline_chart': (Key key) => LiveUpdate(key),
    'vertical_live_chart': (Key key) => VerticalLineLiveUpdate(key),
    'update_data_source': (Key key) => UpdateDataSource(key),
    'real_time_line_chart': (Key key) => LiveLineChart(key),



    //Data binding
    'local_list_data': (Key key) => LocalData(key),
    'local_json_data': (Key key) => JsonData(key),

    //Pie
    'default_pie_chart': (Key key) => PieDefault(key),
    'pie_with_grouping': (Key key) => PieGrouping(key),
    'pie_with_smart_labels': (Key key) => PieSmartLabels(key),
    'pie_with_various_radius': (Key key) => PieRadius(key),
    'semi_pie_chart': (Key key) => SemiPieChart(key),
    'pie_with_gradient': (Key key) => PieGradient(key),
    'pie_with_imageShader': (Key key) => PieImageShader(key),
    'pie_point_render_mode': (Key key) => PiePointRenderMode(key),
    //Doughnut
    'default_doughnut_chart': (Key key) => DoughnutDefault(key),
    'doughnut_with_center_elevation': (Key key) => DoughnutElevation(key),
    'doughnut_with_color_mapping': (Key key) => DoughnutCustomization(key),
    'doughnut_with_rounded_corners': (Key key) => DoughnutRounded(key),
    'semi_doughnut_chart': (Key key) => SemiDoughnutChart(key),
    'doughnut_with_gradient': (Key key) => DoughnutGradient(key),

    //Radialbar
    'customized_radialbar_chart': (Key key) => RadialBarCustomized(key),
    'default_radialbar_chart': (Key key) => RadialBarDefault(key),
    'radialbar_with_legend': (Key key) => RadialBarAngle(key),
    'radialbar_with_gradient': (Key key) => RadialBarGradient(key),
    'overfilled_radialbar': (Key key) => OverfilledRadialBar(key),






   

    // Range Selector Samples
    'range_selector_default_appearance': (Key key) =>
        DefaultRangeSelectorPage(key),

    'range_selector_with_selection': (Key key) =>
        RangeSelectorSelectionPage(key),

    'range_selector_with_zooming': (Key key) => RangeSelectorZoomingPage(key),

    'range_selector_with_histogram_chart': (Key key) =>
        RangeSelectorHistogramChartPage(key),

    'range_selector_with_bar_chart': (Key key) =>
        RangeSelectorBarChartPage(key),

    //dataGridSample
    'getting_started_datagrid': (Key key) => GettingStartedDataGrid(key: key),

    'column_types_datagrid': (Key key) => ColumnTypeDataGrid(key: key),

    'editing_datagrid': (Key key) => EditingDataGrid(key: key),

    'custom_header_datagrid': (Key key) => CustomHeaderDataGrid(key: key),

    'selection_datagrid': (Key key) => SelectionDataGrid(key: key),

    'styling_datagrid': (Key key) => StylingDataGrid(key: key),

    'row_height_datagrid': (Key key) => RowHeightDataGrid(key: key),

    'conditional_styling_datagrid': (Key key) =>
        ConditionalStylingDataGrid(key: key),

    'paging_datagrid': (Key key) => PagingDataGrid(key: key),

    'real_time_update_datagrid': (Key key) => RealTimeUpdateDataGrid(key: key),

    'json_data_source_datagrid': (Key key) => JsonDataSourceDataGrid(key: key),

    'list_data_source_datagrid': (Key key) => ListDataSourceDataGrid(key: key),

    'freeze_panes_datagrid': (Key key) => FreezePanesDataGrid(key: key),

    'sorting_datagrid': (Key key) => SortingDataGrid(key: key),

    'stacked_header_datagrid': (Key key) => StackedHeaderDataGrid(key: key),

    'load_more_infinite_scrolling_datagrid': (Key key) =>
        LoadMoreInfiniteScrollingDataGrid(key: key),

    'load_more_datagrid': (Key key) => LoadMoreDataGrid(key: key),

    'pull_to_refresh_datagrid': (Key key) => PullToRefreshDataGrid(key: key),

    'swiping_datagrid': (Key key) => SwipingDataGrid(key: key),






  };
}
