#chart size global variables
$width = 400; $height=330;
#declare variables
extension = []

#integrate cloc stats vai shell command
cloc = `cloc-1.64 . --ignored=ignored.txt --skip-uniqueness --quiet > cloc.txt`
file = File.open('cloc.txt', 'r')
clocdata = file.read
file.close
#
Dir.glob("**/*").map do |x|
  ext = File.extname(x)
  if ext == ''
    ext = 'folders'
  end
  extension << ext
  #sz = File.size(x)
  #sizes << sz
end

#
allFiles = extension.flatten.group_by{|x| x}.map{|k, v| [k, v.size]}

#Create pages
@page=''; @page1='';

#start common page region
$pagetemp = <<-EOS
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other
             head content must come *after* these tags -->
        <title>Analytics Dashboard</title>
        <!-- Latest compiled and minified CSS -->
        <link rel='stylesheet' href='bootstrap/css/bootstrap.min.css'>
        <!-- Optional theme -->
        <link rel='stylesheet' href='bootstrap/css/bootstrap-theme.min.css'>
        <style>
          h2 { text-align: center; font-size: 19pt; background-color: rgba(49,37,152,0.8);
               color: #fff; border-radius: 1pt 1pt 1pt 1pt; padding: 14px; }

          .container-fluid { padding: 0px; }

          .navbar, .navbar-default { padding: 5pt; background-color: rgba(49,37,152,0.8) !important;
             color: #fff !important; font-size: 12pt; border-color: #none !important; }

          .navbar, .navbar-default li hover { color: #fff !important; }

          .navbar, .navbar-default li a { color: #000000 !important; }

          .navbar-default .navbar-brand { color: #fff; font-size: 15pt; }

          .navbar-default .navbar-nav > .active > a,
          .navbar-default .navbar-nav > .active > a:hover,
          .navbar-default .navbar-nav > .active > a:focus {
            background-color: transparent !important; }

          .navbar-default .navbar-nav > .open > a,
          .navbar-default .navbar-nav > .open > a:focus,
          .navbar-default .navbar-nav > .open > a:hover {
          	color: #555; background-color: #ff0000; font-weight: bold; }

          .navbar-default .navbar-brand:hover,
          .navbar-default .navbar-brand:focus {
            color: #fff; background-color: transparent; }

          .navbar-default .navbar-text { color: #000; }

          .nav { padding-right: 300px; }

          .dropdown-menu > li > a { display: block; padding: 3px 20px; clear: both;
            font-weight: 600; line-height: 1.42857143; color: #333; white-space: nowrap; }

          div[id^="chart_div"] > div > div { margin: auto; }

          .chartNumber { color: purple; font-size: 22pt; }

          .overview { font-size: 14pt;  }

         .footer { background-color: rgba(49,37,152,0.8);
           min-height: 200px; color: #fff !important; }

         .footer ul a { color: #fff !important; }

         pre { white-space: pre-wrap; //css3
             white-space: moz-pre-wrap; //firefox
             white-space: -pre-wrap; //opera 4-6
             white-space: -o-pre-wrap; //opera 7
             word-wrap: break-word; //internet explorer
         }
        </style>
        <!--Load the AJAX API-->
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
          // Load the Visualization API and the corechart package.
          google.charts.load('current', {'packages':['corechart']});
EOS

def drawChart(whichChart, data, chartstring, chartnumber, charttitle)
        "
          function drawChart#{whichChart}() {
            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('string', '#{chartstring}');
            data.addColumn('number', '#{chartnumber}');
            data.addRows(#{data});
            // Set chart options
            var options = {'title': '#{charttitle}',
                           is3D: true,
                           'width': #{$width},
                           'height': #{$height},
                           'titleTextStyle': { 'color': 'black' } };
            // Instantiate and draw our chart, passing in some options.
            var chart = new google.visualization.PieChart(document.getElementById('chart_div_all'));
            chart.draw(data, options);
          }\n"
end

#buld all the website pages
def pagebuild
  (0..1).map do |i|
    instance_variable_set("@page#{i > 0 ? i : ''}", instance_variable_get("@page#{i > 0 ? i : ''}") + $pagetemp)
  end
end
#
pagebuild

@page += "
          google.charts.setOnLoadCallback(drawChartAll);\n";

@page += drawChart('All', allFiles, 'Schema count', 'Values', 'Branch gh-pages count of files grouped by file type')

#continue common page
$pagetemp = "
      </script>
    </head>
    <body>
      <!-- Static navbar -->
      <nav class='navbar navbar-default'>
        <div class='container-fluid'>
          <div class='navbar-header'>
            <button type='button' class='navbar-toggle collapsed' data-toggle='collapse' data-target='#navbar' aria-expanded='false' aria-controls='navbar'>
              <span class='sr-only'>Toggle navigation</span>
              <span class='icon-bar'></span>
              <span class='icon-bar'></span>
              <span class='icon-bar'></span>
              </button>
            <a class='navbar-brand' href='#' id='head1'>Analytics Dashboard</a>
          </div>
          <div id='navbar' class='navbar-collapse collapse'>
            <ul class='nav navbar-nav'>
              <li class=''><a href='index.html'>Home</a></li>
              <li class=''><a href='index1.html'>Page 2</a></li>
            </ul>
          </div>
        </div>
      </nav>
      <div class='container-fluid'>\n"


=begin
      <div class='row'>
        <div class='col-sm-6 col-md-4 col-lg-3'>

        </div>
      </div>
=end
pagebuild

#homepage
@page += "
      <h2>Featured Statistics</h2>
      <pre>
        <code>
          #{clocdata}
        </code>
      </pre>
      <div class='row'>
        <div class='col-sm-6 col-md-4 col-lg-3' id='chart_div_all'></div>
      </div>\n"

#finish common page region.
$pagetemp = "
      </div>
      <footer class='footer'>
        <div class='container'>
          <ul class='list-unstyled'>
            <li><a href='#head1'>Back to top</a></li>
            <li><a href='index.html'>Home</a></li>
            <li><a href='index1.html'>Page 2</a></li>
          </ul>
        </div>
      </footer>
      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
      <script src='bootstrap/js/jquery.min.js'></script>
      <!-- Latest compiled and minified JavaScript -->
      <script src='bootstrap/js/bootstrap.min.js'></script>
    </body>
</html>"

#finish building all the pages
pagebuild

#write HTML page to files
#write all the HTML pages to files
(0..1).map do |i|
  file = File.open("index#{i > 0 ? i : ''}.html", 'w')
  file.write(instance_variable_get("@page#{i > 0 ? i : ''}"))
  file.close
end