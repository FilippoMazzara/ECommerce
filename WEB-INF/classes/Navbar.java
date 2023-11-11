import java.io.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

import beans.*;

public class Navbar extends HttpServlet {

    private Connection connection;
    private PreparedStatement statement;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // dati per la connesione al database MySQL

        ConnessioneDB db = new ConnessioneDB();

        HttpSession sessione = request.getSession(true);
        String id = (String) sessione.getAttribute("IDuser");

        Carrello carrello;
        String quantitaCarrello = "0";

        if (sessione.getAttribute("carrello") != null) {
            carrello = (Carrello) sessione.getAttribute("carrello");
            quantitaCarrello = carrello.getQuantita();
        }

        if (sessione.getAttribute("IDuser") == null) {
            out.println("<nav class=\"navbar navbar-dark bg-dark \">" +
                    "<div class=\"container-fluid\">" +
                    "<a href=\"" + request.getContextPath() + "\" class=\"navbar-brand\">Il Mercatino</a>" +
                    "<div class=\"my-2 my-lg-0 d-flex\">" +

                    "<a href=\"" + request.getContextPath()
                    + "/pubblicaprodotto.jsp\" class=\"text-black btn btn-warning  me-2\">Pubblica annuncio</a>"
                    +
                    "<a href=\"" + request.getContextPath()
                    + "/login/login.jsp\"><button type=\"button\" class=\"btn btn-outline-light me-2\">Login</button></a>"
                    +
                    "<a href=\"" + request.getContextPath()
                    + "/autenticazione/register.jsp\"><button type=\"button\" class=\"text-black btn btn-warning\">Sign-up</button>"
                    +
                    "<a class=\"px-2 py-1\" href=\"" + request.getContextPath()
                    + "/carrello/carrello.jsp\"><img  src=\"" + request.getContextPath()
                    + "/img/carrello.png\" height=\"30px\" width=\"30px\" alt=\"\"></a>"
                    +
                    "<p class=\"text-center\" style=\"background-color: white; border-radius: 25px; height:25px; width:25px;\">"
                    + quantitaCarrello + "</p>"
                    +
                    "</div>" +
                    "</div>" +
                    "</nav>");
        } else {
            try {

                // connessione driver e database
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

                // query
                String query = "SELECT numeroarticoli FROM carrello "
                        + " WHERE carrello.iduser=?; ";

                statement = connection.prepareStatement(query);
                // itero la il carrello della sessio
                statement.setString(1, id);

                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {

                    out.println("<nav class=\"navbar navbar-dark bg-dark \">" +
                            "<div class=\"container-fluid\">" +
                            "<a href=\"" + request.getContextPath() + "\" class=\"navbar-brand\">Il Mercatino</a>" +
                            "<div class=\"my-2 my-lg-0 d-flex\">" +
                            "<a href=\"" + request.getContextPath() + "/store?iduserstore="
                            + sessione.getAttribute("IDuser")
                            + "\" class=\"px-2 py-1\" ><img src=\"" + request.getContextPath()
                            + "/img/immaginiprofili/profile.png\" height=\"30px\" width=\"30px\" alt=\"\"></a>"
                            +

                            "<div class=\"py-1 dropdown\">" +
                            "<a  class=\"text-white dropdown-toggle navbar-brand\">"
                            + sessione.getAttribute("UserName") + "</a>" +
                            "<div class=\"dropdown-content\">" +
                            "<a href=\"" + request.getContextPath() + "/store?iduserstore="
                            + sessione.getAttribute("IDuser")
                            + "\">Profilo</a>" +
                            "<a href=\"" + request.getContextPath() + "/annunciutente/annunci.jsp\">I miei annunci</a>"
                            +
                            "<a href=\"" + request.getContextPath() + "/logout\">Logout</a>" +
                            "</div>" +
                            "</div>"

                            +
                            "<a href=\"" + request.getContextPath()
                            + "/pubblicaprodotto.jsp\" type=\"button\" class=\"text-black btn btn-warning  me-2\">Pubblica annuncio</a>"
                            +
                            "<a href=\"" + request.getContextPath()
                            + "/ordiniutente/ordini.jsp\" type=\"button\" class=\"text-black btn btn-warning me-2\">I miei ordini</a>"
                            +

                            "<a class=\"px-2 py-1\" href=\"" + request.getContextPath()
                            + "/carrello/carrello2.jsp\"><img  src=\"" + request.getContextPath()
                            + "/img/carrello.png\" height=\"30px\" width=\"30px\" alt=\"\"></a>"
                            +
                            "<p class=\"text-center\" style=\"background-color: white; border-radius: 25px; height:25px; width:25px;\">"
                            + resultSet.getString("numeroarticoli") + "</p>"
                            +
                            "</div>" +
                            "</div>" +
                            "</nav>");

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

        }
    }
}