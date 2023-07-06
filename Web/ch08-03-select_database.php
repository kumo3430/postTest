<html>
<head>
<title>ch08-03</title>
</head>
<body>
<?php
  $db_link = mysqli_connect('localhost', 'kumo','coco3430','phpmember')
             or die("MySQL伺服器連結失敗!<br>");
  $select_db = mysql_select_db("phpmember");
  
  if(!$select_db)
    die("無法開啟資料庫<br>");
  else
    echo "phpmember資料庫開啟成功!";
  mysql_close($db_link);
?>
</body>
</html>