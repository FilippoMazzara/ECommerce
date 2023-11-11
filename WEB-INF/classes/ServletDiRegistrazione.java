import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class ServletDiRegistrazione extends HttpServlet {

	private Connection connection;
	private PreparedStatement pStatement;
	private PreparedStatement pStatement2;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// out.println("<html><head><title> Test di MySQL </title></head><body>");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		// dati per la connesione al database MySQL
		ConnessioneDB db = new ConnessioneDB();

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(),
					db.getUser(), db.getPassword());

			// prendo i parametri dichiarati in register.jsp (la parte della ricerca)
			String nomeutente = request.getParameter("username");
			String pwd = request.getParameter("password");
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			String email = request.getParameter("email");
			String cellulare = request.getParameter("cellulare");
			String nazionalita = request.getParameter("nazionalita");
			String via = request.getParameter("via");
			String civico = request.getParameter("civico");
			String cap = request.getParameter("cap");
			String regione = request.getParameter("regione");
			String citta = request.getParameter("citta");
			String compleanno = request.getParameter("compleanno");

			// pagamento carta
			String titolare = request.getParameter("titolare");
			String carta = request.getParameter("carta");
			String scadenza = request.getParameter("scadenza");

			// query
			String queryutente = "CALL ecommerce.registrazione_completa(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, @uid);";
			// String querypagamento = "call ecommerce.salvapagamento(?,?,?,?,?, @pid)";

			pStatement = connection.prepareStatement(queryutente);

			pStatement.setString(1, nome);
			pStatement.setString(2, cognome);
			pStatement.setString(3, email);
			pStatement.setString(4, nomeutente);
			pStatement.setString(5, pwd);
			pStatement.setString(6, cellulare);
			pStatement.setString(7, nazionalita);
			pStatement.setString(8, compleanno);
			pStatement.setString(9, regione);
			pStatement.setString(10, citta);
			pStatement.setString(11, cap);
			pStatement.setString(12, via);
			pStatement.setString(13, civico);
			pStatement.setString(14, "/img/immaginiprofilo/profile.png");
			pStatement.setString(15, carta);
			pStatement.setString(16, scadenza + "-11");
			pStatement.setString(17, titolare);

			pStatement.execute();

		} catch (SQLException e) {
			// in caso di errore della query fai questo:
			out.println("SQL Problem: " + e.getMessage() + " ");
			out.println("<h4>" + e.getMessage() + " </h4>");

			// System.exit(1);

		}
		// connect to database
		catch (ClassNotFoundException e) {
			System.err.println("Non trovo il driver" + e.getMessage());
			out.println("<h2>ERRORE!!!</h2><br>");
			out.println("<h4>" + e.getMessage() + " </h4>");

		} finally { // eseguita sempre a meno che non venga chiamato exit()
			try {
				if (connection != null) {
					// chiusura finale della connessione con il database
					connection.close();
					// redirezione alla pagina
					response.sendRedirect(request.getContextPath());
				}

			} catch (SQLException e) {
				System.err.println(e.getMessage());
				out.println("<h2>ERRORE!!!</h2><br>");
				out.println("<h4>" + e.getMessage() + " </h4>");

			}
		}

	}
}