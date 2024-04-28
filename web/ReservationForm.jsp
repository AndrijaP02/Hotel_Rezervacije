
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Reservation Form</title>
        <link rel="stylesheet" href="css/ReservationFormStyle1.css">
        <script>

            function ValidateReservationForm()
            {
                var ArriveDate = document.getElementById("Checkin");
                var DepartureDate = document.getElementById("Checkout");
                if (ArriveDate.value === "" || DepartureDate.value === "") {
                    alert("Invalid input");
                } else {
                    alert("Submitted successfully");
                }

            }

        </script>
    </head>
    <body>
        <%
            String roomIdWithGar = request.getParameter("roomid2").toString();
            String roomId = roomIdWithGar.substring(2, roomIdWithGar.length() - 2);
            String hotelIdWithGar = request.getParameter("hotelid2").toString();
            String hotelId = hotelIdWithGar.substring(2, hotelIdWithGar.length() - 2);


        %>
        <div class="wrapper">
            <h1>BOOK A ROOM</h1>
            <form class="form" action='ReservationRoom.jsp' onsubmit="ValidateReservationForm();">
                <label>Hotel ID:</label>
                <input type="text" id="hotelId" value ='<%=hotelId%>' readonly name="hotelId">
                <label>Room ID:</label>
                <input type="text" id="RoomId" value ='<%=roomId%>' readonly name="roomId">
                <label>Check in:</label>
                <input type="date" id="Checkin" name="Checkin">
                <label>Check out:</label>
                <input type="date" id="Checkout" name="Checkout">

                <label>Adults: </label>
                <select name="adults" id="adults">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>

                <label>Children: </label>
                <select name="Children" id="Children">
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>

                <input type="submit" value="Reserve"/>
            </form>
        </div>

    </body>
</html>
