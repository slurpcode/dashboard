#chart size global variables
$width = 400; $height=330;
#declare variables
extension = []

#integrate cloc stats vai shell command
cloc = `cloc-1.64 . --ignored=ignored.txt --skip-uniqueness --quiet > cloc.txt`
file = File.open('cloc.txt', 'r')
clocdata = file.read
file.close

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
@page0 = ''

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
        <!--Load the AJAX API-->
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
          // Load the Visualization API and the corechart package.
          google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChartAll);
EOS

def drawChart(whichChart, data)
        "
          function drawChart#{whichChart}() {
              // Create the data table.
              var data = new google.visualization.DataTable();
              data.addColumn('string', 'Schema count');
              data.addColumn('number', 'Values');
              data.addRows(#{data});
              // Set chart options
              var options = {'title': 'Branch gh-pages count of files grouped by file type',
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
  @page0 += $pagetemp
end
#
pagebuild

@page0 += drawChart('All', allFiles)

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
@page0 += "
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
      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
      <script src='bootstrap/js/jquery.min.js'></script>
      <!-- Latest compiled and minified JavaScript -->
      <script src='bootstrap/js/bootstrap.min.js'></script>
    </body>
</html>"

#finish building all the pages
pagebuild

#write HTML page to files
file = File.open("index.html", 'w')
file.write(@page0)
file.close
