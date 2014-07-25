function doCharts(analysis_id){
    function drawChart() {
        $.ajax({
            url: '/articles/'+
                analysis_id+
                '/analysis.json',
            method: 'get'
        }).done(function (analysisData) {

            var raw_data_line = [
                ['Date', 'Count']
            ];

            for(key in analysisData){
                date = key;
                count = analysisData[key];
                raw_data_line.push([date,count])
            }

            var line_data = google.visualization.arrayToDataTable(
                raw_data_line
            );

//            options_line.hAxis.gridlines.count=raw_data_line.length;

            var line_chart = new google.visualization.ColumnChart(document.getElementById("chart_div"));

            line_chart.draw(line_data, options_line);

        })
    }
    console.log("do charts working now !!")
}