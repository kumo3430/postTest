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

// 取得用戶名和密碼
$revise_time = $data['revise_time'];
$task_name = $data['task_name'];
$target_time = $data['target_time'];
$note = $data['note'];
$alert_time = $data['alert_time'];
$alert_time_s = $data['alert_time_s'];
$alert_time_w = $data['alert_time_w'];
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

// $sql_j = "SELECT id FROM routine WHERE uid = '$uid'  AND _sub_classification = '$_sub_classification'";

// $result = mysqli_query($conn, $sql_j);

if ($_sub_classification == "2") {
    $sql = "UPDATE `routine` SET `revise_time` = '$revise_time',`task_name` = '$task_name',`target_quantity` = '$target_quantity', `note` = '$note',`alert_time_w` = '$alert_time_w', `alert_time_s` = '$alert_time_s' WHERE id = $rid ";
    
    // (`revise_time`, `task_name`,`target_quantity`, `note`, `alert_time_w`, `alert_time_s`) VALUES ('$revise_time', '$task_name', '$target_quantity' , '$note', '$alert_time_w', '$alert_time_s')";

    if ($conn->query($sql) === TRUE) {
        // 註冊成功，回傳 JSON 格式的訊息
        $userData = array(
            'revise_time' => $revise_time,
            'task_name' => $task_name,
            'target_quantity' => $target_quantity,
            'note' => $note,
            'alert_time_w' => $alert_time_w,
            'alert_time_s' => $alert_time_s
        );
        $jsonData = json_encode($userData);
        echo $jsonData;
    } else {
        // 註冊失敗，回傳 JSON 格式的錯誤訊息
        $response = array('message' => 'Error: ' . $sql . '<br>' . $conn->error);
        echo json_encode($response);
    }
    
} else {
    $sql = "UPDATE `routine` SET `revise_time` = '$revise_time',`task_name` = '$task_name',`target_time` = '$target_time', `note` = '$note', `alert_time` = '$alert_time' WHERE id =`$rid`";
    // $sql = "UPDATE `routine` SET (`revise_time`, `task_name`,`target_time`, `note`, `alert_time`) VALUES ('$revise_time', '$task_name', '$target_time' , '$note', '$alert_time')";
echo $rid;
    if ($conn->query($sql) === TRUE) {
        // 註冊成功，回傳 JSON 格式的訊息
        $userData = array(
            'revise_time' => $revise_time,
            'task_name' => $task_name,
            'target_time' => $target_time,
            'note' => $note,
            'alert_time' => $alert_time
        );
        $jsonData = json_encode($userData);
        echo $jsonData;
    } else {
        // 註冊失敗，回傳 JSON 格式的錯誤訊息
        $response = array('message' => 'Error: ' . $sql . '<br>' . $conn->error);
        echo json_encode($response);
    }
}

// if (mysqli_num_rows($result) < 1) {
//     // echo "可以新增";
    
// } else if (mysqli_num_rows($result) >= 1) {
//     echo "已新增過了";
// } 

$conn->close();
?>