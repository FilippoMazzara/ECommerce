import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Iterator;

import beans.*;

public class ServletDiAutenticazione extends HttpServlet {

	private Connection connection;
	private PreparedStatement IDuser;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		// out.println("<html><head><title> Test di MySQL </title></head><body>");

		// dati per la connesione al database MySQL
		ConnessioneDB db = new ConnessioneDB();

		ResultSet resultSet = null;

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

			String user = request.getParameter("username");
			String pwd = request.getParameter("password");

			// query
			String query = "SELECT * FROM utente WHERE username=? AND psw=md5(?)";

			IDuser = connection.prepareStatement(query);
			IDuser.setString(1, user);
			IDuser.setString(2, pwd);

			resultSet = IDuser.executeQuery();

			HttpSession sessione = request.getSession(true);

			if (resultSet.next() != false) {
				Carrello carrello = (Carrello) sessione.getAttribute("carrello");

				if (sessione.getAttribute("IDuser") == null) {
					// invalidazione e creazione di una nuova sessione
					sessione.invalidate();
					sessione = request.getSession(true);
					sessione.setAttribute("IDuser", resultSet.getString("iduser"));
					sessione.setAttribute("UserName", resultSet.getString("username"));

					// trasferimento di carrello sul db dell'utente
					if (carrello != null) {

						query = "call ecommerce.inseriscinelcarrello(?, ?, ?);";
						IDuser = connection.prepareStatement(query);

						Iterator iteratore = carrello.getIDArray();
						while (iteratore.hasNext()) {
							String prod = (String) iteratore.next();

							IDuser.setString(1, (String) sessione.getAttribute("IDuser"));
							IDuser.setString(2, prod);
							IDuser.setString(3, carrello.getQuantitaItem(prod).toString());

							IDuser.executeUpdate();

						}

					}
				}
				connection.close();
				response.sendRedirect(request.getContextPath());

			} else {
				response.sendRedirect("" + request.getContextPath() + "/login/login-error.jsp");
			}

		} catch (SQLException e) {
			// in caso di errore della query fai questo:
			System.err.println("SQL Problem: " + e.getMessage());
			System.err.println("SQL State: " + e.getSQLState());
			System.err.println("Error: " + e.getErrorCode());
			out.println("<h4>" + e.getMessage() + " </h4>");
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

				}

			} catch (SQLException e) {
				out.println("<h4>" + e.getMessage() + " </h4>");

				System.err.println(e.getMessage());
			}
		}
		// out.println("</body></html>");

	}
}
