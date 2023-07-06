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
$quantity = $data['quantity'];
$begin = $data['begin'];
$finish = $data['finish'];
$fulfill = $data['fulfill'];
$_cycle = $data['_cycle'];
$note = $data['note'];
$alert_time = $data['alert_time'];
$show_to_club = $data['show_to_club'];
$completion = $data['completion'];

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

$sql = "INSERT INTO `lives` (`uid`,`set_up_time`, `_classification`, `_sub_classification`, `task_name`, `tag_id1`, `tag_id2`, `quantity`, `begin`, `finish`, `fulfill`, `_cycle`, `note`, `alert_time`, `show_to_club`, `completion`) VALUES ('$uid','$set_up_time', '$_classification' , '$_sub_classification', '$task_name', '$tag_id1', NULL, '$quantity', '$begin', '$finish', NULL, '$_cycle' , '$note', '$alert_time', NULL,NULL)";

// $sql = "INSERT INTO `lives` (`set_up_time`, `_sub_classification`, `task_name`, `tag_id1`, `quantity`, `begin`, `finish`,  `_cycle`, `note`, `alert_time`) VALUES ($set_up_time,  $_sub_classification, $task_name, $tag_id1, $quantity, $begin, $finish, $_cycle , $note, $alert_time)";

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

// $sql2 = "SELECT * FROM `lives` WHERE `task_name` = '$task_name'";

// $result = mysqli_query($conn, $sql2);

// if (mysqli_num_rows($result) > 0) {
//     // 登錄成功
//     // echo "登錄成功";
//     if ($result->num_rows > 0) {
//         // 輸出每行數據
//         while($row = $result->fetch_assoc()) {
//             $sportsData = array(
//                 'id' => $row["id"],
//                 'uid' => $row["uid"],
//                 'set_up_time' => $row["set_up_time"],
//                 '_classification' => $row["_classification"],
//                 'task_name' => $row["task_name"],
//                 'tag_id1' => $row["tag_id1"],
//                 'tag_id2' => $row["tag_id2"],
//                 'quantity' => $row["quantity"],
//                 'begin' => $row["begin"],
//                 'finish' => $row["finish"],
//                 'fulfill' => $row["fulfill"],
//                 '_cycle' => $row["_cycle"],
//                 'note' => $row["note"],
//                 'alert_time' => $row["alert_time"],
//                 'show_to_club' => $row["show_to_club"],
//                 'completion' => $row["completion"]
//             );
//             $jsonData = json_encode($userData);
//             echo $jsonData;

//         }

//     } else {
//         echo "0 個結果";
//     }
// } else {
//     // 登錄失敗
//     http_response_code(404); // 設置HTTP狀態碼為404
//     echo "登錄失敗";
// }

// $result = $conn->query($sql2);
// if ($result->num_rows > 0) {
// // 輸出每行數據
// while($row = $result->fetch_assoc()) {
// echo "<br> id: ". $row["id"]. " - Name: ". $row["username"]. " " ;
// }
// } else {
// echo "0 個結果";
// }

// $userData = array(
//     'username' => $username,
//     'password' => $password
// );

// $jsonData = json_encode($userData);

// // 將JSON字串寫入檔案
// $file = 'user.json';
// file_put_contents($file, $jsonData);


$conn->close();
?>