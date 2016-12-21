#chart size global variables
$width = 400; $height=330;
#declare variables
#home page
extension=[]
#page1
version=[]; xmlns=[]; complexType=[]; element=[]; sequence=[]; simpleContent=[]; xsextension=[]; attribute=[]; elementstring=[]; elementshort=[];
elementfloat=[]; attributestring=[]; elementbyte=[]; xsimport=[]; elementref=[]; xschoice=[]; complexContent=[]; annotation=[]; documentation=[];
xsany=[]; xsenumeration=[]; xsanyAttribute=[]; minOccurs0=[]; minOccurs1=[]; maxOccursunbounded=[]; useoptional=[]; userequired=[]; typeanyURI=[];
typebase64Binary=[]; mixedtrue=[]; typeID=[]; processContentslax=[]; namespace=[]; abstracttrue=[]; typedateTime=[]; typeNCName=[]; restriction=[];
attributeGroup=[]; targetNamespace=[]; elementFormDefault=[]; attributeFormDefault=[]; doctype=[];
attlist=[]; entity=[]; basebase64Binary=[]; blockDefaultsubstitution=[]; typedsKeyInfoType=[]; elementrefsamlp=[];

#loop over schema files
Dir.glob("schema/*.xsd").map.with_index do |schema, i|
  #puts schema
  #puts i
  filename = schema.split('/').last
  #puts filename
  file = File.open(schema, 'r'); data = file.read; file.close;
  #puts data
  #build stats
  version         << data.gsub(/(.*<xs:schema.*?version=")(.*?)(">.*<\/xs:schema>)/m,'\2').strip
  #puts version
  xmlns            << [filename, data.scan(/xmlns(=|:)/).size        ]
  complexType      << [filename, data.scan(/<xs:complexType/).size   ]
  element          << [filename, data.scan(/<xs:element/).size       ]
  sequence         << [filename, data.scan(/<xs:sequence/).size      ]
  simpleContent    << [filename, data.scan(/<xs:simpleContent/).size ]
  xsextension      << [filename, data.scan(/<xs:extension/).size     ]
  attribute        << [filename, data.scan(/<xs:attribute/).size     ]
  elementstring    << [filename, data.scan(/<xs:element .*?type="xs:string"/).size]
  elementshort     << [filename, data.scan(/<xs:element type="xs:short"/).size    ]
  elementfloat     << [filename, data.scan(/<xs:element type="xs:float"/).size    ]
  attributestring  << [filename, data.scan(/<xs:attribute type="xs:string"/).size ]
  elementbyte      << [filename, data.scan(/<xs:element type="xs:byte"/).size     ]
  xsimport         << [filename, data.scan(/<xs:import/).size         ]
  elementref       << [filename, data.scan(/<xs:element ref=/).size   ]
  xschoice         << [filename, data.scan(/<xs:choice/).size         ]
  complexContent   << [filename, data.scan(/<xs:complexContent/).size ]
  annotation       << [filename, data.scan(/<xs:annotation/).size     ]
  annotation       << [filename, data.scan(/<xs:annotation/).size     ]
  documentation    << [filename, data.scan(/<xs:documentation/).size  ]
  xsany            << [filename, data.scan(/<xs:any/).size            ]
  xsenumeration    << [filename, data.scan(/<xs:enumeration/).size    ]
  xsanyAttribute   << [filename, data.scan(/<xs:anyAttribute/).size   ]
  minOccurs0       << [filename, data.scan(/minOccurs="0"/).size      ]
  #minOccurs1       << [filename, data.scan(/minOccurs="1"/).size      ]
  maxOccursunbounded << [filename, data.scan(/maxOccurs="unbounded"/).size]
  useoptional      << [filename, data.scan(/use="optional"/).size         ]
  userequired      << [filename, data.scan(/use="required"/).size         ]
  typeanyURI       << [filename, data.scan(/type="anyURI"/).size          ]
  typebase64Binary << [filename, data.scan(/type="base64Binary"/).size    ]
  mixedtrue        << [filename, data.scan(/mixed="true"/).size           ]
  typeID           << [filename, data.scan(/type="ID"/).size              ]
  processContentslax << [filename, data.scan(/processContents="lax"/).size]
  namespace        << [filename, data.scan(/namespace="/).size            ]
  abstracttrue     << [filename, data.scan(/abstract="true"/).size        ]
  typedateTime     << [filename, data.scan(/type="dateTime"/).size        ]
  typeNCName       << [filename, data.scan(/type="NCName"/).size          ]
  restriction      << [filename, data.scan(/<xs:restriction/).size        ]
  attributeGroup   << [filename, data.scan(/<xs:attributeGroup/).size     ]
  targetNamespace  << [filename, data.scan(/targetNamespace/).size        ]
  elementFormDefault << [filename, data.scan(/elementFormDefault/).size   ]
  attributeFormDefault << [filename, data.scan(/attributeFormDefault/).size ]
  doctype << [filename, data.scan(/<!DOCTYPE/).size ]
  attlist << [filename, data.scan(/<!ATTLIST/).size]
  entity << [filename, data.scan(/<!ENTITY/).size ]
  basebase64Binary << [filename, data.scan(/base="base64Binary"/).size ]
  blockDefaultsubstitution << [filename, data.scan(/blockDefault="substitution"/).size ]
  typedsKeyInfoType << [filename, data.scan(/type="ds:KeyInfoType"/).size ]
  elementrefsamlp << [filename, data.scan(/xs:element ref="samlp:/).size ]
end
version = version.group_by{|x| x}.map{|k, v| [k, v.size]}
#puts version
#
def charttitle(charttype)
  "Branch gh-pages count of #{charttype} grouped by file"
end

#page one data structure
v = 'Values'
pageone = [ [version, 'version', 'version count', v, 'Branch count of schema grouped by version', 'version'],
            [xmlns, 'xmlns', 'xmlns count', v, charttitle('xmlns'), 'xmlns'],
            [complexType, 'complexType', 'complexType count', v, charttitle('xs:complexType'), 'complexType'],
            [element, 'element', 'element count', v, charttitle('xs:element'), 'element'],
            [sequence, 'sequence', 'sequence count', v, charttitle('xs:sequence'), 'sequence'],
            [simpleContent, 'simpleContent', 'simpleContent count', v, charttitle('xs:simpleContent'), 'simpleContent'],
            [attributeGroup, 'attributeGroup', 'attributeGroup count', v, charttitle('xs:attributeGroup'), 'attributeGroup'],
            [xsextension, 'extension', 'extension count', v, charttitle('xs:extension'), 'xsextension'],
            [attribute, 'attribute', 'attribute count', v, charttitle('xs:attribute'), 'attribute'],
            [elementstring, 'elementstring', 'element type="xs:string"', v, charttitle('xs:element type="xs:string"'), 'elementstring'],
            [elementshort , 'elementshort', 'xs:element type="xs:short"', v, charttitle('xs:element type="xs:short"'), 'elementshort'],
            [elementfloat, 'elementfloat', 'xs:element type="xs:float"', v, charttitle('xs:element type="xs:float"'), 'elementfloat'],
            [attributestring, 'attributestring', 'xs:attribute type="xs:string"', v, charttitle('xs:attribute type="xs:string"'), 'attributestring'],
            [elementbyte, 'elementbyte', 'xs:element type="xs:byte"', v, charttitle('xs:element type="xs:byte"'), 'elementbyte'],
            [xsimport, 'xsimport', 'xs:import', v, charttitle('xs:import'), 'xsimport'],
            [elementref, 'xselementref', 'xs:element ref=', v, charttitle('xs:element ref='), 'elementref'],
            [xschoice, 'xschoice', 'xs:choice', v, charttitle('xs:choice'), 'xschoice'],
            [complexContent, 'complexContent', 'xs:complexContent', v, charttitle('xs:complexContent'), 'complexContent'],
            [annotation, 'annotation', 'xs:annotation', v, charttitle('xs:annotation'), 'annotation'],
            [documentation, 'documentation', 'xs:documentation', v, charttitle('xs:documentation'), 'documentation'],
            [xsany, 'any', 'xs:any', v, charttitle('xs:any'), 'xsany'],
            [xsenumeration, 'xsenumeration', 'xs:enumeration', v, charttitle('xs:enumeration'), 'xsenumeration'],
            [xsanyAttribute, 'xsanyAttribute', 'xs:anyAttribute', v, charttitle('xs:anyAttribute'), 'xsanyAttribute'],
            [minOccurs0, 'minOccurs0', 'minOccurs="0"', v, charttitle('minOccurs="0"'), 'minOccurs0'],
            #[minOccurs1, 'minOccurs1', 'minOccurs="1"', v, charttitle('minOccurs="1"'), 'minOccurs1'],
            [maxOccursunbounded, 'maxOccursunbounded', 'maxOccurs="unbounded"', v, charttitle('maxOccurs="unbounded"'), 'maxOccursunbounded'],
            [useoptional, 'useoptional', 'use="optional"', v, charttitle('use="optional"'), 'useoptional'],
            [userequired, 'userequired', 'use="required"', v, charttitle('use="required"'), 'userequired'],
            [typeanyURI, 'typeanyURI', 'type="anyURI"', v , charttitle('type="anyURI"'), 'typeanyURI'],
            [typebase64Binary, 'typebase64Binary', 'type="base64Binary"', v, charttitle('type="base64Binary"'), 'typebase64Binary'],
            [mixedtrue, 'mixedtrue', 'mixed="true"', v, charttitle('mixed="true"'), 'mixedtrue'],
            [typeID, 'typeID', 'type="ID"', v, charttitle('type="ID"'), 'typeID'],
            [processContentslax, 'processContentslax', 'processContents="lax"', v, charttitle('processContents="lax"'), 'processContentslax'],
            [namespace, 'namespace', 'namespace="..."', v, charttitle('namespace="..."'), 'namespace'],
            [abstracttrue, 'abstracttrue', 'abstract="true"', v, charttitle('abstract="true"'), 'abstracttrue'],
            [typedateTime, 'typedateTime', 'type="dateTime"', v, charttitle('type="dateTime"'), 'typedateTime'],
            [typeNCName, 'typeNCName', 'type="NCName"', v, charttitle('type="NCName"'), 'typeNCName'],
            [restriction, 'restriction', 'xs:restriction', v, charttitle('xs:restriction'), 'restriction'],
            [targetNamespace, 'targetNamespace', 'targetNamespace', v, charttitle('targetNamespace'), 'targetNamespace'],
            [elementFormDefault, 'elementFormDefault', 'elementFormDefault', v, charttitle('elementFormDefault'), 'elementFormDefault'],
            [attributeFormDefault, 'attributeFormDefault', 'attributeFormDefault', v, charttitle('attributeFormDefault'), 'attributeFormDefault'],
            [doctype, 'doctype', 'doctype', v, charttitle('<!DOCTYPE'), 'doctype'],
            [attlist, 'attlist', 'attlist', v, charttitle('<!ATTLIST'), 'attlist'],
            [entity, 'entity', 'entity', v, charttitle('<!ENTITY'), 'entity'],
            [basebase64Binary, 'basebase64Binary', 'base="base64Binary"', v, charttitle('base="base64Binary"'), 'basebase64Binary'],
            [blockDefaultsubstitution, 'blockDefaultsubstitution', 'blockDefault="substitution"', v, charttitle('blockDefault="substitution"'), 'blockDefaultsubstitution'],
            [typedsKeyInfoType, 'typedsKeyInfoType', 'type="ds:KeyInfoType"', v, charttitle('type="ds:KeyInfoType"')],
            [elementrefsamlp, 'elementrefsamlp', 'element=ref"samlp:', v, charttitle('element=ref"samlp:')]
          ]
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

def drawChart(whichChart, data, chartstring, chartnumber, charttitle, chartdiv)
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
            var chart = new google.visualization.PieChart(document.getElementById('chart_div_#{chartdiv}'));
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
#set the JavaScript Callback
@page  += "
          google.charts.setOnLoadCallback(drawChartAll);\n";
##create JavaScript chart function for home page
@page  += drawChart('All', allFiles, 'Schema count', 'Values', 'Branch gh-pages count of files grouped by file type', 'all')
#set the JavaScript Callback
pageone.map.with_index do |chart, i|
  @page1  += "
          google.charts.setOnLoadCallback(drawChart#{chart[1]});\n";
end
#create JavaScript chart functions for page 1
pageone.map do |chart|
    @page1 += drawChart("#{chart[1]}", chart[0], "#{chart[2]}", "#{chart[3]}", "#{chart[4]}", "#{chart[5]}")
end
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
              <li class=''><a href='index1.html'>Charts</a></li>
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
#
@page1 += "
      <div class='row'>\n"
#add chart divs to page 1
pageone.map do |chart|
  @page1 += "
        <div class='col-sm-6 col-md-4 col-lg-3' id='chart_div_#{chart[5]}'></div>\n"
end
@page1 += "
      </div>"
#finish common page region.
$pagetemp = "
      </div>
      <footer class='footer'>
        <div class='container'>
          <ul class='list-unstyled'>
            <li><a href='#head1'>Back to top</a></li>
            <li><a href='index.html'>Home</a></li>
            <li><a href='index1.html'>Charts</a></li>
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
#write all the HTML pages to files
(0..1).map do |i|
  file = File.open("index#{i > 0 ? i : ''}.html", 'w')
  file.write(instance_variable_get("@page#{i > 0 ? i : ''}"))
  file.close
end
