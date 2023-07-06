<?php
// 獲取用戶提交的表單數據
$input_data = file_get_contents("php://input");
$data = json_decode($input_data, true);

// 取得用戶名和密碼
$username = $data['username'];
$password = $data['password'];

// 檢查用戶名和密碼是否合法
if (empty($username) || empty($password)) {
    echo "請輸入用戶名和密碼";
    exit;
}

$servername = "localhost"; // 資料庫伺服器名稱
$user = "kumo"; // 資料庫使用者名稱
$pass = "coco3430"; // 資料庫使用者密碼
$dbname = "test"; // 資料庫名稱

// 建立與 MySQL 資料庫的連接
$conn = new mysqli($servername, $user, $pass, $dbname);

print_r($data);

// 檢查連接是否成功
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO users (username, password) VALUES ('$username', '$password')";
if ($conn->query($sql) === TRUE) {
    // 註冊成功，回傳 JSON 格式的訊息
    // $response = array('message' => 'User registered successfully.');
    $response = array('message' => 'User registered successfully.', 'username' => $username);
    echo json_encode($response);
} else {
    // 註冊失敗，回傳 JSON 格式的錯誤訊息
    $response = array('message' => 'Error: ' . $sql . '<br>' . $conn->error);
    echo json_encode($response);
}

$sql2 = "SELECT * FROM `users` WHERE `username` = '$username'";
$result = $conn->query($sql2);
if ($result->num_rows > 0) {
// 輸出每行數據
while($row = $result->fetch_assoc()) {
echo "<br> id: ". $row["id"]. " - Name: ". $row["username"]. " " ;
}
} else {
echo "0 個結果";
}

$userData = array(
    'username' => $username,
    'password' => $password
);

// PHP數組或對象轉換為JSON表示形式
$jsonData = json_encode($userData);

// 將JSON字串寫入檔案
$file = 'user.json';
file_put_contents($file, $jsonData);


$conn->close();
?>