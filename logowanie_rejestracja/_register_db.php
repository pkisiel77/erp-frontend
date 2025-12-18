<?php
$conn = new mysqli("localhost", "root", "root", "ERP");
if ($conn->connect_error) {
    die("Błąd połączenia");
}
$success = "Konto zostało utworzone";
// obsluga formularza
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $username = trim($_POST['username']);
    $email    = trim($_POST['email']);
    $pass    = $_POST['password'];

// sprawdzenie czy podany login juz istnieje
        $stmt = $conn->prepare(
            "SELECT user_id FROM users WHERE username=? OR email=?"
        );
        $stmt->bind_param("ss", $username, $email);
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows > 0) {
            $error = "Użytkownik lub email już istnieje.";
        } else {

            $hash = password_hash($pass, PASSWORD_DEFAULT);
// insert bd
            $stmt = $conn->prepare(
                "INSERT INTO users (username, email, password_hash) 
                 VALUES (?, ?, ?)"
            );
            $stmt->bind_param("sss", $username, $email, $hash);
            if ($stmt->execute()) {
                header("Location: _login_db.php");} 
        }
    }
    $stmt->close();
    $conn->close();
?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Rejestracja</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-body-tertiary d-flex align-items-center justify-content-center min-vh-100">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-sm-10 col-md-6 col-lg-4">

            <div class="card shadow-sm">
                <div class="card-body p-4">

                    <h1 class="h4 text-center mb-4">Rejestracja</h1>

                    <form method="POST">

                        <div class="mb-3">
                            <label class="form-label">Nazwa użytkownika</label>
                            <input
                                type="text"
                                name="username"
                                class="form-control"
                                required
                            >
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input
                                type="email"
                                name="email"
                                class="form-control"
                                required
                            >
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Hasło</label>
                            <input
                                type="password"
                                name="password"
                                class="form-control"
                                required
                            >
                        </div>

                        <button type="submit" class="btn btn-primary w-100">
                            Zarejestruj się
                        </button>
                    </form>

                    <div class="text-center mt-3">
                        <small>
                            Masz już konto?
                            <a href="_login_db.php">Zaloguj się</a>
                        </small>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
