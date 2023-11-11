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
    <!--Navbar-->
    
    <jsp:include page = "/navbar" />
    <!--Search-->
  
    <section class="ricerca">
      <form class="d-flex form-ricerca" method="GET"  action="ricerca.jsp">
        <div class="container">
          <div class="row row-cols-1 row-cols-lg-4 g-4">
            <div class="col">
              <input name="search" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
            </div>
              <div class="col">
              <select name="regione" id="regione" class="form-select" aria-label="Default select example">
                <option value="null" selected>Regione</option>
                <option value="Abruzzo">Abruzzo</option>
                <option value="Basilicata">Basilicata</option>
                <option value="Calabria">Calabria</option>
                <option value="Campania">Campania</option>
                <option value="Emilia Romagna">Emilia Romagna</option>
                <option value="Friuli Venezia Giulia">Friuli Venezia Giulia</option>
                <option value="Lazio">Lazio</option>
                <option value="Liguria">Liguria</option>
                <option value="Lombardia">Lombardia</option>
                <option value="Marche">Marche</option>
                <option value="Molise">Molise</option>
                <option value="Piemonte">Piemonte</option>
                <option value="Puglia">Puglia</option>
                <option value="Sardegna">Sardegna</option>
                <option value="Sicilia">Sicilia</option>
                <option value="Toscana">Toscana</option>
                <option value="Trentino Alto Adige">Trentino Alto Adige</option>
                <option value="Umbria">Umbria</option>
                <option value="Valle d\'Aosta">Valle d'Aosta</option>
                <option value="Veneto">Veneto</option>
              </select>
            </div>
            <div class="col">
              <select name="categoria" class="form-select" aria-label="Default select example">
                <option value="null" <% if (request.getParameter("categoria") == "null"  ){out.println("selected");} %> >Categoria</option>
                <option value="Elettronica" <% if (request.getParameter("categoria").equals("Elettronica")  ){out.println(" selected");} %>>Elettronica</option>
                <option value="Abbigliamento" <% if (request.getParameter("categoria").equals("Abbigliamento")  ){out.println(" selected");} %>>Abbigliamento</option>
                <option value="CD_e_Vinili" <% if (request.getParameter("categoria").equals("CD_e_Vinili")  ){out.println(" selected");} %>>CD e Vinili</option>
                <option value="Giocattoli" <% if (request.getParameter("categoria").equals("Giocattoli")  ){out.println(" selected");} %>>Giocattoli</option>
              </select>
            </div>
            <div class="col">
              <button  class="btn btn-primary" type="submit">Cerca</button>
            </div>
          </div>
        </div>
      </form>
    </section>
    <!--Cards-->

    <div class="card-bg">
        <h1 class="text-center" style="padding: 20px;">Risultati ricerca</h1>
        <div class="container">
            <%
              String nome = request.getParameter("search");
              if (!nome.equals("")){
            
            %>
                  Ricerca per: <%= nome %> &nbsp;

            <% // continue scriptlet
              }
            %>

            <%
              String reg = request.getParameter("regione");
              if (!reg.equals("null")){
            
            %>
                  Regione: <%= reg %> &nbsp;

            <% // continue scriptlet
              }
            %>

            <%
              String cat = request.getParameter("categoria");
              if (!cat.equals("null")){
            
            %>
                  Categoria: <%= cat %> &nbsp;

            <% // continue scriptlet
              }
            %>
            
            <div style="padding-top:20px;" class="row row-cols-1 row-cols-md-3 g-4">
              <jsp:include page = "/search" />
            </div>
        </div>
    </div>

    <div class="card-bg">
        <%if(!request.getParameter("categoria").equals("null")){%>
        <h1 class="text-center" style="padding: 20px;">Prodotti di <%= request.getParameter("categoria")%> consigliati</h1>
        <%}%>

        <div class="container">
            
            
            <div style="padding-top:20px;" class="row row-cols-1 row-cols-md-3 g-4">
              <jsp:include page = "/consigliati" />
            </div>
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