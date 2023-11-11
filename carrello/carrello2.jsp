<?xml version = "1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns = "http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/style.css">

    <title>Il Mercatino</title>

    <style>

    

        .card{
            border-color: black;
            border-style: solid;
            border-width: 0px;
        }
    </style>
</head>



<body>
    <!--Navbar-->
    <jsp:include page = "/navbar" />

    <!--Elenco prodotti-->
    <div class="card-bg">
        <div class="container" style="padding-top: 20px;  background-color:white;">
            <jsp:include page = "/stampacarrellodb"/>
        </div>
    </div>



    

   

  
      

    
</body>
</html>