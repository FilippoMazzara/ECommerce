import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.*;

/**
 * Servlet per eliminare item
 */

public class EliminaItemC extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection connection;
    private PreparedStatement statement;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // out.println("<html><head><title> Test di MySQL </title></head><body>");

        // dati per la connesione al database MySQL

        ConnessioneDB db = new ConnessioneDB();

        ResultSet resultSet = null;
        // sessione
        HttpSession sessione = request.getSession(true);
        String idprodotto = request.getParameter("id");
        String iduser = (String) sessione.getAttribute("IDuser");

        // carrello sessione

        String query = "CALL ecommerce.eliminadalcarrello(?,?);";

        if (sessione.getAttribute("UserName") == null) {
            Carrello carrello = (Carrello) sessione.getAttribute("carrello");

            carrello.eliminaItem(idprodotto);

            sessione.setAttribute("carrello", carrello);

            String referer = request.getHeader("Referer");
            response.sendRedirect(referer);

        } else {

            try {
                // connessione driver e database
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());
                // query

                statement = connection.prepareStatement(query);

                statement.setString(1, idprodotto);
                statement.setString(2, iduser);
                // itero la il carrello della sessio
                statement.executeUpdate();

            } catch (SQLException e) {
                // in caso di errore della query fai questo:
                System.err.println("SQL Problem: " + e.getMessage());
                System.err.println("SQL State: " + e.getSQLState());
                System.err.println("Error: " + e.getErrorCode());
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
                        String referer = request.getHeader("Referer");
                        response.sendRedirect(referer);
                    }

                } catch (SQLException e) {
                    System.err.println(e.getMessage());
                }
            }

        }

    }

}
