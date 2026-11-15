<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Добавление нового напитка</title>
        <!-- <link rel="stylesheet" href="style.css"> -->
    </head>
    
    <body>
        <h1>Добавление нового напитка</h1>

        <form method="get" action="">
            <label class="label" for="name">Название напитка</label>
            <input class="area" type="text" name="name" required> <br>

            <h4>Калорийность напитка на 100 грамм:</h4>
            <label class="label" for="calories">Калории</label>
            <input class="area" type="text" name="calories" required> <br>

            <label class="label" for="proteins">Белки</label>
            <input class="area" type="text" name="proteins" required> <br>

            <label class="label" for="fats">Жиры</label>
            <input class="area" type="text" name="fats" required> <br>
            
            <label class="label" for="carbohydrates">Углеводы</label>
            <input class="area" type="text" name="carbohydrates" required> <br>

            <h4>сделать проверку есть ли такое напиток уже в бд</h4>
            <input class="btn_dob" name='btn' type='submit' value='Добавить'>    
        </form>

        <?php
            //при заполнение полей вводить с точками(3.6)
            $con = pg_connect('host=localhost port=5432 dbname=FoodPlan user=postgres password=123456');
            
            if (isset($_GET['btn'])) {
                $name = trim($_GET['name']);
                $calories = trim($_GET['calories']);
                $proteins = trim($_GET['proteins']);
                $fats = trim($_GET['fats']);
                $carbohydrates = trim($_GET['carbohydrates']);
            
                if ($name != '' && $calories != '') {
                    $sql = "INSERT INTO drinks (drink, calories, proteins, fats, carbohydrates) 
                    VALUES ('$name', '$calories', '$proteins', '$fats', '$carbohydrates')";
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