<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Регистрация</title>
        <link rel="stylesheet" href="bootstrap-5.3.9-dist/css/bootstrap.min.css">
    </head>
    
    <body class="container mt-4">
        <h1 class="text-center">Регистрация нового пользователя</h1>

        <form method="get" action="">
            <div class="mb-3">
                <label for="login" class="form-label">Логин</label>
                <input type="text" class="form-control" id="login" name="login" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Пароль</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mb-3">
                <label for="full_name" class="form-label">ФИО</label>
                <input type="text" class="form-control" id="full_name" name="full_name">
            </div>
            
            <div class="mb-3">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" id="gender1" value="жен" checked>
                    <label class="form-check-label" for="gender1">Жен</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" id="gender2" value="муж">
                    <label class="form-check-label" for="gender2">Муж</label>
                </div>
            </div>

            <div class="mb-3">
                <label for="age" class="form-label">Возраст</label>
                <input type="number" class="form-control" id="age" name="age">
            </div>
            <div class="mb-3">
                <label for="weight" class="form-label">Вес</label>
                <input type="number" class="form-control" id="weight" name="weight">
            </div>
            <div class="mb-3">
                <label for="height" class="form-label">Рост</label>
                <input type="number" class="form-control" id="height" name="height">
            </div>
            
            <div class="mb-3">
                <label class="form-label" for="physical_activity_level">Уровень физической активности</label>
                <select class="form-select" name="physical_activity_level" id="physical_activity_level">
                    <option value="1">1 - очень мало движения (сидячий образ жизни)</option>
                    <option value="2">2 - легкая активность (тренировки 1–2 раза в неделю)</option>
                    <option value="3">3 - умеренная активность (тренировки 3–4 раза в неделю)</option>
                    <option value="4">4 - высокая активность (тренировки почти каждый день)</option>
                    <option value="5">5 - экстремальная активность (тяжелая физическая работа/тяжелые тренировки)</option>
                </select>
            </div>

            <button type="submit" class="btn btn-success d-block mx-auto" name="btn">Зарегистрироваться</button>
        </form>

        <?php
            $con = pg_connect('host=localhost port=5432 dbname=FoodPlan user=postgres password=123456');
            
            if (isset($_GET['btn'])) {
                $login = trim($_GET['login'] ?? '');
                $password = trim($_GET['password'] ?? '');
                $full_name = trim($_GET['full_name'] ?? '');
                $gender = trim($_GET['gender'] ?? '');
                $age = trim($_GET['age'] ?? '');
                $weight = trim($_GET['weight'] ?? '');
                $height = trim($_GET['height'] ?? '');
                $physical_activity_level = trim($_GET['physical_activity_level'] ?? '');
            
                if ($login != '' && $password != '') {
                    $sql = "INSERT INTO users (login, password, full_name, gender, age, weight, height, physical_activity_level) 
                    VALUES ('$login', '$password', '$full_name', '$gender', '$age', '$weight', '$height', '$physical_activity_level')";
                    $result = pg_query($con, $sql);
    
                    if ($result) {
                        print "<p class='text-center mt-3 text-success'>Пользователь зарегистрирован!</p>";
                    }
                    else {
                        print "<p class='text-center mt-3 text-danger'>Ошибка при регистрации</p>";
                    }

                }
            }
            pg_close($con);
        ?>
    </body>
</html>
