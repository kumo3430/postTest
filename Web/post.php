<?php
$host = 'localhost'; //数据库主机名
$user = 'kumo'; //数据库用户名
$pass = 'coco3430'; //数据库密码
$db_name = 'test'; //数据库名称

//创建连接对象
$conn = new mysqli($host, $user, $pass, $db_name);

//检查连接是否成功
if ($conn->connect_error) {
    die("连接失败：" . $conn->connect_error);
}

echo "连接成功！";

//关闭连接
$conn->close();
?>
