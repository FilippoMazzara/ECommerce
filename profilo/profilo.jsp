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

       
</head>
<body>



    <jsp:include page = "/navbar" />



    
        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row mt-2">
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img class="rounded-circle mt-5" width="150px" src="<%= request.getContextPath() %>/img/immaginiprofili/profile.png"><span class="font-weight-bold"><%=(String) request.getAttribute("username")%></span><span class="text-black-50"><%=(String) request.getAttribute("email")%></span><span> </span></div>
                </div>
                <div class="col-md-5 border-right">
                <FORM class="" action="<%= request.getContextPath() %>/updateutente" method="POST" >
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Impostazioni profilo</h4>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-12"><label class="labels">Username</label><input required name="username" type="text" class="form-control" placeholder="" value="<%=(String) request.getAttribute("username")%>"></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6"><label class="labels">Nome</label><input required name="nome" type="text" class="form-control" placeholder="" value="<%=(String) request.getAttribute("nome")%>"></div>
                            <div class="col-md-6"><label class="labels">Cognome</label><input required name="cognome" type="text" class="form-control" placeholder="" value="<%=(String) request.getAttribute("cognome")%>" ></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12"><label class="labels">Cellulare</label><input required name="telefono" type="number" class="form-control" placeholder="num telefono" value="<%=(String) request.getAttribute("telefono")%>"></div>
                            <div class="col-md-12"><label class="labels">Indirizzo</label><input required name="via" type="text" class="form-control" placeholder="Indirizzo" value="<%=(String) request.getAttribute("via")%>"></div>
                            <div class="col-md-12"><label class="labels">Numero civico</label><input required name="civico" type="number" class="form-control" placeholder="Num civico" value="<%=(String) request.getAttribute("civico")%>"></div>
                            <div class="col-md-12"><label class="labels">CAP</label><input required name="cap" type="number" class="form-control" placeholder="CAP" value="<%=(String) request.getAttribute("cap")%>"></div>
                        </div>
                        <div class="row mt-3">
                        <div class="col-md-12"><label class="labels">Nazionalita</label><input required name="nazionalita" type="text" class="form-control" placeholder="Nazione" value="<%=(String) request.getAttribute("nazionalita")%>"></div>
                        <div class="col-md-12"><label class="labels">Data di nascita</label><input required name="nascita" type="date" class="form-control" placeholder="Compleanno" value="<%=(String) request.getAttribute("datanascita")%>"></div>
                            <div class="col-md-12"><label class="labels">Regione</label><input required name="regione" type="text" class="form-control" placeholder="Regione" value="<%=(String) request.getAttribute("regione")%>"></div>
                            <div class="col-md-12"><label class="labels">Citta</label><input required name="citta" type="text" class="form-control" placeholder="Citta" value="<%=(String) request.getAttribute("citta")%>"></div>
                        </div>
                        <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="submit">Save Profile</button></div>
                    </div>
                </FORM>    
                </div>
               
               
                <div class="col-md-4">

                        <FORM class="" action="<%= request.getContextPath() %>/updatepagamento" method ="POST" >
                                    <div class="p-3 py-5">
                                        <div class="d-flex justify-content-between align-items-center experience"><span><h4>Metodo pagamento</h4></span></div><br>
                                        <div class="col-md-12"><label class="labels">Nome proprietario</label><input required name="titolare" type="text" class="form-control" placeholder="Proprietario" value="<%=(String) request.getAttribute("titolare")%>"></div> <br>
                                        <div class="col-md-12"><label class="labels">Numero carta</label><input required name="carta" type="number" class="form-control" placeholder="Numero carta" value="<%=(String) request.getAttribute("carta")%>"></div> <br>
                                        <div class="col-md-12"><label class="labels">Data scadenza</label><input required name="scadenza" type="month" class="form-control" placeholder="Data scadenza" value="<%=(String) request.getAttribute("scadenza")%>"></div>
                                    </div>
                                    <div class="mt-2 text-center"><button class="btn btn-primary profile-button" type="submit">Salva metodo di pagamento</button></div>

                        </FORM>
                </div>
                

            </div>
        </div>
        </div>
        </div>
    


</body>
</html>