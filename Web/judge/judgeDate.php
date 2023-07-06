<?php
// include('login3.php');
session_start();
// 從 $_SESSION 中獲取用戶名
$uid = $_SESSION['uid'];

// 獲取用戶提交的表單數據
$input_data = file_get_contents("php://input");
$data = json_decode($input_data, true);

$servername = "localhost"; // 資料庫伺服器名稱
$user = "kumo"; // 資料庫使用者名稱
$pass = "coco3430"; // 資料庫使用者密碼
$dbname = "test"; // 資料庫名稱

// 建立與 MySQL 資料庫的連接物件
$conn = new mysqli($servername, $user, $pass, $dbname);

// 檢查連接是否成功
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$tableName = $_SESSION['tableName'];

// 查詢資料表以檢查日期連續性
// 選擇了資料表中的set_date欄位，並根據日期的升序排序。
// $sql = "SELECT set_date FROM $tableName ORDER BY set_date ASC";
// 測試
$sql = "SELECT set_date FROM $tableName ORDER BY set_date DESC";
// 使用資料庫連接對象($conn)的 query 方法來執行 SQL 查詢，將查詢語句 $sql 作為參數傳入。$result 變數將儲存查詢的結果。
// query() 是mysqli 物件的一個方法，用於執行sql查詢，他接受一個sql 查詢字串做為參數，並返回一個結果集
// $sql 是包含要執行的sql查詢的字串變數。通常是SELECT語句，用於擷取資料庫中的資料
// 對資料庫進行查詢
$result = $conn->query($sql);
$row = $result -> fetch_assoc();
$currentDate = $row["set_date"];
$prevDate = null; // 前一個日期
$continuousDays = 0; // 連續的天數
// 取得今天的日期
$today = date("Y-m-d");
// echo "currentDate: " . $currentDate . "<br>";
// echo "result: ";
// print_r($result);
// echo "<br>";
// echo "row: ";
// print_r($row);
// echo "<br>";
// echo "continuousDays: " . $continuousDays . "<br>";
// echo "prevDate2: " . $prevDate . "<br>";
// echo "-----------------------------------------------------------<br>". "<br>";
$prevDate  = $currentDate ;

if ($currentDate !== null && strtotime($today . "-1 day") > strtotime($currentDate)) {
    $continuousDays = 0;
} else{
    $continuousDays++ ;
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $currentDate = $row["set_date"];
            // echo "prevDate1: " . $prevDate . "<br>";
            // echo "currentDate: " . $currentDate . "<br>";
            // echo "result: ";
            // print_r($result);
            // echo "<br>";
            // echo "row: ";
            // print_r($row);
            // echo "<br>";
            // echo "continuousDays: " . $continuousDays . "<br>";
            if ($prevDate !== null && strtotime($currentDate . " +1 day") === strtotime($prevDate)) {
                $continuousDays++;
            } 
            else {
                break;
            }        
            // $prevDate = $currentDate;
            // echo "continuousDays: " . $continuousDays . "<br>";
            // echo "prevDate2: " . $prevDate . "<br>";
            // echo "-----------------------------------------------------------<br>". "<br>";
            $prevDate = $currentDate;
        }
        
            // echo "continuousDays: " . $continuousDays . "<br>";
            // echo "prevDate2: " . $prevDate . "<br>";
            // echo "-----------------------------------------------------------<br>". "<br>";
    }
}

// echo "prevDate1: " . $prevDate . "<br>";
    
// echo "currentDate: " . $currentDate . "<br>";
// echo "result: ";
// print_r($result);
// echo "<br>";
// echo "row: ";
// print_r($row);
// echo "<br>";
// echo "continuousDays: " . $continuousDays . "<br>";
// echo "prevDate2: " . $prevDate . "<br>";
// echo "-----------------------------------------------------------<br>". "<br>";

$response = array('continuousDays' => "$continuousDays");
echo json_encode($response);

// 顯示連續的天數
// echo "連續的天數: " . $continuousDays;

// $response = array('today' => "$today",'prevDate' => "$prevDate",'continuousDays' => "$continuousDays",'currentDate' => "$currentDate");
// echo json_encode($response);


// 關閉資料庫連接
$conn->close();
?>