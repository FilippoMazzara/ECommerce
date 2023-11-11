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
                 padding-bottom: 50px;
                }

        </style>

       
</head>
<%@ page import="java.servlet.*" %>

<body>
    <% HttpSession sessione = request.getSession(false); 
       String iduser = (String) sessione.getAttribute("IDuser");  
       String idstore = (String) request.getAttribute("idstore");

    %>

     <!--Navbar-->
    <jsp:include page = "/navbar" />



   
   
    <!--Ripilogo ordine-->

    <section class="h-100 ">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col col-lg-13 col-xl-10">
            <div class="card">
            <div class="rounded-top text-white d-flex flex-row" style="background-color: grey; height:200px;">
                <div class="ms-4 mt-5 d-flex flex-column" style="width: 150px;">
                <img src="<%= request.getContextPath() %>/img/immaginiprofili/profile.png"
                    alt="Generic placeholder image" class="rounded-circle img-fluid  mt-4 mb-2"
                    style="width: 150px; z-index: 1">
                <%if ((sessione.getAttribute("UserName") != null) && (iduser.equals(idstore))){ %>
                    <a href="<%= request.getContextPath() %>/modprofilo" type="button" class="btn btn-outline-dark" data-mdb-ripple-color="dark"
                    style="z-index: 1;">
                    Modifica profilo
                    </a>
                <%}%>

                </div>
                <div class="ms-3" style="margin-top: 130px;">
                <h4><%=(String) request.getAttribute("username")%></h4>
                <p><%=(String) request.getAttribute("regione")%>, <%=(String) request.getAttribute("citta")%></p>
                </div>
            </div>
            <div class="p-4 text-black" style="background-color: #f8f9fa;">
                <div class="d-flex justify-content-end text-center py-1">
                <div>
                    <img class="px-1"height="20px" weight="20px" src="<%= request.getContextPath() %>/img/stella.png">
                    <p class="mb-1 h5"><%=(String) request.getAttribute("feedback")%></p>
                    <p class="small text-muted mb-0">Feedback</p>
                </div>
              
                </div>
            </div>
            <div class="card-body p-4 text-black">
                <!--
                <div class="mb-5">
                <p class="lead fw-normal mb-1">Descrizione</p>
                <div class="p-4" style="background-color: #f8f9fa;">
                    <p class="font-italic mb-1"><%=(String) request.getAttribute("descrizione")%></p>
                   
                </div>
                </div>
                -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                <p class="lead fw-normal mb-0">Annunci pubblicati </p>
                
                </div>
                <div class="row">
                 <jsp:include page = "/stampastore" />
                 </div>
                
            </div>
            <div id="recensioni" class="p-4 text-black" style="background-color: #f8f9fa;">
                <p class="lead fw-normal mb-1">Recensioni</p>
                <%if ((sessione.getAttribute("UserName") != null) && !(iduser.equals(idstore))){ %>
                <form action="<%= request.getContextPath() %>/recensione?iduserstore=<%= idstore%>" method="POST">
                    
                     <div class="py-2 rate">
                        <input  class="form-check-input" type="radio" id="star5" name="feedback" value="5" />
                        <label for="star5" title="text">5 </label>
                        <input  class="form-check-input" type="radio" id="star4" name="feedback" value="4" />
                        <label for="star4" title="text">4 </label>
                        <input  class="form-check-input" type="radio" id="star3" name="feedback" value="3" />
                        <label for="star3" title="text">3 </label>
                        <input  class="form-check-input" type="radio" id="star2" name="feedback" value="2" />
                        <label for="star2" title="text">2 </label>
                        <input  class="form-check-input" type="radio" id="star1" name="feedback" value="1" />
                        <label for="star1" title="text">1</label>
                    </div>
                    <div class="py-2"><textarea placeholder="Scrivi una recensione" class="form-control" required id="recensione" name="recensione" rows="4" cols="50"></textarea></div>
                <div class="py-3" ><button  type="submit" class="btn btn-primary">Invia</button></div>
                </form>
                <%}%>

                <div class="py-3">
                        <jsp:include page = "/stamparecensioni" />

                </div>

        

      

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




    
        


</body>
</html>