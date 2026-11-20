<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Добавление нового блюда</title>
        <link rel="stylesheet" href="bootstrap-5.3.9-dist/css/bootstrap.min.css">

        <!-- <link rel="stylesheet" href="style.css"> -->
    </head>
    
    <body class="container mt-4">
        <h1 class="text-center">Добавление нового блюда</h1>

        <form method="get" action="">
            <div class="mb-3">
                <label class="form-label" for="name">Название блюда</label>
                <input class="form-control" type="text" name="name" required> 
            </div>
            <h4 class="text-center">Пищевая ценность на 100 грамм:</h4>
            <div class="mb-3">
                <label class="form-label" for="calories">Калории</label>
                <input class="form-control" type="text" name="calories" required> 
            </div>
            <div class="mb-3">
                <label class="form-label" for="proteins">Белки</label>
                <input class="form-control" type="text" name="proteins" required> 
            </div>
            <div class="mb-3">
                <label class="form-label" for="fats">Жиры</label>
                <input class="form-control" type="text" name="fats" required> 
            </div>
            <div class="mb-3">
                <label class="form-label" for="carbohydrates">Углеводы</label>
                <input class="form-control" type="text" name="carbohydrates" required> 
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Категории (приемы пищи):</label>
                <?php
                    $con = pg_connect('host=localhost port=5432 dbname=FoodPlan user=postgres password=123456');
                    // Запрашиваем список приемов пищи (замените названия таблицы и колонок, если они отличаются)
                    $meals_res = pg_query($con, "SELECT id, meal FROM meals ORDER BY id");
                    if ($meals_res) {
                        while ($row = pg_fetch_assoc($meals_res)) {
                            $id = $row['id'];
                            $title = htmlspecialchars($row['meal']);
                            echo "
                            <div class='form-check'>
                                <input class='form-check-input' type='checkbox' name='meals[]' value='$id' id='meal_$id'>
                                <label class='form-check-label' for='meal_$id'>$title</label>
                            </div>";
                        }
                    }
                ?>
            </div>

            <h4>сделать список с неск галочками с указанием категорий - категории к блюду не добавляются, сделать проверку есть ли такое блюдо уже в бд</h4>
            <div class="mb-3">
                <label for="imageUpload" class="form-label">Выберите изображение</label>
                <input class="form-control form-control-lg" type="file" id="imageUpload" accept="image/*">
            </div>

            <input type='submit' class="btn btn-success d-block mx-auto" name='btn' value='Добавить'>    
        </form>

        <?php
            //при заполнение полей вводить с точками(3.6)
            if (isset($_GET['btn'])) {
                $name = trim($_GET['name']);
                $calories = trim($_GET['calories']);
                $proteins = trim($_GET['proteins']);
                $fats = trim($_GET['fats']);
                $carbohydrates = trim($_GET['carbohydrates']);
            
                if ($name != '' && $calories != '') {
                    $sql = "INSERT INTO dishes (dish, calories, proteins, fats, carbohydrates) 
                    VALUES ('$name', '$calories', '$proteins', '$fats', '$carbohydrates')";
                    $result = pg_query($con, $sql);
    
                    if ($result) {
                        print "<p class='text-center mt-3 text-success'>Ваше блюдо добавлено!</p>";
                    }
                }
            }
            pg_close($con);
        ?>
    </body>
</html>