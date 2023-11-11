import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class StampaAnnunci extends HttpServlet {

    private Connection connection;
    private PreparedStatement annunci;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        // out.println("<html><head><title> Test di MySQL </title></head><body>");

        // dati per la connesione al database MySQL
        ConnessioneDB db = new ConnessioneDB();

        ResultSet resultAnnunci = null;

        // sessione
        HttpSession sessione = request.getSession(true);

        String id = (String) sessione.getAttribute("IDuser");

        try {

            // connessione driver e database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

            // query
            String queryannunci = "SELECT * FROM prodotto"
                    + " WHERE iduserstore=? and prodottoeliminato=0; ";

            annunci = connection.prepareStatement(queryannunci);

            // itero la il carrello della sessio
            annunci.setString(1, id);
            resultAnnunci = annunci.executeQuery();
            if (resultAnnunci.isBeforeFirst()) {
                while (resultAnnunci.next()) {
                    out.println("<div class=\"py-1 row\">" +
                            "<div  class=\"col-2 \">" + resultAnnunci.getString("idprodotto") + "</div>" +
                            "<div  class=\"col-2 \"><a  href=\"" + request.getContextPath()
                            + "/prodotti/prodotti.jsp?id="
                            + resultAnnunci.getString("idprodotto")
                            + "\">" + resultAnnunci.getString("titolo") + "</a></div>" +
                            "<div  class=\"col-2 \">" + resultAnnunci.getString("prezzo") + " &euro;</div>" +
                            "<div  class=\"col-2 \">" + resultAnnunci.getString("costospedizione") + " &euro;</div>"
                            +
                            "<div  class=\"col-2 \">" + resultAnnunci.getString("quantitadisponibile") + "</div>" +
                            "<div  class=\"col-2 \"><a href=\"" + request.getContextPath()
                            + "/eliminaprodotto?idprodotto="
                            + resultAnnunci.getString("idprodotto") + "\">Elimina</a></div>"
                            +
                            "</div>");

                }
            } else {
                out.println("<div class=\"text-center\">Nessun annuncio pubblicato</div>");
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