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
            <input class="area" type="number" name="age" min="1" max="110" value="25"> <br>

            <label class="label" for="weight">Вес</label>
            <input class="area" type="number" name="weight" min="1" max="220" value="70"> <br>

            <label class="label" for="height">Рост</label>
            <input class="area" type="number" name="height" min="1" max="250" value="170"> <br>

            
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
                //$sql = "INSERT INTO avtomobili (marka, model, god_vypuska, moschnost, stoimost_za_chas, gos_nomer) 
                //        VALUES ('$marka', '$model', '$god_vypuska', '$moschnost', '$stoimost_za_chas', '$gos_nomer')";
                // $result = pg_query($con, $sql);        
                //if ($result) {
                    //print "<p>👍</p>";
                //}
                
                //для ккал - формула Миффлина-Сен Жеора
                if ($gender == 'жен') {
                    $calories = 10 * $weight + 6.25 * $height - 5 * $age - 161;
                } elseif ($gender == 'муж') {
                    $calories = 10 * $weight + 6.25 * $height - 5 * $age + 5;
                }

                switch ($physical_activity_level) {
                    case 1: 
                        $calories *= 1.2; 
                        $proteins = $weight * 1.6;
                        break; //оч мало движения
                    case 2: 
                        $calories *= 1.375; 
                        $proteins = $weight * 1.8;
                        break; //легкая активность 1-2р в неделю
                    case 3: 
                        $calories *= 1.55; 
                        $proteins = $weight * 2;
                        break; //умеренная активность 3-4р в неделю
                    case 4: 
                        $calories *= 1.725; 
                        $proteins = $weight * 2.2;
                        break; //тренировки почти каждый день
                    case 5: 
                        $calories *= 1.9; 
                        $proteins = $weight * 2.4;
                        break; //интенс тренировки и физич работа
                }
                $fats = (0.3 * $calories) / 9;
                $carbohydrates = (0.4 * $calories) / 4;

                print("ккал = " . round($calories) . "<br>");
                print("б = " . round($proteins) . "<br>");
                print("ж = " . round($fats) . "<br>");                
                print("у = " . round($carbohydrates) . "<br>");

            }
        }
        
        pg_close($con);
        ?>
    </body>
</html>
