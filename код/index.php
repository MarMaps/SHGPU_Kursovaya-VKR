<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="bootstrap-5.3.9-dist/css/bootstrap.min.css">
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
            <label class="label" for="weight">Вес (кг)</label>
            <input class="area" type="number" name="weight" min="1" max="220" required>
            <br>
            <label class="label" for="height">Рост (см)</label>
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

            <!-- <input class="" name='btn' type='submit' value='Рассчитать'> -->
            <button type="submit" class="btn btn-warning" name="btn">Рассчитать</button>
            <p></p>
        </form>

    <?php
        if (isset($_GET['btn'])) {
            $con = pg_connect('host=localhost port=5432 dbname=FoodPlan user=postgres password=123456');

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
                $carbohydrates = (0.45 * $calories) / 4;

                //имт, добавить в регистрацию чтобы прога просто не регистрировала нездоровых людей
                //предожирение считается, ожирение 1,2,3 степени уже нет
                $imt = $weight / ($height*$height) * 10000;
                print("Индекс массы тела = " . round($imt,3) . "<br>");
                //
                if ($imt >= 30) {
                    print("Индекс массы тема превышает норму. Невозвожно сформировать меню (программа расчитана для здорового человека)");
                    exit();
                }
                
                print("Итого суточная норма:" . "<br>");
                print("ккал = " . round($calories) . "<br>");
                print("б = " . round($proteins) . "<br>");
                print("ж = " . round($fats) . "<br>");
                print("у = " . round($carbohydrates) . "<br>" . "<br>");
                print('<hr style="border-top: 1px solid #f10101">');

                $week = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];
                $meal_names = ['Завтрак', 'Обед', 'Перекус', 'Ужин'];
                $meal_id = [1, 2, 5, 3];
                $meal_calories = [$calories * 0.25,$calories * 0.30,$calories * 0.15,$calories * 0.30];
                $meal_proteins = [$proteins * 0.25,$proteins * 0.30,$proteins * 0.15,$proteins * 0.30];
                $meal_fats = [$fats * 0.25,$fats * 0.30,$fats * 0.15,$fats * 0.30];
                $meal_carbohydrates = [$carbohydrates * 0.25,$carbohydrates * 0.30,$carbohydrates * 0.15,$carbohydrates * 0.30];

                $sql = "select dishes.id, dish, calories, proteins, fats, carbohydrates, id_meal
                from dishes join dishes_meal on dishes.id = dishes_meal.id_dish";
                $result = pg_query($con, $sql);
                $all_dishes = [];
                while ($row = pg_fetch_assoc($result)) {
                    $all_dishes[] = $row;
                }
                $sql_rand = "select id, dish, calories, proteins, fats, carbohydrates from dishes";
                $result_rand = pg_query($con, $sql_rand);
                $random_dishes = [];
                while ($row = pg_fetch_assoc($result_rand)) {
                    $random_dishes[] = $row;
                }
                $used_dishes = [];

                function find_dish($dishes, $t_cal, $t_prot, $t_fats, $t_carb, $used_dishes, $meal_id) {
                    $dishes_count = count($dishes);
                    for ($j = 0; $j < $dishes_count; $j++) {
                        $dish = $dishes[$j];
                        if (in_array($dish['id'], $used_dishes)) {
                            continue;
                        }
                        if ($dish['id_meal'] != $meal_id) {
                            continue;
                        }
                        $portion = ($t_cal / $dish['calories']) * 100;

                        if ($portion >= 150 && $portion <= 300) { //или 300-330
                            $p_in_portion = ($dish['proteins'] * $portion) / 100;
                            $f_in_portion = ($dish['fats'] * $portion) / 100;
                            $c_in_portion = ($dish['carbohydrates'] * $portion) / 100;
                            if (abs($p_in_portion - $t_prot) <= 7 && abs($f_in_portion - $t_fats) <= 7 && abs($c_in_portion - $t_carb) <= 7) {
                                return ['name' => $dish['dish'], 'id' => $dish['id'], 'portion' => $portion];
                            }
                        }
                    }
                    return null;
                }

                for ($w = 0; $w < 7; $w++) {
                    print('<b>' .$week[$w] . '</b> <br>');
                    for ($i = 0; $i < 4; $i++) {
                        $c_cal = $meal_calories[$i];
                        $c_prot = $meal_proteins[$i];
                        $c_fats = $meal_fats[$i];
                        $c_carb = $meal_carbohydrates[$i];
                        $current_meal_id = $meal_id[$i];

                        $found = find_dish($all_dishes, $c_cal, $c_prot, $c_fats, $c_carb, $used_dishes, $current_meal_id);

                        print($meal_names[$i] . "<br>");
                        print("Цел ккал: " . round($c_cal) . " | Цел б: " . round($c_prot) . " | Цел ж: " . round($c_fats) . " | Цел y: " . round($c_carb) ."<br>");
                        
                        if ($found) {
                            $used_dishes[] = $found['id'];
                            print("Блюдо: " . $found['name'] . "<br>");
                            print("Порция: " . round($found['portion']) . " г<br> <br>");

                        } else {
                            $suitable_dishes = [];
                            for ($j = 0; $j < count($random_dishes); $j++) {
                                $rand_dish = $random_dishes[$j];
                                if ($rand_dish['calories'] <= 0) {
                                    continue;
                                }

                                $portion = ($c_cal / $rand_dish['calories']) * 100;
                                if ($portion < 150 || $portion > 300) {
                                    continue;
                                }

                                $p_in_portion = ($rand_dish['proteins'] * $portion) / 100;
                                $f_in_portion = ($rand_dish['fats'] * $portion) / 100;
                                $c_in_portion = ($rand_dish['carbohydrates'] * $portion) / 100;

                                if (abs($p_in_portion - $c_prot) <= 15 &&
                                    abs($f_in_portion - $c_fats) <= 15 &&
                                    abs($c_in_portion - $c_carb) <= 15) {
                                    //не повторять блюда
                                    if (!in_array($rand_dish['id'], $used_dishes)) {
                                        $rand_dish['portion'] = $portion;
                                        $suitable_dishes[] = $rand_dish;
                                    }
                                }
                            }

                            // только по ккал и порции
                            if (count($suitable_dishes) == 0) {
                                for ($j = 0; $j < count($random_dishes); $j++) {
                                    $rand_dish = $random_dishes[$j];
                                    if ($rand_dish['calories'] <= 0) {
                                        continue;
                                    }

                                    $portion = ($c_cal / $rand_dish['calories']) * 100;
                                    if ($portion >= 100 && $portion <= 350) {
                                        if (!in_array($rand_dish['id'], $used_dishes)) {
                                            $rand_dish['portion'] = $portion;
                                            $suitable_dishes[] = $rand_dish;
                                        }
                                    }
                                }
                            }

                            //случ по калориям
                            if (count($suitable_dishes) > 0) {
                                $rand_index = array_rand($suitable_dishes);
                                $rand_dish = $suitable_dishes[$rand_index];
                                $used_dishes[] = $rand_dish['id'];

                                print("* Блюдо: " . $rand_dish['dish'] . "<br>");
                                print("Порция: " . round($rand_dish['portion']) . "г <br> <br>");
                            } else {
                                print("Не удалось подобрать блюдо из неиспользованных". "<br>");
                            }

                            //проблема с ожирением, делать по ИМТ?
                            // $flag = false;
                            // for ($j = 0; $j < 500; $j++) {
                            //     $rand_index = array_rand($random_dishes);
                            //     $rand_dish = $random_dishes[$rand_index];
                            //     $portion = ($c_cal / $rand_dish['calories']) * 100;

                            //     if ($portion >= 150 && $portion <= 300) {
                            //         $p_in_portion = ($rand_dish['proteins'] * $portion) / 100;
                            //         $f_in_portion = ($rand_dish['fats'] * $portion) / 100;
                            //         $c_in_portion = ($rand_dish['carbohydrates'] * $portion) / 100;
                            //         if (abs($p_in_portion - $c_prot) <= 7 &&
                            //             abs($f_in_portion - $c_fats) <= 7 &&
                            //             abs($c_in_portion - $c_carb) <= 7) {
                            //             $flag = true;
                            //             print("* Блюдо: " . $rand_dish['dish'] . "<br>");
                            //             print("Порция: " . round($portion) . " г <br> <br>");
                            //             break;
                            //         }
                            //     }
                            // }
                            // //если ничего не нашел по бжу
                            // if (!$flag) {
                            //     $rand_index = array_rand($random_dishes);
                            //     $rand_dish = $random_dishes[$rand_index];
                            //     $portion = ($c_cal / $rand_dish['calories']) * 100;
                            //     if ($portion >= 150 && $portion <= 300) {
                            //         print("** Блюдо (только ккал): " . $rand_dish['dish'] . "<br>");
                            //         print("Порция: " . round($portion) . " г<br>");
                            //     }
                            // }

                        }
                            
                    }
                        print("<br>");
                        print('<hr style="border-top: 1px solid #0e0b0b">');
                }
                    
            }
            pg_close($con);
        }
        //перемешать блюда перед циклом с помощью shuffle($all_dishes);, чтобы рацион не выглядел одинаково каждую неделю и не выбирались всегда одни и те же первые подходящие по списку блюда
    ?>
    <input class="" name='btn' type='submit' value='Сохранить'>
    </body>
</html>


