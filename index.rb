#!/usr/bin/env ruby

# function
def ii(i)
  i.positive? ? i : ''
end

# chart size variables
width = 400; height = 330;
# declare variables
extension=[]; version=[]; xmlns=[]; complexType=[]; element=[]; sequence=[]; simpleContent=[]; xsextension=[]; attribute=[]; elementstring=[]; elementshort=[];
elementfloat=[]; attributestring=[]; elementbyte=[]; xsimport=[]; elementref=[]; xschoice=[]; complexContent=[]; annotation=[]; documentation=[];
xsany=[]; xsenumeration=[]; xsanyAttribute=[]; minOccurs0=[]; minOccurs1=[]; maxOccursunbounded=[]; useoptional=[]; userequired=[]; typeanyURI=[];
typebase64Binary=[]; mixedtrue=[]; typeID=[]; processContentslax=[]; namespace=[]; abstracttrue=[]; typedateTime=[]; typeNCName=[]; restriction=[];
attributeGroup=[]; targetNamespace=[]; elementFormDefault=[]; attributeFormDefault=[]; doctype=[]; attlist=[]; entity=[]; basebase64Binary=[];
blockDefaultsubstitution=[]; typedsKeyInfoType=[]; elementrefsamlp=[]; elementrefsaml=[]; xmlnsds=[]; xmllangen=[];
# loop over schema files
Dir.glob('schema/*.xsd').map do |schema|
  filename = schema.split('/').last
  file = File.open(schema, 'r'); data = file.read; file.close;
  filename = filename.split('.').first
  version            << data.gsub(/(.*<xs:schema.*?version=")(.*?)(">.*<\/xs:schema>)/m, '\2').strip
  xmlns              << [filename, data.scan(/xmlns[=:]/).size         ]
  xmlnsds            << [filename, data.scan(/xmlns:ds=/).size         ]
  complexType        << [filename, data.scan(/<xs:complexType/).size   ]
  element            << [filename, data.scan(/<xs:element/).size       ]
  sequence           << [filename, data.scan(/<xs:sequence/).size      ]
  simpleContent      << [filename, data.scan(/<xs:simpleContent/).size ]
  xsextension        << [filename, data.scan(/<xs:extension/).size     ]
  attribute          << [filename, data.scan(/<xs:attribute/).size     ]
  elementstring      << [filename, data.scan(/<xs:element .*?type="xs:string"/).size]
  elementshort       << [filename, data.scan(/<xs:element type="xs:short"/).size    ]
  elementfloat       << [filename, data.scan(/<xs:element type="xs:float"/).size    ]
  attributestring    << [filename, data.scan(/<xs:attribute type="xs:string"/).size ]
  elementbyte        << [filename, data.scan(/<xs:element type="xs:byte"/).size     ]
  xsimport           << [filename, data.scan(/<xs:import/).size         ]
  elementref         << [filename, data.scan(/<xs:element ref=/).size   ]
  xschoice           << [filename, data.scan(/<xs:choice/).size         ]
  complexContent     << [filename, data.scan(/<xs:complexContent/).size ]
  annotation         << [filename, data.scan(/<xs:annotation/).size     ]
  documentation      << [filename, data.scan(/<xs:documentation/).size  ]
  xsany              << [filename, data.scan(/<xs:any/).size            ]
  xsenumeration      << [filename, data.scan(/<xs:enumeration/).size    ]
  xsanyAttribute     << [filename, data.scan(/<xs:anyAttribute/).size       ]
  minOccurs0         << [filename, data.scan(/minOccurs="0"/).size          ]
  # minOccurs1       << [filename, data.scan(/minOccurs="1"/).size          ]
  maxOccursunbounded << [filename, data.scan(/maxOccurs="unbounded"/).size  ]
  useoptional        << [filename, data.scan(/use="optional"/).size         ]
  userequired        << [filename, data.scan(/use="required"/).size         ]
  typeanyURI         << [filename, data.scan(/type="anyURI"/).size          ]
  typebase64Binary   << [filename, data.scan(/type="base64Binary"/).size    ]
  mixedtrue          << [filename, data.scan(/mixed="true"/).size           ]
  typeID             << [filename, data.scan(/type="ID"/).size              ]
  processContentslax << [filename, data.scan(/processContents="lax"/).size  ]
  namespace          << [filename, data.scan(/namespace="/).size            ]
  abstracttrue       << [filename, data.scan(/abstract="true"/).size        ]
  typedateTime       << [filename, data.scan(/type="dateTime"/).size        ]
  typeNCName         << [filename, data.scan(/type="NCName"/).size          ]
  restriction        << [filename, data.scan(/<xs:restriction/).size        ]
  attributeGroup     << [filename, data.scan(/<xs:attributeGroup/).size     ]
  targetNamespace    << [filename, data.scan(/targetNamespace/).size        ]
  elementFormDefault << [filename, data.scan(/elementFormDefault/).size     ]
  attributeFormDefault << [filename, data.scan(/attributeFormDefault/).size ]
  doctype                  << [filename, data.scan(/<!DOCTYPE/).size        ]
  attlist                  << [filename, data.scan(/<!ATTLIST/).size        ]
  entity                   << [filename, data.scan(/<!ENTITY/).size         ]
  basebase64Binary         << [filename, data.scan(/base="base64Binary"/).size         ]
  blockDefaultsubstitution << [filename, data.scan(/blockDefault="substitution"/).size ]
  typedsKeyInfoType        << [filename, data.scan(/type="ds:KeyInfoType"/).size       ]
  elementrefsamlp          << [filename, data.scan(/xs:element ref="samlp:/).size      ]
  elementrefsaml           << [filename, data.scan(/<xs:element ref="saml:/).size      ]
end
version = version.group_by{|x| x}.map{|k, v| [k, v.size]}
#
def chart_title(charttype)
  "Branch gh-pages count of #{charttype} grouped by file"
end
# common function to escape double quotes
def escape(s)
  s.gsub('"', '\"')
end
# page one data structure
v = 'Values'
pageone = [ [version, 'version', 'version count', v, 'Branch count of schema grouped by version', 'version'],
            [xmlns, 'xmlns', 'xmlns count', v, chart_title('xmlns'), 'xmlns'],
            [complexType, 'complexType', 'complexType count', v, chart_title('xs:complexType'), 'complexType'],
            [element, 'element', 'element count', v, chart_title('xs:element'), 'element'],
            [sequence, 'sequence', 'sequence count', v, chart_title('xs:sequence'), 'sequence'],
            [simpleContent, 'simpleContent', 'simpleContent count', v, chart_title('xs:simpleContent'), 'simpleContent'],
            [attributeGroup, 'attributeGroup', 'attributeGroup count', v, chart_title('xs:attributeGroup'), 'attributeGroup'],
            [xsextension, 'extension', 'extension count', v, chart_title('xs:extension'), 'xsextension'],
            [attribute, 'attribute', 'attribute count', v, chart_title('xs:attribute'), 'attribute'],
            [elementstring, 'elementstring', 'element type="xs:string"', v, chart_title('xs:element type="xs:string"'), 'elementstring'],
            [elementshort , 'elementshort', 'xs:element type="xs:short"', v, chart_title('xs:element type="xs:short"'), 'elementshort'],
            [elementfloat, 'elementfloat', 'xs:element type="xs:float"', v, chart_title('xs:element type="xs:float"'), 'elementfloat'],
            [attributestring, 'attributestring', 'xs:attribute type="xs:string"', v, chart_title('xs:attribute type="xs:string"'), 'attributestring'],
            [elementbyte, 'elementbyte', 'xs:element type="xs:byte"', v, chart_title('xs:element type="xs:byte"'), 'elementbyte'],
            [xsimport, 'xsimport', 'xs:import', v, chart_title('xs:import'), 'xsimport'],
            [elementref, 'xselementref', 'xs:element ref=', v, chart_title('xs:element ref='), 'elementref'],
            [xschoice, 'xschoice', 'xs:choice', v, chart_title('xs:choice'), 'xschoice'],
            [complexContent, 'complexContent', 'xs:complexContent', v, chart_title('xs:complexContent'), 'complexContent'],
            [annotation, 'annotation', 'xs:annotation', v, chart_title('xs:annotation'), 'annotation'],
            [documentation, 'documentation', 'xs:documentation', v, chart_title('xs:documentation'), 'documentation'],
            [xsany, 'any', 'xs:any', v, chart_title('xs:any'), 'xsany'],
            [xsenumeration, 'xsenumeration', 'xs:enumeration', v, chart_title('xs:enumeration'), 'xsenumeration'],
            [xsanyAttribute, 'xsanyAttribute', 'xs:anyAttribute', v, chart_title('xs:anyAttribute'), 'xsanyAttribute'],
            [minOccurs0, 'minOccurs0', 'minOccurs="0"', v, chart_title('minOccurs="0"'), 'minOccurs0'],
            # [minOccurs1, 'minOccurs1', 'minOccurs="1"', v, chart_title('minOccurs="1"'), 'minOccurs1'],
            [maxOccursunbounded, 'maxOccursunbounded', 'maxOccurs="unbounded"', v, chart_title('maxOccurs="unbounded"'), 'maxOccursunbounded'],
            [useoptional, 'useoptional', 'use="optional"', v, chart_title('use="optional"'), 'useoptional'],
            [userequired, 'userequired', 'use="required"', v, chart_title('use="required"'), 'userequired'],
            [typeanyURI, 'typeanyURI', 'type="anyURI"', v , chart_title('type="anyURI"'), 'typeanyURI'],
            [typebase64Binary, 'typebase64Binary', 'type="base64Binary"', v, chart_title('type="base64Binary"'), 'typebase64Binary'],
            [mixedtrue, 'mixedtrue', 'mixed="true"', v, chart_title('mixed="true"'), 'mixedtrue'],
            [typeID, 'typeID', 'type="ID"', v, chart_title('type="ID"'), 'typeID'],
            [processContentslax, 'processContentslax', 'processContents="lax"', v, chart_title('processContents="lax"'), 'processContentslax'],
            [namespace, 'namespace', 'namespace="..."', v, chart_title('namespace="..."'), 'namespace'],
            [abstracttrue, 'abstracttrue', 'abstract="true"', v, chart_title('abstract="true"'), 'abstracttrue'],
            [typedateTime, 'typedateTime', 'type="dateTime"', v, chart_title('type="dateTime"'), 'typedateTime'],
            [typeNCName, 'typeNCName', 'type="NCName"', v, chart_title('type="NCName"'), 'typeNCName'],
            [restriction, 'restriction', 'xs:restriction', v, chart_title('xs:restriction'), 'restriction'],
            [targetNamespace, 'targetNamespace', 'targetNamespace', v, chart_title('targetNamespace'), 'targetNamespace'],
            [elementFormDefault, 'elementFormDefault', 'elementFormDefault', v, chart_title('elementFormDefault'), 'elementFormDefault'],
            [attributeFormDefault, 'attributeFormDefault', 'attributeFormDefault', v, chart_title('attributeFormDefault'), 'attributeFormDefault'],
            [doctype, 'doctype', 'doctype', v, chart_title('<!DOCTYPE'), 'doctype'],
            [attlist, 'attlist', 'attlist', v, chart_title('<!ATTLIST'), 'attlist'],
            [entity, 'entity', 'entity', v, chart_title('<!ENTITY'), 'entity'],
            [basebase64Binary, 'basebase64Binary', 'base="base64Binary"', v, chart_title('base="base64Binary"'), 'basebase64Binary'],
            [blockDefaultsubstitution, 'blockDefaultsubstitution', 'blockDefault="substitution"', v, chart_title('blockDefault="substitution"'), 'blockDefaultsubstitution'],
            [typedsKeyInfoType, 'typedsKeyInfoType', 'type="ds:KeyInfoType"', v, chart_title('type="ds:KeyInfoType"'), 'typedsKeyInfoType' ],
            [elementrefsamlp, 'elementrefsamlp', '<xs:element ref="samlp:', v, chart_title('<xs:element ref="samlp:'), 'elementrefsamlp'],
            [elementrefsaml, 'elementrefsaml', '<xs:element ref="saml:', v, chart_title('<xs:element ref="saml:'), 'elementrefsaml'],
            [xmlnsds, 'xmlnsds', 'xmlns:ds=', v, chart_title('xmlns:ds='), 'xmlnsds']
          ]
# integrate cloc stats via shell command
`cloc . --ignored=ignored.txt --skip-uniqueness --quiet > cloc.txt`
file = File.open('cloc.txt', 'r')
clocdata = file.read
file.close
# create git log for histogram on homepage
`git log --pretty=format:"%ad" --date=short > log.txt`
file = File.open('log.txt', 'r')
logdata = file.read
file.close
logdata = logdata.lines.group_by{|x| x.strip}.map{|k, v| [k, v.size]}
logdata.unshift(%w[Date Amount])
#
Dir.glob('**/*').map do |x|
  ext = File.extname(x)
  ext = 'folders' if ext == ''
  extension << ext
  # sz = File.size(x)
  # sizes << sz
end
#
allFiles = extension.flatten.group_by{|x| x}.map{|k, v| [k, v.size]}
# Create pages
@page = ''; @page1 = '';
# start common page region
$pagetemp = %(<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other
             head content must come *after* these tags -->
        <title>Analytics Dashboard</title>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <!-- Optional theme -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap-theme.min.css">
        <style>
          h2 { text-align: center; font-size: 19pt; background-color: rgba(49,37,152,0.8);
               color: #fff; border-radius: 1pt 1pt 1pt 1pt; padding: 14px; }
          .container-fluid { padding: 0px; }
          .navbar, .navbar-default { padding: 5pt; background-color: rgba(49,37,152,0.8) !important; color: #fff !important; font-size: 12pt; }
          .navbar-default li:hover { background-color: red !important; font-weight: bold; }
          .navbar, .navbar-default li a { color: #000 !important; }
          .navbar-default .navbar-brand { color: #fff; font-size: 15pt; }
          .navbar-default .navbar-brand:hover, .navbar-default .navbar-brand:focus { color: #fff; }
          div[id^="chart_div"] > div > div { margin: auto; }
         .footer { background-color: rgba(49,37,152,0.8); min-height: 200px; color: #fff !important; }
         .footer ul a { color: #fff !important; }
         .selected { background-color: aliceblue; font-weight: bold; }
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
          google.charts.load("current", {"packages":["corechart"]});)

def draw_chart(which_chart, data, chart_string, chart_number, chart_title, chart_div, width, height)
        %(
          function drawChart#{which_chart}() {
            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn("string", "#{escape(chart_string)}");
            data.addColumn("number", "#{chart_number}");
            data.addRows(#{data});
            // Set chart options
            var options = {"title": "#{escape(chart_title)}",
                           is3D: true,
                           "pieSliceText": "value",
                           "width": #{width},
                           "height": #{height},
                           "titleTextStyle": { "color": "black" } };
            // Instantiate and draw our chart, passing in some options.
            var chart = new google.visualization.PieChart(document.getElementById("chart_div_#{chart_div}"));
            chart.draw(data, options);
          }\n)
end

def draw_chart_histogram(data)
        %(
          function draw_chart_histogram(){
            var data = google.visualization.arrayToDataTable(#{data});
            var options = {
              title: "Histogram of commits by amount",
              legend: { position: "top", maxLines: 2 },
            };
            var chart = new google.visualization.Histogram(document.getElementById("chart_div_hist"));
            chart.draw(data, options);
        }\n)
end

# buld all the website pages
def page_build
  (0..1).map do |i|
    instance_variable_set("@page#{ii i}", instance_variable_get("@page#{ii i}") + $pagetemp)
  end
end
#
page_build
# create JavaScript chart function for home page
# set the JavaScript Callback
@page += "
          google.charts.setOnLoadCallback(drawChartAll);\n"
@page += draw_chart('All', allFiles, 'Schema count', 'Values', 'Branch gh-pages count of files grouped by file type', 'all', width, height)
# histogram
@page += "
          google.charts.setOnLoadCallback(draw_chart_histogram);\n"
@page += draw_chart_histogram(logdata)
# set the JavaScript Callback
pageone.map do |chart|
  @page1 += "
          google.charts.setOnLoadCallback(drawChart#{chart[1]});\n"
end
# create JavaScript chart functions for page 1
pageone.map do |chart|
    @page1 += draw_chart(chart[1], chart[0], chart[2], chart[3], chart[4], chart[5], width, height)
end
# continue common page
$pagetemp = %(
      </script>
    </head>
    <body>
      <!-- Static navbar -->
      <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              </button>
            <a class="navbar-brand" href="#" id="head1">Analytics Dashboard</a>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="index.html">Home</a></li>
              <li><a href="index1.html">Charts</a></li>
            </ul>
          </div>
        </div>
      </nav>
      <div class="container-fluid">\n)
page_build
# homepage
@page += %(
      <h2>Featured Statistics</h2>
      <pre>
        <code>
          #{clocdata}
        </code>
      </pre>
      <div class="row">
        <div class="col-sm-6 col-md-4 col-lg-3" id="chart_div_all"></div>
        <div class="col-sm-6 col-md-4 col-lg-3" id="chart_div_hist" style="width: 600px; height: 400px;"></div>
      </div>\n)
#
@page1 += %(
      <div class="row">\n)
# add chart divs to page 1
pageone.map do |chart|
  @page1 += %(
        <div class="col-sm-6 col-md-4 col-lg-3" id="chart_div_#{chart[5]}"></div>\n)
end
@page1 += '
      </div>'
# finish common page region.
$pagetemp = %(
      </div>
      <footer class="footer">
        <div class="container">
          <ul class="list-unstyled">
            <li>
              <a class="github-button" href="https://github.com/jbampton" data-size="large" data-show-count="true" aria-label="Follow @jbampton on GitHub">Follow @jbampton</a>
            </li>
            <li>
              <a class="github-button" href="https://github.com/jbampton/dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star jbampton/dashboard on GitHub">Star</a>
            </li>
            <li><a href="#head1">Back to top</a></li>
            <li><a href="index.html">Home</a></li>
            <li><a href="index1.html">Charts</a></li>
            <li class="nuchecker"><a target="_blank" rel="noopener">Valid HTML</a></li>
          </ul>
        </div>
      </footer>
      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
      <script src="bootstrap/js/jquery.min.js"></script>
      <!-- Latest compiled and minified JavaScript -->
      <script src="bootstrap/js/bootstrap.min.js"></script>
      <script>
        $(document).ready(function () {
           "use strict";
           var last = $(location).attr("href").split("/").pop().split(".")[0].replace(/index/, "");
           var tab = 1;
           if (last !== "") {
             tab = parseInt(last) + 1;
           }
           $(".navbar-nav li:nth-child(" + tab + ")").addClass("selected");
           tab--;
           if (tab === 0) {
             tab = "";
           }
           $(".nuchecker a").attr("href", "https://validator.w3.org/nu/?doc=http%3A%2F%2Fthebeast.me%2Fdashboard%2Findex" + tab + ".html");
        });
      </script>
      <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
</html>)
# finish building all the pages
page_build
# write all the HTML pages to files
(0..1).map do |i|
  file = File.open("index#{ii i}.html", 'w')
  file.write(instance_variable_get("@page#{ii i}"))
  file.close
end
