#integrate cloc stats
cloc = `cloc-1.64 . --ignored=ignored.txt --skip-uniqueness --quiet > cloc.txt`
file = File.open('cloc.txt', 'r')
clocdata = file.read
file.close

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
    </head>
    <body>
      <pre>
        <code>
          #{clocdata}
        </code>
      </pre>
      <div class='row'>
        <div class='col-sm-6 col-md-4 col-lg-3'>

        </div>
      </div>

      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
      <script src='bootstrap/js/jquery.min.js'></script>
      <!-- Latest compiled and minified JavaScript -->
      <script src='bootstrap/js/bootstrap.min.js'></script>
    </body>
</html>
EOS

file = File.open("index.html", 'w')
file.write($pagetemp)
file.close
