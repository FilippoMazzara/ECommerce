import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class ConfermaOrdine extends HttpServlet {

    private Connection connection;
    private PreparedStatement ordine;

    public void init(ServletConfig config)
            throws ServletException {
        ConnessioneDB db = new ConnessioneDB();

        try {

            // connessione driver e database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

            // QUERY
            String queryordine = "call ecommerce.checkout1(?, ?, ?, @ord);";

            ordine = connection.prepareStatement(queryordine);

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

        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        HttpSession sessione = request.getSession(false);
        ordina(sessione, (String) request.getParameter("idpagamento"), (String) request.getParameter("indirizzo"));

        response.sendRedirect("" + request.getContextPath() + "/ordine/confermaordine.jsp");

    }

    public synchronized void ordina(HttpSession sessione, String idpagamento, String indirizzo) {

        try {

            ordine.setString(1, (String) sessione.getAttribute("IDuser"));
            ordine.setString(2, idpagamento);
            ordine.setString(3, indirizzo);

            ordine.executeUpdate();

        } catch (SQLException e) {
            // in caso di errore della query fai questo:
            System.err.println("SQL Problem: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error: " + e.getErrorCode());
            // out.println("<h4>" + e.getMessage() + " </h4>");
            // System.exit(1);
        }

    }

    public void destroy() {
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