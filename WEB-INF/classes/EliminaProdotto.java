import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class EliminaProdotto extends HttpServlet {

	private Connection connection;
	private PreparedStatement prodotti;

	public void init(ServletConfig config)
			throws ServletException {
		ConnessioneDB db = new ConnessioneDB();

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

			// QUERY
			String queryprodotti = "UPDATE ecommerce.prodotto SET prodotto.prodottoeliminato=1 "
					+ "WHERE iduserstore = ? AND idprodotto=?";

			prodotti = connection.prepareStatement(queryprodotti);

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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		// dati per la connesione al database MySQL

		HttpSession sessione = request.getSession(true);
		String iduser = (String) sessione.getAttribute("IDuser");

		// prendo i parametri dichiarati in profilo.jsp (la parte del profilo)
		String idprodotto = request.getParameter("idprodotto");

		try {

			prodotti.setString(1, iduser);
			prodotti.setString(2, idprodotto);

			prodotti.executeUpdate();
			String url = request.getHeader("Referer");
			response.sendRedirect(url);

		} catch (SQLException e) {
			// in caso di errore della query fai questo:
			System.err.println("SQL Problem: " + e.getMessage());
			System.err.println("SQL State: " + e.getSQLState());
			System.err.println("Error: " + e.getErrorCode());
			out.println("<h4>" + e.getMessage() + " </h4>");
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
