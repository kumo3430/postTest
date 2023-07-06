<?php
// $username = $_GET['username'];
// $password = $_GET['password'];
// $email = $_GET['email'];
$username = $_POST['username'];
$password = $_POST['password'];
$email = $_POST['email'];

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
  // 查詢資料庫中是否有相應的用戶名稱和密碼
  // $sql = "SELECT * FROM users WHERE username='$username' AND password='$password' AND email='$email'";
  // $sql = "SELECT * FROM `users` WHERE `username` LIKE '$username' AND `password` LIKE '$password' AND `email` LIKE '$email'";
  $sql = "SELECT * FROM `users` WHERE `username` = '$username' AND `password` = '$password' AND `email` = '$email'";
  // $sql = "SELECT * FROM `users` WHERE `username` = '3aa' AND `password` = '3aa' AND `email` = '3aa'";
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
  mysqli_close($conn);
?>
