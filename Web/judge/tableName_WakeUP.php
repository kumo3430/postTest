<?php
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
$_sub_classification = 2 ; // X
//$_sub_classification = 1 ; // O

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

$rid_query = "SELECT id FROM routine WHERE uid = '$uid' AND _sub_classification = '$_sub_classification' ";
$rid_result = $conn->query($rid_query);
$rid = $rid_result->fetch_assoc()['id'];

$tableName = "WakeUpR".$rid;
$_SESSION['tableName'] = $tableName;
$_SESSION['rid'] = $rid;

$response = array('message' => "$tableName");
echo json_encode($response);

$tableExists = false;
// 檢查資料表示粉存在，如果不存在就新增一個
$result = $conn->query("SELECT 1 FROM information_schema.tables WHERE table_schema = 'test' AND table_name = '$tableName'");
if ($result->num_rows > 0) {
    $tableExists = true;
}

if (!$tableExists) {
    $sqlCreate = "CREATE TABLE $tableName (
        id INT(2) PRIMARY KEY AUTO_INCREMENT,
        rid INT(2),
        set_time TIME,
        set_date DATE,
        set_up_time DATETIME,
        FOREIGN KEY (`rid`) REFERENCES `routine`(`id`)
        )";

    if ($conn->query($sqlCreate) === true) {
        $response = array('message' => "Table" . $tableName . "created successfully");
        echo json_encode($response);
        // echo "Table" . $tableName . "created successfully";
    } else {
        $response = array('message' => "Error creating table: " . $conn->error);
        echo json_encode($response);
        // echo "Error creating table: " . $conn->error;
    }
}

?>