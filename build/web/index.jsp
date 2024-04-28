
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>home</title>
        <style>
            .engine {
                padding: 15px;
                height: 65px;
                margin-top: 70px;
                background: #ccccff;
                text-align: center;
                border-radius: 10px;
                font-family: Arial;
            }
            input, select, button {
                padding: 7px;
                border: 2px solid #9999ff;
                background-color: white;
                padding-left: 7px;
                border-radius: 5px;
            }
            button {
                background-color: #9999ff;
                border-radius: 5px;
            }
            button:hover {
                background-color: #6666ff;
                color: white;
            }
            .container {
                background-color: white;
                border-radius: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <jsp:include page="navbar.jsp" />

            <form action="resultofsearch.jsp" class="engine" method="post" id="searchForm">
                <label>Where you going:</label>
                <input type="text" id="going" name="going" placeholder="Enter Location">
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

                <button type="submit">Search</button>
            </form>
            <div id="errorMessage" style="color: red; display: none;"></div>
            <script>
                // Dodajte ovu liniju ispod definicije searchForm-a
                var errorMessage = document.getElementById("errorMessage");

// Postavite event listener za submit formulara
                searchForm.addEventListener("submit", function (event) {
                    // Dobijte unete vrednosti
                    var goingValue = document.getElementById("going").value;
                    var checkinValue = document.getElementById("Checkin").value;
                    var checkoutValue = document.getElementById("Checkout").value;

                    // Proverite da li su unete vrednosti prazne
                    if (goingValue.trim() === "" || checkinValue.trim() === "" || checkoutValue.trim() === "") {
                        // Ako su unete vrednosti prazne, sprečite podnošenje forme
                        event.preventDefault();
                        // Prikazivanje poruke korisniku
                        errorMessage.textContent = "Morate uneti sve podatke za pretragu.";
                        errorMessage.style.display = "block"; // Prikazi poruku
                        // Postavi tajmer za sakrivanje poruke nakon 5 sekundi
                        setTimeout(function () {
                            errorMessage.style.display = "none"; // Sakrij poruku
                        }, 5000); // 5000 milisekundi (5 sekundi)
                    }
                });



            </script>
            <jsp:include page="load-hotel.jsp" />

        </div>
    </body>
</html>
