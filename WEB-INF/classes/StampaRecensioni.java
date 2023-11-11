import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class StampaRecensioni extends HttpServlet {

	private Connection connection;
	private PreparedStatement recensione, utente;

	public void init(ServletConfig config)
			throws ServletException {
		ConnessioneDB db = new ConnessioneDB();

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

			// tutto
			String queryRecensione = "SELECT * FROM commenti WHERE commenti.iduserstore=?";
			String queryUtente = "SELECT * FROM utente WHERE iduser=?";

			recensione = connection.prepareStatement(queryRecensione);
			utente = connection.prepareStatement(queryUtente);

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

		// out.println("<html><head><title> Test di MySQL </title></head><body>");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		// dati per la connesione al database MySQL

		HttpSession sessione = request.getSession(true);

		String idstore = (String) request.getParameter("iduserstore");

		try {

			// connessione driver e database

			recensione.setString(1, idstore);

			ResultSet risultato = recensione.executeQuery();
			if (risultato.isBeforeFirst()) {
				while (risultato.next()) {
					utente.setString(1, risultato.getString("commenti.iduser"));
					ResultSet user = utente.executeQuery();
					if (user.next()) {
						out.println("<div class=\"py-1 px-4 row\">" +
								"<div class=\"col\">" +
								"<strong>" + risultato.getString("commenti.feedback")
								+ " | <a href=\"" + request.getContextPath() + "/store?iduserstore="
								+ user.getString("iduser") + "\">"
								+ user.getString("username") + "</a></strong>" +
								"</div>" +
								"<div class=\"row\">" +
								"<p>" + risultato.getString("commenti.testo")
								+ "</p>" +
								"</div>" +
								"</div>");
					}

				}

			} else {
				out.println("<div class=\"text-center\">Nessuna recensione</div>");
			}

		} catch (

		SQLException e) {
			// in caso di errore della query fai questo:
			System.err.println("SQL Problem: " + e.getMessage());
			System.err.println("SQL State: " + e.getSQLState());
			System.err.println("Error: " + e.getErrorCode());
			out.println("<h4>" + e.getMessage() + " </h4>");
			// System.exit(1);

		}
		// connect to database

	}

	public void destroy() {
		try {
			if (connection != null) {
				// chiusura finale della connessione con il database
				recensione.close();
				connection.close();
			}

		} catch (SQLException e) {
			System.err.println(e.getMessage());

		}

	}
}