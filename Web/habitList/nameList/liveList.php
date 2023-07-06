<?php 
// 獲取用戶提交的表單數據
session_start();

$postData = file_get_contents("php://input");
$requestData = json_decode($postData, true);

$_sub_classification = $requestData['_sub_classification'];
$tableName = $requestData['tableName'];
// echo $_sub_classification;


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
    // echo "uid:" . $uid;
} else {
    // 如果不存在，顯示錯誤信息
    echo "無法讀取用戶名";
}

$sql = "SELECT task_name FROM $tableName WHERE uid = '$uid' && _sub_classification ='$_sub_classification' ";

// 使用mysqli_query函式將查詢送往資料庫並執行，並將結果存儲在$result變數
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {

    if ($result->num_rows > 0) {

        $taskNames = array();
        // while($row = $result->fetch_assoc()) {
        while ($row = mysqli_fetch_assoc($result)) {

            $taskNames[] = $row['task_name'];
        }
        $jsonData = json_encode($taskNames);
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

// 關閉與 MySQL 的連接
$conn->close();
?>