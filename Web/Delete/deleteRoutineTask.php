<?php
// include('login3.php');
session_start();
// 從 $_SESSION 中獲取用戶名
$uid = $_SESSION['uid'];
$_sub_classification = $_SESSION['_sub_classification'];
$rid = $_SESSION['rid'];
// 獲取用戶提交的表單數據
$input_data = file_get_contents("php://input");
$data = json_decode($input_data, true);

$servername = "localhost"; // 資料庫伺服器名稱
$user = "kumo"; // 資料庫使用者名稱
$pass = "coco3430"; // 資料庫使用者密碼
$dbname = "test"; // 資料庫名稱

// 建立與 MySQL 資料庫的連接
$conn = new mysqli($servername, $user, $pass, $dbname);

// print_r($data);

// 檢查連接是否成功
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// $sql_j = "SELECT id FROM routine WHERE uid = '$uid'  AND _sub_classification = '$_sub_classification'";

// $result = mysqli_query($conn, $sql_j);
$sql = "DELETE FROM `routine` WHERE id = $rid ";
if ($conn->query($sql) === TRUE) {
    // 註冊成功，回傳 JSON 格式的訊息
    $userData = array(
        'messenge' => "Successfully deleted this habit."
    );
    $jsonData = json_encode($userData);
    echo $jsonData;
} else {
    // 註冊失敗，回傳 JSON 格式的錯誤訊息
    $response = array('message' => 'Error: ' . $sql . '<br>' . $conn->error);
    echo json_encode($response);
}

$conn->close();
?>