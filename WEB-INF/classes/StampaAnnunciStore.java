import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class StampaAnnunciStore extends HttpServlet {

	private Connection connection;
	private PreparedStatement annunci;

	public void init(ServletConfig config)
			throws ServletException {
		ConnessioneDB db = new ConnessioneDB();

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

			// tutto
			String queryannunci = "SELECT * FROM ecommerce.prodotto"
					+ " INNER JOIN indirizzo ON indirizzo.iduser = prodotto.iduserstore"
					+ " WHERE prodotto.iduserstore=? AND prodotto.prodottoeliminato=0";

			annunci = connection.prepareStatement(queryannunci);

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

			annunci.setString(1, id);

			ResultSet resultAnnunci = annunci.executeQuery();

			if (resultAnnunci.isBeforeFirst()) {
				while (resultAnnunci.next()) {

					out.println("  <div class=\"py-2 col-lg-3\"> <div class=\"card h-100\">" +
							"<img src=\"" + request.getContextPath() + "/img/prodotti/"
							+ resultAnnunci.getString("prodotto.immagine")
							+ " \" class=\"card-img-top\" alt=\"...\">"
							+
							// "<div class=\"card-body d-flex flex-column\">" +
							"<div class=\"card-body  flex-column\">" +
							"<a class=\"mt-auto\" href=\"" + request.getContextPath() + "/prodotti/prodotti.jsp?id="
							+ resultAnnunci.getString("prodotto.idprodotto")
							+ "\" ><h5 class=\"card-title\">" + resultAnnunci.getString("prodotto.titolo")
							+ "</h5></a>" +
							"<img style=\"height:17x; width:17px;\" src=\"" + request.getContextPath()
							+ "/img/localizzazione.png\">"
							+ "<small class=\"text-muted\">" + resultAnnunci.getString("indirizzo.regione") + ", "
							+ resultAnnunci.getString("indirizzo.citta")
							+ "</small>" +

							"<h4 style=\"padding-top: 10px;\" class=\"card-text\"><strong>"
							+ resultAnnunci.getString("prodotto.prezzo")
							+ "&euro;</strong> </h4>" +
							"<p><small class=\"card-text\">" + resultAnnunci.getString("prodotto.costospedizione")
							+ "&euro; di spedizione</small></p>");

					if ((Integer.parseInt(resultAnnunci.getString("prodotto.quantitadisponibile")) > 0)
							&& !(resultAnnunci.getString("prodotto.iduserstore")
									.equals(sessione.getAttribute("IDuser")))) {
						out.println(
								"<strong  style=\"color: green; \">Disponibile: "
										+ resultAnnunci.getString("prodotto.quantitadisponibile")
										+ " </strong><br><a class=\" text-white btn btn-primary\" href=\""
										+ request.getContextPath() + "/aggiungicarrello?id="
										+ resultAnnunci.getString("prodotto.idprodotto")
										+ "\">Aggiungi al carrello</a>");
					} else {
						out.println("<strong  style=\"color: red; \">Non disponibile</strong>");
					}

					out.println("</div>" +
							"<div class=\"card-footer\">" +
							"<small class=\"text-muted\">" + resultAnnunci.getString("prodotto.datavendita")
							+ "</small>" +
							"</div>" +
							"</div>" +
							"</div>");

				}
			} else {

				out.println("<div class=\"text-center\">Nessuna pubblicazione</div>");

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

	}

	public void destroy() {
		try {
			if (connection != null) {
				// chiusura finale della connessione con il database
				annunci.close();
				connection.close();
			}

		} catch (SQLException e) {
			System.err.println(e.getMessage());

		}

	}
}