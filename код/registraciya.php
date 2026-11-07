<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Регистрация</title>
        <!-- <link rel="stylesheet" href="style.css"> -->
    </head>
    
    <body>
        <h1>Регистрация нового пользователя</h1>

        <form method="get" action="">
            <label class="label" for="login">Логин</label>
            <input class="area" type="text" name="login" required> <br>

            <label class="label" for="password">Пароль</label>
            <input class="area" type="text" name="password" required> <br>
            <p></p>


            <label class="label" for="full_name">ФИО</label>
            <input class="area" type="text" name="full_name" required> <br>

            <label><input type="radio" name="gender" value="жен"> жен </label>
            <label><input type="radio" name="gender" value="муж"> муж </label> <br>

            <label class="label" for="age">Возраст</label>
            <input class="area" type="number" name="age" min="1" max="110" > <br>

            <label class="label" for="weight">Вес</label>
            <input class="area" type="number" name="weight" min="1" max="220"> <br>

            <label class="label" for="height">Рост</label>
            <input class="area" type="number" name="height" min="1" max="250"> <br>

            
            <label class="label" for="physical_activity_level">Уровень физической активности</label>
            <select class="area" name="physical_activity_level" id="physical_activity_level">
                <option value="1">1 - очень мало движения (сидячий образ жизни)</option>
                <option value="2">2 - легкая активность (тренировки 1–2 раза в неделю)</option>
                <option value="3">3 - умеренная активность (тренировки 3–4 раза в неделю)</option>
                <option value="4">4 - высокая активность (тренировки почти каждый день)</option>
                <option value="5">5 - экстремальная активность (тяжелая физическая работа/тяжелые тренировки)</option>
            </select>
            <br>
            <p></p>
            <input class="btn_dob" name='btn' type='submit' value='Зарегистрироваться'>    
        </form>

        <?php
            $con = pg_connect('host=localhost port=5432 dbname=FoodPlan user=postgres password=123456');
            
            if (isset($_GET['btn'])) {
                $login = trim($_GET['login']);
                $password = trim($_GET['password']);
                $full_name = trim($_GET['full_name']);
                $gender = trim($_GET['gender']);
                $age = trim($_GET['age']);
                $weight = trim($_GET['weight']);
                $height = trim($_GET['height']);
                $physical_activity_level = trim($_GET['physical_activity_level']);
            
                if ($login != '' && $password != '') {
                    $sql = "INSERT INTO users (login, password, full_name, gender, age, weight, height, physical_activity_level) 
                    VALUES ('$login', '$password', '$full_name', '$gender', '$age', '$weight', '$height', '$physical_activity_level')";
                    $result = pg_query($con, $sql);
    
                    if ($result) {
                        print "<p>👍</p>";
                    }
                }
            }
            pg_close($con);
        ?>
    </body>
</html>