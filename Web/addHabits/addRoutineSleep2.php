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
$target_time = $data['target_time'];
$fulfill = $data['fulfill'];
$note = $data['note'];
$alert_time = $data['alert_time'];
$alert_time_s = $data['alert_time_s'];
$alert_time_w = $data['alert_time_w'];
$show_to_club = $data['show_to_club'];
$completion = $data['completion'];
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

$sql_j = "SELECT id FROM routine WHERE uid = '$uid'  AND _sub_classification = '$_sub_classification'";

$result = mysqli_query($conn, $sql_j);

if (mysqli_num_rows($result) < 1) {
    // echo "可以新增";
    if ($_sub_classification == "2") {
        $sql = "INSERT INTO `routine` (`uid`,`set_up_time`, `_classification`, `_sub_classification`, `task_name`, `tag_id1`, `tag_id2`,`target_quantity`,`target_time`, `fulfill`, `note`, `alert_time`, `alert_time_w`, `alert_time_s`, `show_to_club`, `completion`) VALUES ('$uid','$set_up_time', '$_classification' , '$_sub_classification', '$task_name', '$tag_id1', NULL, '$target_quantity', NULL, NULL , '$note', NULL, '$alert_time_w', '$alert_time_s', NULL,NULL)";
    
        // $userData = array(
        //     'uid' => $row["uid"],
        //     'set_up_time' => $row["set_up_time"],
        //     '_classification' => $row["_classification"],
        //     '_sub_classification' => $row["_sub_classification"],
        //     'task_name' => $row["task_name"],
        //     'tag_id1' => $row["tag_id1"],
        //     'target_quantity' => $row["target_quantity"],
        //     'note' => $row["note"],
        //     'alert_time_w' => $row["alert_time_w"],
        //     'alert_time_s' => $row["alert_time_s"]
        // );
        if ($conn->query($sql) === TRUE) {
            // 註冊成功，回傳 JSON 格式的訊息
            $userData = array(
                'uid' => $uid,
                'set_up_time' => $set_up_time,
                '_classification' => $_classification,
                '_sub_classification' => $_sub_classification,
                'task_name' => $task_name,
                'tag_id1' => $tag_id1,
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
        $sql = "INSERT INTO `routine` (`uid`,`set_up_time`, `_classification`, `_sub_classification`, `task_name`, `tag_id1`, `tag_id2`,`target_quantity`,`target_time`, `fulfill`, `note`, `alert_time`, `alert_time_w`, `alert_time_s`, `show_to_club`, `completion`) VALUES ('$uid','$set_up_time', '$_classification' , '$_sub_classification', '$task_name', '$tag_id1', NULL, NULL, '$target_time', NULL , '$note', '$alert_time', NULL, NULL, NULL,NULL)";

        // $userData = array(
        //     'uid' => $row["uid"],
        //     'set_up_time' => $row["set_up_time"],
        //     '_classification' => $row["_classification"],
        //     '_sub_classification' => $row["_sub_classification"],
        //     'task_name' => $row["task_name"],
        //     'tag_id1' => $row["tag_id1"],
        //     'target_time' => $row["target_time"],
        //     'note' => $row["note"],
        //     'alert_time' => $row["alert_time"]
        // );
        if ($conn->query($sql) === TRUE) {
            // 註冊成功，回傳 JSON 格式的訊息
            $userData = array(
                'uid' => $uid,
                'set_up_time' => $set_up_time,
                '_classification' => $_classification,
                '_sub_classification' => $_sub_classification,
                'task_name' => $task_name,
                'tag_id1' => $tag_id1,
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
} else if (mysqli_num_rows($result) >= 1) {
    echo "已新增過了";
} 

$conn->close();
?>