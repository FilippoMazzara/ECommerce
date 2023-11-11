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
        <link rel="stylesheet" type="text/css" href ="style.css"/>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
          <style>

              body{
                 background: linear-gradient(to bottom, rgba(255, 255, 255, 0.890) 100%, rgb(255, 255, 255) 100%), url("<%= request.getContextPath() %>/img/sfondo.jpg");
                }

        </style>
  </head>
  <body>
  <!--Navbar-->
   <jsp:include page = "/navbar" />
  <!--Login-->
            
   <section class="vh-100">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12 col-md-8 col-lg-6 col-xl-5">
        <div class="card shadow-2-strong" style="border-radius: 1rem;">
          <div class="card-body p-5 text-center">
          <FORM action="../autentica" method ="post"   >

            <h2 class="mb-5">Login</h2>
            <label class="form-label" style="color:red;" for="typeEmailX-2">Nome utente o password errata</label>
            <div class="form-outline mb-4">
              <input required name="username" id="typeEmailX-2" class="form-control form-control-lg" />
              <label class="form-label" for="typeEmailX-2">Nome utente</label>
            </div>

            <div class="form-outline mb-4">
              <input required type="password"  name="password" id="typePasswordX-2" class="form-control form-control-lg" />
              <label class="form-label" for="typePasswordX-2">Password</label>
            </div>


            <button class="btn btn-primary btn-lg btn-block" type="submit">Accedi</button>
          </FORM>
            <hr class="my-4">

            <a href="<%= request.getContextPath() %>/autenticazione/register.jsp" class="text-white btn btn-lg btn-block btn-primary" style="background-color: #dd4b39;"
              type="submit"><i class="fab fa-google me-2"></i> Registrati</a>
       

          </div>
        </div>
      </div>
    </div>
  </div>
</section>
   


      
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

