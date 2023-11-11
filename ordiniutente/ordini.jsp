<?xml version = "1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns = "http://www.w3.org/1999/xhtml">
<head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="login" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Il Mercatino</title>
        <link rel="stylesheet" type="text/css" href ="<%= request.getContextPath() %>/profilo/style.css"/>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

        <style>

              body{
                 background: linear-gradient(to bottom, rgba(255, 255, 255, 0.890) 0%, rgb(255, 255, 255) 100%), url("<%= request.getContextPath() %>/img/sfondo.jpg");
                
                }
            
        
        </style>

       
</head>
<body>

     <!--Navbar-->
    <jsp:include page = "/navbar" />

    



    <!--ordini-->

    <div class="container py-4">
        <h2>I miei ordini</h2>
        <hr>
        <jsp:include page = "/stampaordini" />
        
        
       
    </div>

    


    <!--Footer-->
    <footer >
        <div >
        <div class="container">
            <footer class="py-3 my-4">
            <ul class="nav justify-content-center border-bottom pb-3 mb-3">
                <li class="nav-item"><p class="px-2 text-muted">Luca</p></li>
                <li class="nav-item"><p class="px-2 text-muted">Kosmin</p></li>
                <li class="nav-item"><p class="px-2 text-muted">Filippo</p></li>
            </ul>
            <p class="text-center text-muted">&copy; 2021 Company, Inc</p>
            </footer>
        </div>
        </div>
    </footer>




    
        


</body>
</html>