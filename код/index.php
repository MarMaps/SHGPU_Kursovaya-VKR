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

            <label class="label" for="age">Возраст</label> <!--с прокруткой 1-110-->
            <input class="area" type="text" name="age"> <br>

            <label class="label" for="weight">Вес</label> <!--с прокруткой 1-220-->
            <input class="area" type="text" name="weight"> <br>

            <label class="label" for="height">Рост</label> <!--с прокруткой 1-250-->
            <input class="area" type="text" name="height"> <br>
            
            <label class="label" for="physical_activity_level">Уровень физической активности(1-5)</label> <!--список 1-5 с описанием -->
            <input class="area" type="text" name="physical_activity_level"> <br>
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
                    case 1: $calories *= 1.2; break;
                    case 2: $calories *= 1.375; break; 
                    case 3: $calories *= 1.55; break; 
                    case 4: $calories *= 1.725; break;
                    case 5: $calories *= 1.9; break; 
                    // default: $calories *= 1.2; 
                }
                $proteins = (0.3 * $calories) / 4;
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
