<?php
// include('login3.php');
session_start();
// 從 $_SESSION 中獲取用戶名
$uid = $_SESSION['uid'];

// 獲取用戶提交的表單數據
$input_data = file_get_contents("php://input");
$data = json_decode($input_data, true);

// 取得用戶名和密碼
$classification = $data['classification'];
$set_date = $data['set_date'];
$set_time = $data['set_time'];
$set_up_time = $data['set_up_time'];
$_sub_classification = 2 ;

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
$rid_query = "SELECT id FROM routine WHERE uid = '$uid' AND _sub_classification = '$_sub_classification' ";
$rid_result = $conn->query($rid_query);
$rid = $rid_result->fetch_assoc()['id'];

$sql = "INSERT INTO `SleepInterval` (`rid`,`classification`, `set_date`, `set_time`, `set_up_time`) VALUES ('$rid','$classification', '$set_date' , '$set_time', '$set_up_time')";

if(!$sql){
    echo mysql_error();  
  }

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