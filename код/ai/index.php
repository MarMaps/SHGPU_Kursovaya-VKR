<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Общение с ИИ агентом</title>
    </head>
    
    <body>
        <!-- <h3>Блюда</h3>
        <table class='table' border='7' cellpadding='5'>
            <tr>
                <th>Название блюда</th>
                <th>Калории</th>
                <th>Бедки</th>
                <th>Жиры</th>
                <th>Углеводы</th>
            </tr>     -->
            
            <?php
                $con=pg_connect('host=localhost port=5432 dbname=FoodPlan user=postgres password=123456');         
                // $sql="select * from dishes";
                // $result=pg_query($con,$sql);
                // $n=pg_num_rows($result);
                // for($i=0; $i<$n; $i++) {
                //     $row=pg_fetch_object($result);
                //     $dish = $row->dish;
                //     $calories = $row->calories;
                //     $proteins = $row->proteins;
                //     $fats = $row->fats;
                //     $carbohydrates = $row->carbohydrates;
                //     print "<tr>
                //             <td>$dish</td>
                //             <td>$calories</td>
                //             <td>$proteins</td>
                //             <td>$fats</td>
                //             <td>$carbohydrates</td>

                //         </tr>";  
                // }
                // pg_close($con);

            ?>
        <!-- </table> -->
    </body>
</html>

