<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Формирование недельного рациона питания FoodPlan</title>
</head>
<body>
    <form method="get" action="">
        <label class="label" for="full_name">ФИО</label>
        <input class="area" type="text" name="full_name" required>
        <br>
        <label><input type="radio" name="gender" value="жен" required> жен </label>
        <label><input type="radio" name="gender" value="муж" required> муж </label>
        <br>
        <label class="label" for="age">Возраст</label>
        <input class="area" type="number" name="age" min="1" max="110" required>
        <br>
        <label class="label" for="weight">Вес</label>
        <input class="area" type="number" name="weight" min="1" max="220" required>
        <br>
        <label class="label" for="height">Рост</label>
        <input class="area" type="number" name="height" min="1" max="250" required>
        <br>
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
    if (isset($_GET['btn'])) {
        $con = pg_connect('host=localhost port=5432 dbname=FoodPlan user=postgres password=123456');
        if (!$con) {
            die("Ошибка подключения к БД");
        }

        $full_name = trim($_GET['full_name']);
        $gender = trim($_GET['gender']);
        $age = intval($_GET['age']);
        $weight = floatval($_GET['weight']);
        $height = floatval($_GET['height']);
        $physical_activity_level = intval($_GET['physical_activity_level']);

        if ($weight > 0 && $height > 0) {
            $calories = 0;
            
            //формула Миффлина-Сен Жеора
            if ($gender == 'жен') {
                $calories = 10 * $weight + 6.25 * $height - 5 * $age - 161;
            } elseif ($gender == 'муж') {
                $calories = 10 * $weight + 6.25 * $height - 5 * $age + 5;
            }

            switch ($physical_activity_level) {
                case 1: $calories *= 1.2;   $proteins = $weight * 1.4; break;
                case 2: $calories *= 1.375; $proteins = $weight * 1.6; break;
                case 3: $calories *= 1.55;  $proteins = $weight * 1.8; break;
                case 4: $calories *= 1.725; $proteins = $weight * 2;   break;
                case 5: $calories *= 1.9;   $proteins = $weight * 2.2; break;
            }

            $fats = (0.3 * $calories) / 9;
            $carbohydrates = (0.4 * $calories) / 4;

            print("Итого суточная норма:" . "<br>");
            print("ккал = " . round($calories) . "<br>");
            print("б = " . round($proteins) . "<br>");
            print("ж = " . round($fats) . "<br>");
            print("у = " . round($carbohydrates) . "<br>" . "<br>");
            print('<hr style="border-top: 1px solid #f10101">');

            $week = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];
            $meal_names = ['Завтрак', 'Обед', 'Перекус', 'Ужин'];
            $meal_id = [1, 2, 5, 3];
            $meal_calories = [
                $calories * 0.25, 
                $calories * 0.30, 
                $calories * 0.15, 
                $calories * 0.30  
            ];

            //$sql = "SELECT id, dish, calories, proteins, fats, carbohydrates FROM dishes";
            $sql = "select dishes.id, dish, calories, proteins, fats, carbohydrates, id_meal
            from dishes join dishes_meal on dishes.id = dishes_meal.id_dish";
            $result = pg_query($con, $sql);
            $all_dishes = [];
            while ($row = pg_fetch_assoc($result)) {
                $all_dishes[] = $row;
            }
            $used_dishes = [];

            function find_dish($dishes, $target_calories, $used_dishes, $meal_id) {
                $dishes_count = count($dishes);
                for ($j = 0; $j < $dishes_count; $j++) {
                    $dish = $dishes[$j];
                    if (in_array($dish['id'], $used_dishes)) {
                        continue;
                    }
                    if ($dish['id_meal'] != $meal_id) {
                        continue;
                    }
                    $portion = ($target_calories / $dish['calories']) * 100;
                    if ($portion >= 150 && $portion <= 250) { //или 200
                        //return ['dish' => $dish, 'portion' => $portion];
                        return ['name' => $dish['dish'], 'id' => $dish['id'], 'portion' => $portion];
                    }
                }
                return null;
            }

            for ($w = 0; $w < 7; $w++) {
                //$current_day = $week[$w];
                print('<b>' . $week[$w] . '</b> <br>');
                for ($i = 0; $i < 4; $i++) {
                    //$current_name = $meal_names[$i];
                    $current_calories = $meal_calories[$i];
                    $current_meal_id = $meal_id[$i];

                    $found = find_dish($all_dishes, $current_calories, $used_dishes, $current_meal_id);

                    print($meal_names[$i] . "<br>");
                    print("Целевые ккал: " . round($current_calories) . "<br>");
                    
                    if ($found) {
                        // $used_dishes[] = $found['dish']['id'];
                        // print("Блюдо: " . $found['dish']['dish'] . "<br>");
                        // print("Порция: " . round($found['portion']) . " г<br>");
                        $used_dishes[] = $found['id'];
                        print("Блюдо: " . $found['name'] . "<br>");
                        print("Порция: " . round($found['portion']) . " г<br>");

                    } else {
                        print("<i>Не удалось подобрать блюдо</i><br>");
                    }
                    print("<br>");
                }
                print('<hr style="border-top: 1px solid #0e0b0b">');
            }
        }
        pg_close($con);
    }
?>
</body>
</html>
