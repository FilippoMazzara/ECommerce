import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class PubblicaRecensione extends HttpServlet {

	private Connection connection;
	private PreparedStatement recensione;

	public void init(ServletConfig config)
			throws ServletException {
		ConnessioneDB db = new ConnessioneDB();

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

			// tutto
			String queryRecensione = "call ecommerce.inseriscicommento(?, ?, ?, ?, @cid)";

			recensione = connection.prepareStatement(queryRecensione);

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

		// out.println("<html><head><title> Test di MySQL </title></head><body>");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		// dati per la connesione al database MySQL

		HttpSession sessione = request.getSession(true);
		String iduser = (String) sessione.getAttribute("IDuser");
		String idstore = (String) request.getParameter("iduserstore");
		String testo = (String) request.getParameter("recensione");
		String rating = (String) request.getParameter("feedback");
		try {

			// connessione driver e database

			recensione.setString(1, iduser);
			recensione.setString(2, idstore);
			recensione.setString(3, testo);
			recensione.setString(4, rating);

			recensione.executeUpdate();
			String url = request.getHeader("Referer");
			response.sendRedirect(url + "#recensioni");

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