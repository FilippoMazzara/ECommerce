import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class StampaOrdini extends HttpServlet {

    private Connection connection;
    private PreparedStatement ordine;
    private PreparedStatement itemordine;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        // out.println("<html><head><title> Test di MySQL </title></head><body>");

        // dati per la connesione al database MySQL
        ConnessioneDB db = new ConnessioneDB();

        ResultSet resultOrdine = null;
        ResultSet resultItem = null;
        // sessione
        HttpSession sessione = request.getSession(true);

        String id = (String) sessione.getAttribute("IDuser");

        try {

            // connessione driver e database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

            // query
            String queryordine = "SELECT * FROM ordine"
                    + " WHERE iduser=?; ";

            String queryitemordine = "SELECT * FROM itemordine" +
                    " INNER JOIN prodotto ON prodotto.idprodotto = itemordine.idprodotto "
                    + " WHERE itemordine.idordine=?; ";

            ordine = connection.prepareStatement(queryordine);
            itemordine = connection.prepareStatement(queryitemordine);
            // itero la il carrello della sessio
            ordine.setString(1, id);
            resultOrdine = ordine.executeQuery();

            if (resultOrdine.isBeforeFirst()) {

                while (resultOrdine.next()) {
                    itemordine.setString(1, resultOrdine.getString("idordine"));
                    resultItem = itemordine.executeQuery();
                    String carta = resultOrdine.getString("carta");

                    out.println("<div class=\"row\">" +
                    // apre ordine
                            "<div class=\"col\">" +
                            "<div class=\"card border-dark mb-3\" style=\"max-width: 900px;\">" +
                            "<div class=\"card-header  border-dark text-muted\">" +
                            "<div class=\"row\">" +
                            "<div class=\"col-3\">Data ordine: </div>" +
                            "<div class=\"col-2\">Totale: </div>" +
                            "<div class=\"col-3\">Indirizzo consegna: </div>" +
                            "<div class=\"col-3\">Pagamento carta: </div>" +
                            "</div>" +
                            "<div class=\"row\">" +
                            "<div class=\"col-3\"><strong>" + resultOrdine.getString("dataordine") + "</strong></div>" +
                            "<div class=\"col-2\"><strong>" + resultOrdine.getString("totale")
                            + " &euro;</strong></div>" +
                            "<div class=\"col-3\"><strong>" + resultOrdine.getString("indirizzo") + "</strong></div>"
                            +
                            "<div class=\"col-3\"><strong>**** " + carta.substring(carta.length() - 4, carta.length())
                            + "</strong></div>"
                            +

                            "</div>" +

                            "</div>" +

                            "<div class=\"card-body text-dark\">");
                    while (resultItem.next()) {
                        out.println("<div class=\"card mb-3\" style=\"max-width: 540px;\">" +
                                "<div class=\"row g-0\">" +
                                "<div class=\"col-md-4\">" +
                                "<img src=\"" + request.getContextPath() + "/img/prodotti/"
                                + resultItem.getString("prodotto.immagine")
                                + "\" class=\"img-fluid rounded-start\" alt=\"...\">"
                                +
                                "</div>" +
                                "<div class=\"col-md-8\">" +
                                "<div class=\"card-body\">" +
                                "<a href=\"" + request.getContextPath() + "/prodotti/prodotti.jsp?id="
                                + resultItem.getString("prodotto.idprodotto")
                                + "\"><h5 class=\"card-title\">" + resultItem.getString("prodotto.titolo")
                                + " </h5></a>" +
                                /*
                                 * "<img style=\"height:15x; width:15px;\" src=\"../img/localizzazione.png\"><small class=\"text-muted\">Pippo</small><br>"
                                 * +
                                 * 
                                 */
                                "<small class=\"text-muted\">ID:" + resultItem.getString("prodotto.idprodotto")
                                + " | Q.ta': " + resultItem.getString("itemordine.quantita") + "</small><br>" +

                                "<div class=\"py-3\"><h5><strong>" + resultItem.getString("prodotto.prezzo")
                                + " &euro; </strong></h5></div>" +
                                "</div>" +
                                "</div>" +
                                "</div>" +
                                "<div class=\"text-muted card-footer bg-transparent border-dark\">Stato: <strong>"
                                + resultItem.getString("itemordine.statospedizione") + "</strong></div>"
                                +
                                "</div>");
                        // chiude prodotto

                    }
                    // apre prodotto

                    out.println("</div>" +
                            "</div>" +
                            "</div>" +
                            // chiude ordine

                            "</div>");

                }

            } else {
                out.println("<div class=\"py-3\"><h5>Non ci sono ordini</h5></div>");
            }

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
        } finally { // eseguita sempre a meno che non venga chiamato exit()
            try {
                if (connection != null) {
                    // chiusura finale della connessione con il database
                    connection.close();
                }

            } catch (SQLException e) {
                System.err.println(e.getMessage());
            }
        }
        // out.println("</body></html>");

    }
}