<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Формирование недельного рациона питания FoodPlan</title>
        <!-- <link rel="stylesheet" href="style.css"> -->
    </head>
    
    <body>
        <form method="get" action="">
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

            <input class="btn_dob" name='btn' type='submit' value='Рассчитать'>
            <p></p>
            
        </form>

        <?php
        $con = pg_connect('host=localhost port=5432 dbname=FoodPlan user=postgres password=123456');
        
        if (isset($_GET['btn'])) {
            $full_name = trim($_GET['full_name']);
            $gender = trim($_GET['gender']);
            $age = trim($_GET['age']);
            $weight = trim($_GET['weight']);
            $height = trim($_GET['height']);
            $physical_activity_level = trim($_GET['physical_activity_level']);
        
            if ($weight != '' && $height != '') {
                $calories = 0;
                
                //для ккал - формула Миффлина-Сен Жеора
                if ($gender == 'жен') {
                    $calories = 10 * $weight + 6.25 * $height - 5 * $age - 161;
                } elseif ($gender == 'муж') {
                    $calories = 10 * $weight + 6.25 * $height - 5 * $age + 5;
                }

                switch ($physical_activity_level) {
                    case 1: 
                        $calories *= 1.2; 
                        $proteins = $weight * 1.4;
                        break; //оч мало движения
                    case 2: 
                        $calories *= 1.375; 
                        $proteins = $weight * 1.6;
                        break; //легкая активность 1-2р в неделю
                    case 3: 
                        $calories *= 1.55; 
                        $proteins = $weight * 1.8;
                        break; //умеренная активность 3-4р в неделю
                    case 4: 
                        $calories *= 1.725; 
                        $proteins = $weight * 2;
                        break; //тренировки почти каждый день
                    case 5: 
                        $calories *= 1.9; 
                        $proteins = $weight * 2.2;
                        break; //интенс тренировки и физич работа
                }
                $fats = (0.3 * $calories) / 9;
                $carbohydrates = (0.4 * $calories) / 4;

                print("ккал = " . round($calories) . "<br>");
                print("б = " . round($proteins) . "<br>");
                print("ж = " . round($fats) . "<br>");                
                print("у = " . round($carbohydrates) . "<br>");
                
                $breakfast_calories = $calories * 0.25;
                print("ккал на завтрак = " . round($breakfast_calories) . "<br>");
                $lunch_calories = $calories * 0.30;
                $snack_calories = $calories * 0.15;
                $dinner_calories = $calories * 0.30;

                $breakfast_proteins = $proteins * 0.25;
                $lunch_proteins = $proteins * 0.30;
                $snack_proteins = $proteins * 0.15;
                $dinner_proteins = $proteins * 0.30;
                
                //генерация завтрака
                $target_calories = $breakfast_calories;
                $target_proteins = $breakfast_proteins;

                $sql = "SELECT dish, calories,proteins,fats,carbohydrates FROM dishes";
                $result = pg_query($con, $sql);

                while ($row = pg_fetch_assoc($result)) {
                    $portion = ($target_calories / $row['calories']) * 100;
                    if ($portion >= 150 && $portion <= 400) {
                        $best_dish = $row;
                        $best_portion = $portion;
                        break; //выбралось первое попавшееся и дальше по таблице не идет(логика с откл999999)
                    }
                }

                if ($best_dish != null) {
                    print("<br> Завтрак <br>");
                    print("Блюдо: " . $best_dish['dish'] . "<br>");
                    print("Порция: " . round($best_portion) . " г<br>");
                    print("Калории: " . round($target_calories) . " ккал<br>");
                }

            }
        }
        
        pg_close($con);
        ?>
    </body>
</html>
