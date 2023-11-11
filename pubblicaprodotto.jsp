<?xml version = "1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns = "http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">

    <title>Il Mercatino</title>

    <style>
      

      body{
        background: linear-gradient(to bottom, rgba(255, 255, 255, 0.882) 0%, rgb(255, 255, 255) 100%), url("<%= request.getContextPath() %>/img/sfondo.jpg");
      }
    </style>
</head>


<body>
    <!--Navbar-->

 

    <jsp:include page = "/navbar" />


   <!--Cards-->
  
    <div class="container bg-white py-4 mt-5 mb-5">
        <h4>Registrazione prodotto</h4><hr>

        <form name="myform" method="post" action="<%= request.getContextPath() %>/upload" enctype="multipart/form-data">

        
            <div class="row mt-2">
                <div class="col-lg-6">
                  <label>Titolo prodotto</label><br><INPUT class="form-control" required  type="text" name="titolo" placeholder = "titolo"><br>
                  <label>Categoria</label><br>
                    <select required  name="categoria" id="categoria" class="form-control" aria-label="Default select example">
                      <option value="">-- seleziona una --</option>
                      <option value="Elettronica">Elettronica</option>
                      <option value="Abbigliamento">Abbigliamento</option>
                      <option value="Giocattoli">Giocattoli</option>
                      <option value="CD_e_Vinili">CD e Vinili</option>
                    </select><br>

                  <label>Quantita'</label><br><INPUT class="form-control" required  type="number" name="quantita" placeholder = "quantia'"><br>
                  <label>Prezzo</label><br><INPUT class="form-control" required  type="number" step="0.01" name="prezzo" placeholder = "prezzo"><br>
                  <label>Costo spedizione</label><br><INPUT class="form-control" required  type="number" step="0.01" name="spedizione" placeholder = "prezzo"><br>

      

                </div>
            
                <div class="col-lg-6" style="padding-top=10px;">
                      <label>Descrizione</label><br><textarea class="form-control" required id="descrizione" name="descrizione" rows="4" cols="50"></textarea><br> 
                      <label>Foto</label><br><input class="form-control" required type="file" accept="image/*" name="upfile"><br>            
                </div>
            </div>
            
            <div class="row mt-3">
                <div class="col-lg-4">
                <button class="btn btn-primary"  type="submit" value="Invia">Pubblica</button>
                </div>
            </div>
        </form>
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
                <li class="nav-item"><p class="px-2 text-muted">Andrea</p></li>
              </ul>
              <p class="text-center text-muted">&copy; 2021 Company, Inc</p>
            </footer>
          </div>
        </div>
    </footer>



 



  
      

    
</body>
</html>