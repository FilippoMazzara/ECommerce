import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class Updateutente extends HttpServlet {

	private Connection connection;
	private PreparedStatement updateutente;
	private PreparedStatement updateindirizzo;

	public void init(ServletConfig config)
			throws ServletException {
		ConnessioneDB db = new ConnessioneDB();

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

			// QUERY
			String queryupdate1 = "UPDATE ecommerce.utente " +
					" SET utente.telefono=?,utente.nazionalita=?,utente.nome=?,utente.cognome=?,utente.username=?,utente.datadinascita=? "
					+ " WHERE iduser = ? ";

			String queryupdate2 = "UPDATE ecommerce.indirizzo " +
					"SET indirizzo.via=?,indirizzo.civico=?, indirizzo.cap=?, indirizzo.regione=?, indirizzo.citta=?"
					+ "WHERE iduser = ?";

			updateutente = connection.prepareStatement(queryupdate1);
			updateindirizzo = connection.prepareStatement(queryupdate2);

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
		String datanascita = request.getParameter("nascita");
		String cognome = request.getParameter("cognome");
		String username = request.getParameter("username");
		String nome = request.getParameter("nome");
		String cellulare = request.getParameter("telefono");
		String via = request.getParameter("via");
		String civico = request.getParameter("civico");
		String cap = request.getParameter("cap");
		String nazionalita = request.getParameter("nazionalita");
		String regione = request.getParameter("regione");
		String citta = request.getParameter("citta");

		try {
			// out.println("modifica profilo");
			updateutente.setString(1, cellulare);
			updateutente.setString(2, nazionalita);
			updateutente.setString(3, nome);
			updateutente.setString(4, cognome);
			updateutente.setString(5, username);
			updateutente.setString(6, datanascita);
			updateutente.setString(7, id);

			updateindirizzo.setString(1, via);
			updateindirizzo.setString(2, civico);
			updateindirizzo.setString(3, cap);
			updateindirizzo.setString(4, regione);
			updateindirizzo.setString(5, citta);
			updateindirizzo.setString(6, id);

			updateutente.executeUpdate();
			updateindirizzo.executeUpdate();

			response.sendRedirect(request.getContextPath() + "/modprofilo");

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
