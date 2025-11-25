<?php include 'db.php'; ?>

<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
</head>
<body>
  <h2>Create Account</h2>
  <form method="POST" action="">
    <input type="text" name="username" placeholder="Username" required><br>
    <input type="password" name="password" placeholder="Password" required><br>
    <button type="submit" name="register">Register</button>
  </form>

  <?php
  if (isset($_POST['register'])) {
      // Basic input trimming
      $username = trim($_POST['username']);
      $password_raw = $_POST['password'];

      // Server-side validation (minimal)
      if (strlen($username) < 3 || strlen($password_raw) < 6) {
        echo "❌ Error: username must be >=3 chars and password >=6 chars.";
      } else {
        $password_hashed = password_hash($password_raw, PASSWORD_DEFAULT);

        // Use prepared statements to avoid SQL injection
        $stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
        if ($stmt) {
          $stmt->bind_param('ss', $username, $password_hashed);
          if ($stmt->execute()) {
            echo "✅ Account created! <a href='login.php'>Login</a>";
          } else {
            // Duplicate username or other DB error
            echo "❌ Error: " . htmlspecialchars($stmt->error);
          }
          $stmt->close();
        } else {
          echo "❌ Error preparing statement: " . htmlspecialchars($conn->error);
        }
      }
  }
  ?>
</body>
</html>
