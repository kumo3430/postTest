<?php 
// 獲取用戶提交的表單數據
session_start();
$postData = file_get_contents("php://input");
$requestData = json_decode($postData, true);

$taskName = $requestData['taskName'];
$tableName = $requestData['tableName'];
// echo $taskName;

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

if (isset($_SESSION['uid'])) {
    // 如果存在，讀取它的值
    // $userName = $_SESSION['uid'];
    $uid = $_SESSION['uid'];

    // echo $uid;

    // echo "uid:" . $uid;
} else {
    // 如果不存在，顯示錯誤信息
    echo "無法讀取用戶名";
}

if (isset($taskName)) {
    // 如果存在，讀取它的值
    // $userName = $_SESSION['uid'];

    // echo $taskName;

    // echo "uid:" . $uid;
} else {
    // 如果不存在，顯示錯誤信息
    echo "無法讀取用戶名";
}


// $sql = "SELECT * FROM lives WHERE task_name = '$taskName' && uid = '$uid' ";
$sql = "SELECT * FROM $tableName WHERE task_name = '$taskName' && uid = '$uid' ";
// $sql = "SELECT * FROM lives WHERE task_name = '$taskName' && uid = '$uid' && _sub_classification = '1' ";


$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    // 登錄成功
    // echo "登錄成功";
    if ($result->num_rows > 0) {
        // 輸出每行數據
        while($row = $result->fetch_assoc()) {

            // 假設 $username 為用戶名，存入 $_SESSION
            // $_SESSION['uid'] = $row['id'];

            $userData = array(
                '_classification' => $row["_classification"],
                '_sub_classification' => $row["_sub_classification"],
                'task_name' => $row["task_name"],
                'begin' => $row["begin"],
                'finish' => $row["finish"],
                'quantity' => $row["quantity"],
                '_cycle' => $row["_cycle"],
                'note' => $row["note"],
                'alert_time' => $row["alert_time"]
            );
            $jsonData = json_encode($userData);
            echo $jsonData;

        }

    } else {
        echo "0 個結果";
    }
} else {
    // 登錄失敗
    http_response_code(404); // 設置HTTP狀態碼為404
    echo "登錄失敗";
}

// 關閉與 MySQL 的連接
$conn->close();
?>