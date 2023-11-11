import java.io.IOException;

import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import beans.*;

/**
 * Servlet implementation class S2
 */

public class ServletDiCarrello extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ServletDiCarrello() {
        super();
        // TODO Auto-generated constructor stub
    }

    private Connection connection;
    private PreparedStatement pStatemant;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub

        // dati per la connesione al database MySQL
        ConnessioneDB db = new ConnessioneDB();

        HttpSession sessione = request.getSession(true);
        String id = request.getParameter("id");

        if (sessione.getAttribute("UserName") == null) {
            Carrello carrello = new Carrello();
            if (sessione.getAttribute("carrello") != null) {
                carrello = (Carrello) sessione.getAttribute("carrello");
            }

            carrello.addItem(id);
            sessione.setAttribute("carrello", carrello);
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer);
        } else {

            try {

                // connessione driver e database
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

                // query
                String query = "call ecommerce.inseriscinelcarrello(?, ?, 1);";

                pStatemant = connection.prepareStatement(query);

                pStatemant.setString(1, (String) sessione.getAttribute("IDuser"));
                pStatemant.setString(2, (String) id);

                pStatemant.executeUpdate();

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

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub

    }

}
