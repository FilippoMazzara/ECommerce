import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class ProdottiConsigliati extends HttpServlet {

	private Connection connection;
	private PreparedStatement prodotti;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		// out.println("<html><head><title> Test di MySQL </title></head><body>");

		// dati per la connesione al database MySQL
		ConnessioneDB db = new ConnessioneDB();
		HttpSession sessione = request.getSession(true);

		ResultSet resultSet = null;

		try {

			// connessione driver e database
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

			// query

			String categoria = request.getParameter("categoria");

			String query = "select * from ecommerce.prodotto INNER JOIN ecommerce.vistautente ON vistautente.iduser = prodotto.iduserstore where prodotto.prodottoeliminato=0 AND prodotto.nomecategoria=? and prodotto.quantitadisponibile>0 and prodotto.iduserstore in (select iduserstore from ecommerce.userstore where userstore.feedback in (select feedback from ecommerce.userstore order by userstore.feedback DESC)) LIMIT 3 ;";

			prodotti = connection.prepareStatement(query);

			// stampa dei risultati della query
			if (categoria != null) {
				if (!categoria.equals("null")) {

					prodotti.setString(1, categoria);

					resultSet = prodotti.executeQuery();
					if (resultSet.isBeforeFirst()) {
						while (resultSet.next()) {

							// h-100
							out.println("  <div class=\"col-lg-3\"> <div class=\"card h-100\">" +
									"<img src=\"../img/prodotti/" + resultSet.getString("prodotto.immagine")
									+ " \" class=\"card-img-top\" alt=\"...\">"
									+
									// "<div class=\"card-body d-flex flex-column\">" +
									"<div class=\"card-body  flex-column\">" +
									"<a class=\"mt-auto\" href=\"../prodotti/prodotti.jsp?id="
									+ resultSet.getString("prodotto.idprodotto")
									+ "\" ><h5 class=\"card-title\">" + resultSet.getString("prodotto.titolo")
									+ "</h5></a>" +
									"<img style=\"height:17x; width:17px;\" src=\"../img/localizzazione.png\">"
									+ "<small class=\"text-muted\">" + resultSet.getString("vistautente.regione")
									+ ", "
									+ resultSet.getString("vistautente.citta")
									+ "</small>" +

									"<h4 style=\"padding-top: 10px;\" class=\"card-text\"><strong>"
									+ resultSet.getString("prodotto.prezzo")
									+ "&euro;</strong> </h4>" +
									"<p><small class=\"card-text\">"
									+ resultSet.getString("prodotto.costospedizione")
									+ "&euro; di spedizione</small></p>");

							if ((Integer.parseInt(resultSet.getString("prodotto.quantitadisponibile")) > 0)
									&& !(resultSet.getString("prodotto.iduserstore")
											.equals(sessione.getAttribute("IDuser")))) {
								out.println(
										"<strong  style=\"color: green; \">Disponibile: "
												+ resultSet.getString("prodotto.quantitadisponibile")
												+ " </strong><br><a class=\" text-white btn btn-primary\" href=\"../aggiungicarrello?id="
												+ resultSet.getString("prodotto.idprodotto")
												+ "\">Aggiungi al carrello</a>");
							} else {
								out.println("<strong  style=\"color: red; \">Non disponibile</strong>");
							}

							out.println("</div>" +
									"<div class=\"card-footer\">" +
									"<small class=\"text-muted\">" + resultSet.getString("prodotto.datavendita")
									+ "</small>" +
									"</div>" +
									"</div>" +
									"</div>");

						}
					} else {
					}
				}
			}

		} catch (SQLException e) {
			// in caso di errore della query fai questo:
			System.err.println("SQL Problem: " + e.getMessage());
			System.err.println("SQL State: " + e.getSQLState());
			System.err.println("Error: " + e.getErrorCode());
			out.println("<h2>ERRORE!!!</h2><br>");
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
				System.err.println(e.getMessage());
				out.println("<h2>ERRORE!!!</h2><br>");
				out.println("<h4>" + e.getMessage() + " </h4>");
			}
		}
		// out.println("</body></html>");

	}
}