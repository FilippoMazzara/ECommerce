import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class Updatepagamento extends HttpServlet {

	private Connection connection;
	private PreparedStatement updatepagamento;

	public void init(ServletConfig config)
			throws ServletException {
		ConnessioneDB db = new ConnessioneDB();

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

			// QUERY
			String queryupdate = "UPDATE ecommerce.pagamento " +
					"SET pagamento.titolare=?, pagamento.carta=?, pagamento.scadenza=?"
					+ " WHERE iduser=?";

			updatepagamento = connection.prepareStatement(queryupdate);

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
		PrintWriter out = response.getWriter();

		// dati per la connesione al database MySQL

		HttpSession sessione = request.getSession(true);
		String id = (String) sessione.getAttribute("IDuser");

		// prendo i parametri dichiarati in profilo.jsp (la parte del profilo)
		String titolare = request.getParameter("titolare");
		String carta = request.getParameter("carta");
		String datascadenza = request.getParameter("scadenza");

		try {
			// out.println("modifica profilo");
			updatepagamento.setString(1, titolare);
			updatepagamento.setString(2, carta);
			updatepagamento.setString(3, datascadenza + "-11");
			updatepagamento.setString(4, id);

			updatepagamento.executeUpdate();

			response.sendRedirect("" + request.getContextPath() + "/modprofilo");

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