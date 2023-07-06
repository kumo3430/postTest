<?php
// include('login3.php');
session_start();
// 從 $_SESSION 中獲取用戶名
$uid = $_SESSION['uid'];

// 獲取用戶提交的表單數據
$input_data = file_get_contents("php://input");
$data = json_decode($input_data, true);

// 取得用戶名和密碼
$set_up_time = $data['set_up_time'];
$_classification = $data['_classification'];
$_sub_classification = $data['_sub_classification'];
$task_name = $data['task_name'];
$tag_id1 = $data['tag_id1'];
$tag_id2 = $data['tag_id2'];
$fulfill = $data['fulfill'];
$_cycle = $data['_cycle'];
$note = $data['note'];
$alert_time = $data['alert_time'];
$show_to_club = $data['show_to_club'];
$completion = $data['completion'];

$target = $data['target'];
$target_quantity = $data['target_quantity'];

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

$sql = "INSERT INTO `diet` (`uid`,`set_up_time`, `_classification`, `_sub_classification`, `task_name`, `tag_id1`, `tag_id2`,`target`,`target_quantity`, `fulfill`, `note`, `alert_time`, `show_to_club`, `completion`) VALUES ('$uid','$set_up_time', '$_classification' , '$_sub_classification', '$task_name', '$tag_id1', NULL, '$target', '$target_quantity', NULL, '$note', '$alert_time', NULL,NULL)";

if ($conn->query($sql) === TRUE) {
    // 註冊成功，回傳 JSON 格式的訊息
    $response = array('message' => 'User registered successfully.');
    // $response = array('message' => 'User registered successfully.', 'username' => $username);
    echo json_encode($response);
} else {
    // 註冊失敗，回傳 JSON 格式的錯誤訊息
    $response = array('message' => 'Error: ' . $sql . '<br>' . $conn->error);
    echo json_encode($response);
}

$conn->close();
?>