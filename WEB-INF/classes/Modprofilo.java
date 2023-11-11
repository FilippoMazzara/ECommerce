import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class Modprofilo extends HttpServlet {

	private Connection connection;
	private PreparedStatement utente;
	private PreparedStatement pagamento;

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

			String querypagamento = "Select pagamento.carta, pagamento.scadenza, pagamento.titolare  FROM ecommerce.pagamento"
					+ " Where pagamento.iduser=?";

			utente = connection.prepareStatement(queryutente);
			pagamento = connection.prepareStatement(querypagamento);

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
		String id = (String) sessione.getAttribute("IDuser");

		try {

			// connessione driver e database

			utente.setString(1, id);
			pagamento.setString(1, id);

			ResultSet resultUtente = utente.executeQuery();

			while (resultUtente.next()) {
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

			}

			ResultSet resultPagamento = pagamento.executeQuery();

			while (resultPagamento.next()) {
				request.setAttribute("titolare", resultPagamento.getString("pagamento.titolare"));
				request.setAttribute("carta", resultPagamento.getString("pagamento.carta"));
				request.setAttribute("scadenza", resultPagamento.getString("pagamento.scadenza") + "-11");
			}

			RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/profilo/profilo.jsp");
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
				pagamento.close();
				utente.close();
				connection.close();
			}

		} catch (SQLException e) {
			System.err.println(e.getMessage());

		}

	}
}