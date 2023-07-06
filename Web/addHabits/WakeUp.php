<?php
// include('login3.php');
session_start();
// 從 $_SESSION 中獲取用戶名
$uid = $_SESSION['uid'];

// 獲取用戶提交的表單數據
$input_data = file_get_contents("php://input");
$data = json_decode($input_data, true);

// 取得用戶名和密碼
$set_date = $data['set_date'];
$set_time = $data['set_time'];
$set_up_time = $data['set_up_time'];
// $_sub_classification = 2 ;

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

$tableName = $_SESSION['tableName'];
$rid = $_SESSION['rid'];

$today = date("Y-m-d");
// echo $today;
$sqlJudge = "SELECT * FROM `$tableName` WHERE set_date = '$today';";
// $sqlJudge = "SELECT * FROM WakeUpR25 WHERE set_date = '$today';";

$result = $conn->query($sqlJudge);
// $count = $result->num_rows;
// echo $count;
// echo "result : " . $result;
if ($result->num_rows > 0) {
    $response = array('message' => "you had built");
    echo json_encode($response);
    // echo "you had built";
} else {
    $sqlNew = "INSERT INTO `$tableName` (`rid`, `set_date`, `set_time`, `set_up_time`) VALUES ('$rid', '$set_date' , '$set_time', '$set_up_time')";

    if(!$sqlNew){
        echo mysql_error();  
      }
    
    if ($conn->query($sqlNew) === TRUE) {
        // 註冊成功，回傳 JSON 格式的訊息
        $response = array('message' => "I woke up.");
        // $response = array('message' => 'User registered successfully.', 'username' => $username);
        echo json_encode($response);
    } else {
        // 註冊失敗，回傳 JSON 格式的錯誤訊息
        $response = array('message' => 'Error: ' . $sql . '<br>' . $conn->error);
        echo json_encode($response);
    }
}

// $sqlNew = "INSERT INTO `$tableName` (`rid`, `set_date`, `set_time`, `set_up_time`) VALUES ('$rid', '$set_date' , '$set_time', '$set_up_time')";

// if(!$sqlNew){
//     echo mysql_error();  
//   }

// if ($conn->query($sqlNew) === TRUE) {
//     // 註冊成功，回傳 JSON 格式的訊息
//     $response = array('message' => "I woke up.");
//     // $response = array('message' => 'User registered successfully.', 'username' => $username);
//     echo json_encode($response);
// } else {
//     // 註冊失敗，回傳 JSON 格式的錯誤訊息
//     $response = array('message' => 'Error: ' . $sql . '<br>' . $conn->error);
//     echo json_encode($response);
// }

$conn->close();
?>