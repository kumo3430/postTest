<?php
// include('login3.php');
session_start();
// 從 $_SESSION 中獲取用戶名
$uid = $_SESSION['uid'];

// 獲取用戶提交的表單數據
$input_data = file_get_contents("php://input");
$data = json_decode($input_data, true);

// 取得用戶名和密碼
// $set_date = $data['set_date'];
// $set_time = $data['set_time'];
// $set_up_time = $data['set_up_time'];
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

// $rid_query = "SELECT id FROM routine WHERE uid = '$uid' AND _sub_classification = '$_sub_classification' ";
// $rid_result = $conn->query($rid_query);
// $rid = $rid_result->fetch_assoc()['id'];

// $tableName = "WakeUpR".$rid;
// // 检查 SleepR22 表是否存在
// $tableExists = false;

// $result = $conn->query("SELECT 1 FROM information_schema.tables WHERE table_schema = 'test' AND table_name = '$tableName'");
// if ($result->num_rows > 0) {
//     $tableExists = true;
// }

// if (!$tableExists) {
//     $sqlCreate = "CREATE TABLE $tableName (
//         id INT(2) PRIMARY KEY AUTO_INCREMENT,
//         rid INT(2),
//         set_time TIME,
//         set_date DATE,
//         set_up_time DATETIME,
//         FOREIGN KEY (`rid`) REFERENCES `routine`(`id`)
//         )";

//     if ($conn->query($sqlCreate) === true) {
//         $response = array('message' => "Table" . $tableName . "created successfully");
//         echo json_encode($response);
//         // echo "Table" . $tableName . "created successfully";
//     } else {
//         $response = array('message' => "Error creating table: " . $conn->error);
//         echo json_encode($response);
//         // echo "Error creating table: " . $conn->error;
//     }
// }

// $sqlLog = "INSERT INTO `$tableName` (`rid`, `set_date`, `set_time`, `set_up_time`) VALUES ('$rid', '$set_date' , '$set_time', '$set_up_time')";

// if(!$sqlLog){
//     echo mysql_error();  
//   }

// if ($conn->query($sqlLog) === TRUE) {
//     // 註冊成功，回傳 JSON 格式的訊息
//     $response = array('message' => "I woke up.");
//     // $response = array('message' => 'User registered successfully.', 'username' => $username);
//     echo json_encode($response);
// } else {
//     // 註冊失敗，回傳 JSON 格式的錯誤訊息
//     $response = array('message' => 'Error: ' . $sql . '<br>' . $conn->error);
//     echo json_encode($response);
// }
$tableName = $_SESSION['tableName'];

// $sqlLog = "SELECT set_up_time FROM $tableName";
$sqlLog = "SELECT set_up_time FROM $tableName ORDER BY set_up_time DESC";

// 使用mysqli_query函式將查詢送往資料庫並執行，並將結果存儲在$result變數
$result = mysqli_query($conn, $sqlLog);

if (mysqli_num_rows($result) > 0) {

    if ($result->num_rows > 0) {

        $set_up_time = array();
        // while($row = $result->fetch_assoc()) {
        while ($row = mysqli_fetch_assoc($result)) {

            $set_up_time[] = $row['set_up_time'];
        }
        $jsonData = json_encode($set_up_time);
        echo $jsonData;

        // while ($row = mysqli_fetch_assoc($result)) {
        //     $userData = array(
        //         'taskName' => $row['task_name']
        //     );
        // }
        // $jsonData = json_encode($userData);
        // echo $jsonData;

    } else {
        // echo "0 個結果"; ???
    }
} else {
    // 登錄失敗
    // http_response_code(404); // 設置HTTP狀態碼為404
    // echo "0 個結果"; ???
}


$conn->close();
?>