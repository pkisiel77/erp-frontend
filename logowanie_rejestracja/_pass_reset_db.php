<?php
session_start();

$conn = new mysqli("localhost", "root", "root", "ERP");
if ($conn->connect_error) {
    die("Błąd połączenia");
}
// obsluga formularza
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $username = trim($_POST['login']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];

    $stmt = $conn->prepare(
        "SELECT user_id, username, email, password_hash FROM users WHERE username = ? AND email = ?"
    );
    $stmt->bind_param("ss", $username, $email);
    $stmt->execute();
    $result = $stmt->get_result();

     if ($result->num_rows !== 1) {
        die("Nie znaleziono użytkownika");
    }
    $stmt->close();

    $hash = password_hash($password, PASSWORD_DEFAULT);
    $stmt = $conn->prepare( "UPDATE users SET password_hash = ? WHERE username = ? AND email = ?");
    $stmt->bind_param("sss", $hash, $username, $email);
    if ($stmt->execute()) {
        header("Location: _login_db.php");} 

        $stmt->close();
        $conn->close();
}
?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Logowanie</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-body-tertiary d-flex align-items-center justify-content-center min-vh-100">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-sm-10 col-md-6 col-lg-4">

            <div class="card shadow-sm">
                <div class="card-body p-4">

                    <h1 class="h4 text-center mb-4">Logowanie</h1>
                    <form method="POST">

                        <div class="mb-3">
                            <label for="login" class="form-label">
                                Nazwa użytkownika
                            </label>
                            <input
                                type="text"
                                name="login"
                                id="login"
                                class="form-control"
                                required
                                autofocus
                            >
                        </div>

                        <<div class="mb-3">
                            <label class="form-label">Email</label>
                            <input
                                type="email"
                                name="email"
                                class="form-control"
                                required
                            >
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Nowe Hasło</label>
                            <input
                                type="password"
                                name="password"
                                id="password"
                                class="form-control"
                                required
                            >
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Ustaw nowe hasło</button>
                    </form>

                    <div class="text-center mt-3">
                        <small>
                            Nie masz konta?
                            <a href="_register_db.php">Zarejestruj się</a>
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