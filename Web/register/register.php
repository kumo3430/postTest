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

// if ($username != null && $password != null && $email != null ){
//     $sql = "INSERT INTO users (username, password, email) VALUES ('$username', '$password', '$email')";
// }
$sql = "INSERT INTO users (username, password, email) VALUES ('$username', '$password', '$email')";

// 執行 SQL 語句，將用戶資料插入資料庫
if ($conn->query($sql) === TRUE) {
    // 註冊成功，回傳 JSON 格式的訊息
    // $response = array('message' => 'User registered successfully.');
    $response = array('message' => 'User registered successfully.', 'username' => $username, 'email' => $email);
    echo json_encode($response);
} else {
    // 註冊失敗，回傳 JSON 格式的錯誤訊息
    $response = array('message' => 'Error: ' . $sql . '<br>' . $conn->error);
    echo json_encode($response);
}

// if ($conn->query($sql) === TRUE) {
//     // 回傳成功的回應
//     echo "User created successfully";
//   } else {
//     // 回傳失敗的回應
//     echo "Error creating user: " . $conn->error;
//   }

$sql2 = "SELECT * FROM `users` WHERE `username` = '$username'";
$result = $conn->query($sql2);

if ($result->num_rows > 0) {
// 輸出每行數據
while($row = $result->fetch_assoc()) {
echo "<br> id: ". $row["id"]. " - Name: ". $row["username"]. " " . $row["email"];
}
} else {
echo "0 個結果";
}
$conn->close();
?>