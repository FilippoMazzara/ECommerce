import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import beans.ConnessioneDB;

import java.sql.*;

public class ServletDiRicerca extends HttpServlet {

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

			// tutto
			String query = "SELECT *  FROM prodotto"
					+ " INNER JOIN indirizzo ON indirizzo.iduser = prodotto.iduserstore"
					+ " WHERE prodotto.prodottoeliminato=0; ";
			// titolo
			String query1 = "SELECT *  FROM prodotto"
					+ " INNER JOIN indirizzo ON indirizzo.iduser = prodotto.iduserstore" +

					" WHERE titolo LIKE ? AND prodotto.prodottoeliminato=0 ;";
			// categoria
			String query2 = "SELECT *  FROM prodotto"
					+ " INNER JOIN indirizzo ON indirizzo.iduser = prodotto.iduserstore" +
					" WHERE nomecategoria = ? AND prodotto.prodottoeliminato=0; ";
			// regione
			String query3 = "SELECT *   FROM prodotto"
					+ " INNER JOIN indirizzo ON indirizzo.iduser = prodotto.iduserstore"
					+ " WHERE indirizzo.regione = ? AND prodotto.prodottoeliminato=0; ";

			// titolo e categoria
			String query12 = "SELECT *  FROM prodotto"
					+ " INNER JOIN indirizzo ON indirizzo.iduser = prodotto.iduserstore" +
					" WHERE titolo LIKE ? AND nomecategoria=? AND prodotto.prodottoeliminato=0 ;";

			// titolo e regione
			String query13 = "SELECT *  FROM prodotto"
					+ " INNER JOIN indirizzo ON indirizzo.iduser = prodotto.iduserstore" +

					" WHERE prodotto.titolo LIKE ? AND indirizzo.regione=? AND prodotto.prodottoeliminato=0;";

			// categoria e regione
			String query23 = "SELECT *  FROM prodotto"
					+ " INNER JOIN indirizzo ON indirizzo.iduser = prodotto.iduserstore" +

					" WHERE prodotto.nomecategoria=? AND indirizzo.regione=? AND prodotto.prodottoeliminato=0 ; ";

			// titolo, categoria e regione
			String query123 = "SELECT *  FROM prodotto"
					+ " INNER JOIN indirizzo ON indirizzo.iduser = prodotto.iduserstore "

					+ "WHERE prodotto.titolo LIKE ? AND prodotto.nomecategoria=? AND indirizzo.regione=? AND prodotto.prodottoeliminato=0;";

			// prendo il parametro vr dichiarato in index.html (la parte della ricerca)
			String nome = request.getParameter("search");
			String categoria = request.getParameter("categoria");
			String regione = request.getParameter("regione");

			// query

			if ((nome.equals("")) && (categoria.equals("null") && (regione.equals("null")))) {
				prodotti = connection.prepareStatement(query);

			}

			if ((!nome.equals("")) && (categoria.equals("null") && (regione.equals("null")))) {
				prodotti = connection.prepareStatement(query1);
				prodotti.setString(1, "%" + nome + "%");
			}

			if ((nome.equals("")) && (!categoria.equals("null") && (regione.equals("null")))) {
				prodotti = connection.prepareStatement(query2);
				prodotti.setString(1, categoria);
			}

			if ((nome.equals("")) && (categoria.equals("null") && (!regione.equals("null")))) {
				prodotti = connection.prepareStatement(query3);
				prodotti.setString(1, regione);
			}

			if ((!nome.equals("")) && (!categoria.equals("null") && (regione.equals("null")))) {
				prodotti = connection.prepareStatement(query12);
				prodotti.setString(1, "%" + nome + "%");
				prodotti.setString(2, categoria);
			}

			if ((!nome.equals("")) && (categoria.equals("null") && (!regione.equals("null")))) {
				prodotti = connection.prepareStatement(query13);
				prodotti.setString(1, "%" + nome + "%");
				prodotti.setString(2, regione);
			}

			if ((nome.equals("")) && (!categoria.equals("null") && (!regione.equals("null")))) {
				prodotti = connection.prepareStatement(query23);
				prodotti.setString(1, categoria);
				prodotti.setString(2, regione);
			}

			if ((!nome.equals("")) && (!categoria.equals("null") && (!regione.equals("null")))) {
				prodotti = connection.prepareStatement(query123);
				prodotti.setString(1, "%" + nome + "%");
				prodotti.setString(2, categoria);
				prodotti.setString(3, regione);
			}

			resultSet = prodotti.executeQuery();
			// stampa dei risultati della query

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
						+ "<small class=\"text-muted\">" + resultSet.getString("indirizzo.regione") + ", "
						+ resultSet.getString("indirizzo.citta")
						+ "</small>" +

						"<h4 style=\"padding-top: 10px;\" class=\"card-text\"><strong>"
						+ resultSet.getString("prodotto.prezzo")
						+ "&euro;</strong> </h4>" +
						"<p><small class=\"card-text\">" + resultSet.getString("prodotto.costospedizione")
						+ "&euro; di spedizione</small></p>");

				if ((Integer.parseInt(resultSet.getString("prodotto.quantitadisponibile")) > 0)
						&& !(resultSet.getString("prodotto.iduserstore").equals(sessione.getAttribute("IDuser")))) {
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
						"<small class=\"text-muted\">" + resultSet.getString("prodotto.datavendita") + "</small>" +
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