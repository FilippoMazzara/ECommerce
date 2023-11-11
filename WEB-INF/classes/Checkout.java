import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class Checkout extends HttpServlet {

        private Connection connection;
        private PreparedStatement prodotti;
        private PreparedStatement utente;
        private PreparedStatement pagamento;

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                // out.println("<html><head><title> Test di MySQL </title></head><body>");

                // dati per la connesione al database MySQL
                ConnessioneDB db = new ConnessioneDB();

                ResultSet resultSet = null;
                ResultSet resultSet1 = null;
                ResultSet resultSet2 = null;

                // sessione
                HttpSession sessione = request.getSession(true);
                // costo totale
                String costoTotale = null;
                // carrello sessione

                String id = (String) sessione.getAttribute("IDuser");

                try {

                        // connessione driver e database
                        Class.forName("com.mysql.jdbc.Driver");
                        connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

                        // query
                        String queryCarrello = "SELECT * FROM prodotto "
                                        + " INNER JOIN itemcarrello ON prodotto.idprodotto = itemcarrello.idprodotto"
                                        + " INNER JOIN carrello ON carrello.idcarrello = itemcarrello.idcarrello"

                                        + " WHERE itemcarrello.idcarrello=?; ";

                        String queryUtente = "SELECT * FROM ecommerce.vistautente"
                                        + " WHERE vistautente.iduser=?";

                        String queryPagamento = "Select * FROM ecommerce.pagamento"
                                        + " Where pagamento.iduser=?";

                        utente = connection.prepareStatement(queryUtente);
                        pagamento = connection.prepareStatement(queryPagamento);
                        prodotti = connection.prepareStatement(queryCarrello);

                        // itero la il carrello della sessio
                        prodotti.setString(1, id);
                        pagamento.setString(1, id);
                        utente.setString(1, id);

                        // prodotti
                        resultSet = prodotti.executeQuery();

                        // utenti
                        resultSet1 = utente.executeQuery();
                        // pagamento
                        resultSet2 = pagamento.executeQuery();

                        out.println("<div class=\"row g-5\">" +
                                        "<h2>Checkout</h2>" +

                                        "<div class=\"col-md-5 col-lg-4 order-md-last\">" +
                                        "<h4 class=\"d-flex justify-content-between align-items-center mb-3\">" +
                                        "<span class=\"\">Il tuo carrello</span>" +

                                        "</h4>" +
                                        "<ul class=\"list-group mb-3\">");

                        while (resultSet.next()) {
                                // mi stampo le card dei prodotti
                                Integer quantita = Integer.parseInt(resultSet.getString("itemcarrello.quantita"));
                                costoTotale = resultSet.getString("carrello.costototale");

                                out.println(
                                                "<li class=\"list-group-item d-flex justify-content-between lh-sm\">" +
                                                                "<div>" +
                                                                "<h6 class=\"my-0\">"
                                                                + resultSet.getString("prodotto.titolo") + "</h6>" +
                                                                "<small class=\"text-muted\">Quantita': "
                                                                + resultSet.getString("itemcarrello.quantita")
                                                                + "</small>" +
                                                                "</div>" +
                                                                "<span class=\"text-muted\">"
                                                                + resultSet.getString("prodotto.prezzo")
                                                                + "&euro; +"
                                                                + resultSet.getString("prodotto.costospedizione")
                                                                + "&euro;</span>"

                                                                // +
                                                                // "<span class=\"text-muted\">+" +
                                                                // resultSet.getString("prodotto.costospedizione")
                                                                // + "&euro;</span>"
                                                                + "</li>");

                        }
                        out.println(
                                        "<li class=\"list-group-item d-flex justify-content-between\">" +
                                                        "<span>Totale: </span>" +
                                                        "<strong>" + costoTotale
                                                        + "&euro;</strong>" +
                                                        "</li>" +
                                                        "</ul>" +
                                                        "</div>"

                        );
                        if (resultSet1.next()) {

                                out.println("<div class=\"col-md-7 col-lg-8\">" +
                                                "<h4 class=\"mb-3\">Indirizzo</h4>"
                                                +

                                                "<div class=\"row g-3\">" +
                                                "<div class=\"col-lg-3\">" +
                                                "<label for=\"firstName\" class=\"form-label\"><strong>Nome:</strong></label>"
                                                +
                                                "<p>" + resultSet1.getString("vistautente.nome") + "</p>"
                                                +
                                                "</div>" +

                                                "<div class=\"col-lg-3\">" +
                                                "<label for=\"lastName\" class=\"form-label\"><strong>Cognome:</strong></label><p>"
                                                +
                                                resultSet1.getString("vistautente.cognome")
                                                +
                                                "</p></div>" +

                                                "<div class=\"col-lg-3\">" +
                                                "<label for=\"address\" class=\"form-label\"><strong>Indirizzo:</strong></label>"
                                                +
                                                "<p>" + resultSet1.getString("vistautente.via") + "</p>"
                                                +
                                                "</div>" +

                                                "<div class=\"col-lg-3\">" +
                                                "<label for=\"address\" class=\"form-label\"><strong>N. Civico:</strong></label>"
                                                +
                                                "<p>" + resultSet1.getString("vistautente.civico") + "</p>"
                                                +
                                                "</div>" +

                                                "<div class=\"col-lg-3\">" +
                                                "<label for=\"address\" class=\"form-label\"><strong>Regione:</strong></label>"
                                                +
                                                "<p>" + resultSet1.getString("vistautente.regione") + "</p>"
                                                +
                                                "</div>" +

                                                "<div class=\"col-lg-3\">" +
                                                "<label for=\"address\" class=\"form-label\"><strong>CAP:</strong></label>"
                                                +
                                                "<p>" + resultSet1.getString("vistautente.cap") + "</p>"
                                                +
                                                "</div>" +

                                                "</div>");

                        }

                        out.println("<form action=\"" + request.getContextPath()
                                        + "/modprofilo\" method=\"GET\" ><button type=\"submit\" class=\"btn btn-secondary\">Modifica dati</button></form>"
                                        +
                                        "<hr class=\"my-4\">");

                        if (resultSet2.next()) {

                                out.println(
                                                "<h4 class=\"mb-3\">Pagamento</h4>"
                                                                +

                                                                "<div class=\"row gy-3\">" +
                                                                " <div class=\"col-md-3\">" +
                                                                "<label for=\"cc-number\" class=\"form-label\"><strong>Titolare carta:</strong></label>"
                                                                +
                                                                "<p>" + resultSet2.getString("pagamento.titolare")
                                                                + "</p>" +
                                                                "</div>" +

                                                                "<div class=\"col-md-3\">" +
                                                                "<label for=\"cc-number\" class=\"form-label\"><strong>Numero carta:</strong></label>"
                                                                +
                                                                "<p>" + resultSet2.getString("pagamento.carta") + "</p>"
                                                                +
                                                                "</div>" +

                                                                "<div class=\"col-md-3\">" +
                                                                "<label for=\"cc-number\" class=\"form-label\"><strong>Data scadenza:</strong></label>"
                                                                +
                                                                "<p>" + resultSet2.getString("pagamento.scadenza")
                                                                + "</p>" +
                                                                "</div>" +
                                                                "</div>"

                                );

                        }

                        String indirizzoCompleto = resultSet1.getString("vistautente.via") + " "
                                        + resultSet1.getString("vistautente.civico") + " "
                                        + resultSet1.getString("vistautente.cap");

                        String idpagamento = resultSet2.getString("pagamento.idpagamento");

                        out.println(
                                        "<form action=\"" + request.getContextPath()
                                                        + "/modprofilo\" method=\"GET\"><button type=\"submit\" class=\"btn btn-secondary\">Modifica dati</button></form><hr class=\"my-4\">"
                                                        +

                                                        "<form action=\"" + request.getContextPath()
                                                        + "/conferma?idpagamento="
                                                        + idpagamento + "&indirizzo="
                                                        + indirizzoCompleto
                                                        + "\" method=\"POST\" ><button class=\" btn btn-primary btn-lg\" type=\"submit\">Checkout</button></form>"
                                                        +

                                                        "</div></h1>");

                } catch (SQLException e) {
                        // in caso di errore della query fai questo:
                        System.err.println("SQL Problem: " + e.getMessage());
                        System.err.println("SQL State: " + e.getSQLState());
                        System.err.println("Error: " + e.getErrorCode());
                        out.println("<h4>Non e' stato trovato alcun risultato (Problema database) </h4><br>");
                        out.println("<p>problema: " + e.getMessage() + " </p>");
                        // System.exit(1);

                }
                // connect to database
                catch (ClassNotFoundException e) {
                        System.err.println("Non trovo il driver" + e.getMessage());
                        out.println("<h2>ERRORE!!!</h2><br>");
                        out.println("<h4>" + e.getMessage() + "</h4>");
                } finally { // eseguita sempre a meno che non venga chiamato exit()
                        try {
                                if (connection != null) {
                                        // chiusura finale della connessione con il database
                                        connection.close();
                                }

                        } catch (SQLException e) {
                                System.err.println(e.getMessage());
                                out.println("<h2>ERRORE!!!</h2><br>");
                                out.println("<h4>" + e.getMessage() + "</h4>");
                        }
                }
                // out.println("</body></html>");

        }
}