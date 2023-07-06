<?php
// include('login3.php');
session_start();
// 從 $_SESSION 中獲取用戶名
$uid = $_SESSION['uid'];

// 獲取用戶提交的表單數據
$input_data = file_get_contents("php://input");
$data = json_decode($input_data, true);

// 取得用戶名和密碼
// $classification = $data['classification'];
// $set_date = $data['set_date'];
// $set_time = $data['set_time'];
// $set_up_time = $data['set_up_time'];
$_sub_classification = $data['_sub_classification'] ;

$servername = "localhost"; // 資料庫伺服器名稱
$user = "kumo"; // 資料庫使用者名稱
$pass = "coco3430"; // 資料庫使用者密碼
$dbname = "test"; // 資料庫名稱

// 建立與 MySQL 資料庫的連接
$conn = new mysqli($servername, $user, $pass, $dbname);

// 檢查連接是否成功
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// 把所查詢的的結果（id的值）抓取出來另存
// $sql = "SELECT COUNT(id) AS result_count FROM routine WHERE uid = '$uid'  AND _sub_classification = '$_sub_classification' ";

// $sql = "SELECT id FROM routine WHERE uid = '8' AND _sub_classification = 2";
$sql = "SELECT id FROM routine WHERE uid = '$uid'  AND _sub_classification = '$_sub_classification' ";

$result = mysqli_query($conn, $sql);

$num = mysqli_num_rows($result);
// echo json_encode($num);
echo ($num);
// var_dump($num);

$conn->close();
?>