import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class StampaVendite extends HttpServlet {

    private Connection connection;
    private PreparedStatement vendite;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        // out.println("<html><head><title> Test di MySQL </title></head><body>");

        // dati per la connesione al database MySQL
        ConnessioneDB db = new ConnessioneDB();

        ResultSet resultVendite = null;

        // sessione
        HttpSession sessione = request.getSession(true);

        String id = (String) sessione.getAttribute("IDuser");

        try {

            // connessione driver e database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

            // query
            String queryvendite = "SELECT * FROM itemordine "
                    + " INNER JOIN prodotto ON prodotto.idprodotto = itemordine.idprodotto "
                    + " INNER JOIN ordine ON ordine.idordine = itemordine.idordine " +
                    " INNER JOIN vistautente ON ordine.iduser = vistautente.iduser  "
                    + " WHERE prodotto.iduserstore=?; ";

            vendite = connection.prepareStatement(queryvendite);

            // itero la il carrello della sessio
            vendite.setString(1, id);
            resultVendite = vendite.executeQuery();
            if (resultVendite.isBeforeFirst()) {
                while (resultVendite.next()) {
                    String indirizzo = resultVendite.getString("vistautente.via") + " "
                            + resultVendite.getString("vistautente.civico") + ", "
                            + resultVendite.getString("vistautente.citta") + " " +
                            resultVendite.getString("vistautente.cap");
                    out.println(

                            "<div class=\"py-1 row\">" +
                                    "<div  class=\"col-2 resp\">" + resultVendite.getString("prodotto.idprodotto")
                                    + "</div>" +
                                    "<div  class=\"col-2 resp\"><a href=\"" + request.getContextPath()
                                    + "/prodotti/prodotti.jsp?id="
                                    + resultVendite.getString("prodotto.idprodotto")
                                    + "\">" + resultVendite.getString("prodotto.titolo")
                                    + "</a></div>" +
                                    "<div  class=\"col-2 resp\"><a href=\"" + request.getContextPath()
                                    + "/store?iduserstore="
                                    + resultVendite.getString("vistautente.iduser") + "\">"
                                    + resultVendite.getString("vistautente.username")
                                    + "</a></div>" +
                                    "<div  class=\"col-3 resp\">" + indirizzo
                                    + "</div>" +
                                    "<div  class=\"col-2 resp\">" + resultVendite.getString("ordine.dataordine")
                                    + "</div>" +
                                    "</div>"

                    );

                }
            } else {
                out.println("<div class=\"text-center\">Nessun prodotto venduto</div>");

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