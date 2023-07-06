<?php 
// include('login3.php');
session_start();
// 從 $_SESSION 中獲取用戶名
$uid = $_SESSION['uid'];

$postData = file_get_contents("php://input");
$requestData = json_decode($postData, true);

// 檢查用戶名和密碼是否合法
// if (empty($requestData['username']) || empty($requestData['password'])) {
//     echo "請輸入用戶名和密碼";
//     exit;
// }
$_sub_classification = $data['_sub_classification'];

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

$sql = "SELECT task_name FROM diet WHERE uid = '$uid' AND _sub_classification ='$_sub_classification'";
// $sql = "SELECT * FROM users WHERE username='7PP' AND password='7PP'";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    $task_names = array();
    while($row = $result->fetch_assoc()) {
        $task_names[] = $row["task_name"];
    }
    echo json_encode($task_names);
} else {
    http_response_code(404);
    echo "登錄失敗";
}

$conn->close();
?>