<?php
// header("Content-Type: application/json; charset=UTF-8");
// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Methods: POST");
// header("Access-Control-Max-Age: 3600");
// header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// $username = $_POST['username'];
// $password = $_POST['password'];
// $email = $_POST['email'];
//請用繁體中文詳細告訴我該如何操作以下步驟“在 Swift 專案中，使用swiftui創建一個註冊視圖控制器，該控制器包含用戶需要輸入的資訊，如用戶名稱、密碼、電子郵件等等。
//實現 Swift 代碼，使用戶在填寫完所有必填項目後，點擊“註冊”按鈕時，將用戶輸入的資料打包成一個 HTTP 請求，發送到您創建的後端 API。”

$servername = "localhost"; // 資料庫伺服器名稱
$user = "kumo"; // 資料庫使用者名稱
$pass = "coco3430"; // 資料庫使用者密碼
$dbname = "test"; // 資料庫名稱
echo "test";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_GET['username'];
    $password = $_GET['password'];
    $email = $_GET['email'];
        
    echo $username;
    echo $password;
    echo $email;
    // 將用戶提交的資料保存到資料庫中
    $conn = mysqli_connect('localhost', 'kumo', 'coco3430', 'test');
    // 檢測連接
    if ($conn->connect_error) {
        die("連接失敗: " . $conn->connect_error);
    }
    $query = "INSERT INTO users (username, password, email) VALUES ('$username', '$password', '$email')";
    echo "123";
    // mysqli_query($conn, $query);
    if ($conn->query($sql) === TRUE) {
        // 回傳成功的回應
        echo "User created successfully";
      } else {
        // 回傳失敗的回應
        echo "Error creating user: " . $conn->error;
      }
    mysqli_close($conn);
}


?>