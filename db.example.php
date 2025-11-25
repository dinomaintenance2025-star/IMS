<?php
// Example DB config for secure deployments.
// Copy this to `db.php` on your server and fill values, or better: set env vars on the host and use the first approach.

// Preferred: read credentials from environment variables (do NOT commit real secrets).
$servername = getenv('DB_HOST') ?: 'localhost';
$username   = getenv('DB_USER') ?: 'db_user';
$password   = getenv('DB_PASS') ?: 'db_pass';
$dbname     = getenv('DB_NAME') ?: 'database_name';

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

/*
Alternative (less secure): hardcode values here (not recommended for public repos):
$servername = "sql.example.com";
$username = "your_db_user";
$password = "your_db_password";
$dbname = "your_db_name";

$conn = new mysqli($servername, $username, $password, $dbname);
*/

?>
