<?php
  // 建立與 MySQL 的連接
  $servername = "localhost"; // 伺服器名稱
  $user = "kumo"; // 資料庫用戶名稱
  $pass = "coco3430"; // 資料庫密碼
  $dbname = "test"; // 資料庫名稱

  $conn = mysqli_connect($servername, $user, $pass, $dbname);

// 驗證用戶名稱和密碼
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $email = $_POST['email'];
    $conn = mysqli_connect('localhost', 'kumo', 'coco3430', 'test');
    // 檢測連接
    if ($conn->connect_error) {
        die("連接失敗: " . $conn->connect_error);
    }
    // 查詢資料庫中是否有相應的用戶名稱和密碼
    // $sql = "SELECT * FROM users WHERE username='$username' AND password='$password' AND email='$email'";
    $sql = "SELECT * FROM `users` WHERE `username` LIKE '$username' AND `password` LIKE '$password' AND `email` LIKE '$email''";
    $result = mysqli_query($conn, $sql);
  
    if (mysqli_num_rows($result) > 0) {
      // 登錄成功
      echo "登錄成功";
    } else {
      // 登錄失敗
      echo "登錄失敗";
    }
}
  // 關閉與 MySQL 的連接
  mysqli_close($conn);
?>
