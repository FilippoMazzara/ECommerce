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
</head>
<body>

<body>

    <div class="card-bg">
        <!--Navbar-->
    
        <jsp:include page = "/navbar" />
        
        <!--Indietro-->
        <%
                String referer = request.getHeader("Referer");
        
        %>
        <section class="ricerca">
        
            <div style="padding-top:20px;" class="container">
                <div class="col">
                <a class="btn btn-primary text-white" href = <%= referer %> >Torna indietro</a>

                </div>
            </div>
        
        </section>
        
        <!--Chiamata SERVLET PRODOTTO-->
        <div>
        <jsp:include page = "/product" />
        </div>
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