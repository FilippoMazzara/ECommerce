import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class StampaUserStore extends HttpServlet {

	private Connection connection;
	private PreparedStatement utente;

	public void init(ServletConfig config)
			throws ServletException {
		ConnessioneDB db = new ConnessioneDB();

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

			// tutto
			String queryutente = "SELECT * FROM ecommerce.vistautente"
					+ " WHERE vistautente.iduser=?";

			utente = connection.prepareStatement(queryutente);

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
		String id = (String) request.getParameter("iduserstore");

		try {

			// connessione driver e database

			utente.setString(1, id);

			ResultSet resultUtente = utente.executeQuery();

			while (resultUtente.next()) {
				request.setAttribute("idstore", resultUtente.getString("vistautente.iduser"));
				request.setAttribute("nome", resultUtente.getString("vistautente.nome"));
				request.setAttribute("cognome", resultUtente.getString("vistautente.cognome"));
				request.setAttribute("email", resultUtente.getString("vistautente.email"));
				request.setAttribute("telefono", resultUtente.getString("vistautente.telefono"));
				request.setAttribute("nazionalita", resultUtente.getString("vistautente.nazionalita"));
				request.setAttribute("datanascita", resultUtente.getString("vistautente.datadinascita"));
				request.setAttribute("regione", resultUtente.getString("vistautente.regione"));
				request.setAttribute("citta", resultUtente.getString("vistautente.citta"));
				request.setAttribute("via", resultUtente.getString("vistautente.via"));
				request.setAttribute("civico", resultUtente.getString("vistautente.civico"));
				request.setAttribute("cap", resultUtente.getString("vistautente.cap"));
				request.setAttribute("username", resultUtente.getString("vistautente.username"));
				request.setAttribute("feedback", resultUtente.getString("vistautente.feedback"));
				request.setAttribute("descrizione", resultUtente.getString("vistautente.descrizione"));

			}

			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/userstore/userstore.jsp");
			dispatcher.forward(request, response);

		} catch (SQLException e) {
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
				utente.close();
				connection.close();
			}

		} catch (SQLException e) {
			System.err.println(e.getMessage());

		}

	}
}