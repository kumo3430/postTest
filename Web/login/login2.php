<?php
// 獲取用戶提交的表單數據
$username = $_POST['username'];
$password = $_POST['password'];

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

// 檢查連接是否成功
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
echo $username;
echo $password;
echo $email;

$sql = "SELECT * FROM users WHERE username='$username' AND password='$password'";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
// 登錄成功
echo "登錄成功";
} else {
// 登錄失敗
echo "登錄失敗";
}
if ($result->num_rows > 0) {
// 輸出每行數據
while($row = $result->fetch_assoc()) {
echo "<br> id: ". $row["id"]. " - Name: ". $row["username"]. " " . $row["email"];
}
} else {
echo "0 個結果";
}

// 關閉與 MySQL 的連接
$conn->close();
?>
