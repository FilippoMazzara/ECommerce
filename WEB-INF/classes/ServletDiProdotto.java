import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import beans.*;

public class ServletDiProdotto extends HttpServlet {
	private Connection connection;
	private PreparedStatement statement;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
			HttpSession sessione = request.getSession(true);
			// prendo il parametro id dichiarato nell'url di prodotti.jsp (la parte della
			// ricerca)
			String id = request.getParameter("id");

			// query

			String query = "SELECT * FROM prodotto "
					+ "INNER JOIN indirizzo ON prodotto.iduserstore = indirizzo.iduser "
					+ "INNER JOIN utente ON  indirizzo.iduser = utente.iduser "

					+ " WHERE prodotto.idprodotto=? ; ";

			statement = connection.prepareStatement(query);
			statement.setString(1, id);
			resultSet = statement.executeQuery();

			// stampa dei risultati della query
			while (resultSet.next()) {
				out.println("<div class=\"container\" style=\"padding-top: 30px;\">" +
						"<div class=\"row\">" +
						"<div class=\"col-lg-6\">" +
						"<img class=\"img-fluid\" style=\" border-color: black; border-radius:10px; border-style: solid; border-width: 2px; height:400px; width:600px; background-color:white;\" src=\"../img/prodotti/"
						+ resultSet.getString("immagine")
						+ " \" class=\"card-img-top\" alt=\"...\">" +
						"</div>" +
						"<div class=\"col-lg-6\" style=\"background-color: white; padding-top:15px;\">" +
						"<h5  class=\"text-muted\">Categoria: " + resultSet.getString("nomecategoria") + "</h5>" +

						"<p class=\"text-muted\">Pubblicazione: " + resultSet.getString("datavendita")
						+ " &nbsp - &nbsp;ID: "
						+ resultSet.getString("idprodotto") + "</p>" +

						"<hr>" +
						"<h2 style=\"padding-top:20px;\" >" + resultSet.getString("titolo") + "</h2>" +

						"<img style=\"height:20px; width:20px;\" src=\"../img/localizzazione.png\">  "
						+ resultSet.getString("indirizzo.regione") + ", " + resultSet.getString("indirizzo.citta")
						+ " &nbsp;" +
						"<img style=\"height:20px; width:20px;\" src=\"../img/store.png\"><a class=\"px-2\" href=\""
						+ request.getContextPath() + "/store?iduserstore="
						+ resultSet.getString("prodotto.iduserstore") + "\">"
						+ resultSet.getString("utente.username") + "</a><br>" +
						"<div style=\"padding-top: 20px;\">");

				if (((Integer.parseInt(resultSet.getString("quantitadisponibile")) > 0)
						&& (resultSet.getString("prodotto.prodottoeliminato").equals("0")))
						&& !(resultSet.getString("prodotto.iduserstore").equals(sessione.getAttribute("IDuser")))) {
					out.println("<strong  style=\"color: green; \">Disponibile: "
							+ resultSet.getString("quantitadisponibile") + "</strong><br>" +
							"<h3><strong>" + resultSet.getString("prezzo") + "&euro; </strong></h3>  <p>+"
							+ resultSet.getString("prodotto.costospedizione") + "&euro; di spedizione </p> " +
							"<a class=\"btn btn-primary text-white\" href=\"../aggiungicarrello?id="
							+ resultSet.getString("idprodotto")
							+ "\">Aggiungi al carrello</a>");

				} else {
					out.println("<strong  style=\"color: red; \">Non disponibile</strong>" +
							"<h3><strong>" + resultSet.getString("prezzo") + "&euro; </strong></h3>");

				}

				out.println("</div>" +
						"</div>" +
						"</div>" +
						"<div class=\"row\">" +
						"<div class=\"col-lg-6\">" +
						"<div style=\"padding-top:25px;\">" +
						"<h2>Descrizione: </h2>" +
						"<h6 >" + resultSet.getString("descrizione") + "</h6><br>" +
						"</div>" +
						"</div>" +
						"</div>" +
						"</div>");
			}

		} catch (SQLException e) {
			// in caso di errore della query fai questo:
			System.err.println("SQL Problem: " + e.getMessage());
			System.err.println("SQL State: " + e.getSQLState());
			System.err.println("Error: " + e.getErrorCode());
			out.println("<h2>ERRORE!!!</h2><br>");
			out.println("<h4>" + e.getMessage() + "</h4>");
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
				out.println("<h2>ERRORE!!!</h2><br>");
				out.println("<h4>" + e.getMessage() + "</h4>");

				System.err.println(e.getMessage());
			}
		}
		// out.println("</body></html>");

	}
}