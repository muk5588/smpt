<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: c
  Date: 24. 5. 2.
  Time: 오전 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        $(document).ready(function () {

        });
        var x= ${x}
        var y= ${y}
        console.log(x)
        console.log(y)
        var url = "https://api.openweathermap.org/data/2.5/weather?lat=" + y +
            "&lon=" + x +
            "&units=metric&appid=e776c451f21037ecc76b1a9ecf704f77";
        $.getJSON(url,
            function (result) {
                //기온출력
                $('.Nowtemp').append(result.main.temp);
                $('.Lowtemp').append(result.main.temp_min);
                $('.Hightemp').append(result.main.temp_max);
                $('.Icon').append(result.weather[0].icon);

                //날씨아이콘출력
                //WeatherResult.weater[0].icon
                var weathericonUrl =
                    '<img src= "http://openweathermap.org/img/wn/'
                    + result.weather[0].icon+
                    '.png" alt="' + result.weather[0].description + '"/>'

                $('.Icon').html(weathericonUrl);
            });
    </script>
</head>
<body>
<input type="hidden" class="x" name="x" id="x" value="${x}">
<input type="hidden" class="y" name="y" id="y" value="${y}">
<h3 class="Nowtemp">현재기온:</h3>
<h3 class="Lowtemp">최저기온:</h3>
<h3 class="Hightemp">최대기온:</h3>
<h3 class="Icon"></h3>
</body>
</html>
