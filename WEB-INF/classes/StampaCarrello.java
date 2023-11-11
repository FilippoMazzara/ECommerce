import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.Iterator;
import beans.Carrello;
import beans.ConnessioneDB;

public class StampaCarrello extends HttpServlet {

    private Connection connection;
    private PreparedStatement prodotti;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        // out.println("<html><head><title> Test di MySQL </title></head><body>");

        // dati per la connesione al database MySQL
        ConnessioneDB db = new ConnessioneDB();

        ResultSet resultSet = null;
        // sessione
        HttpSession sessione = request.getSession(true);
        // carrello sessione
        Double costoTotale = 0.00;
        Double costoSpedizioneTotale = 0.00;
        Double costoFinale = 0.00;

        if (sessione.getAttribute("carrello") != null) {
            Carrello carrello = (Carrello) sessione.getAttribute("carrello");
            Iterator<String> iteratore = carrello.getIDArray();

            try {

                // connessione driver e database
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

                // query

                String query = "SELECT * FROM prodotto "
                        + "INNER JOIN vistautente ON prodotto.iduserstore = vistautente.iduser "

                        + " WHERE prodotto.idprodotto=? ; ";

                prodotti = connection.prepareStatement(query);
                // itero la il carrello della sessio
                if (!carrello.isEmpty()) {
                    out.println("<h2>Carrello</h2><br>");
                    while (iteratore.hasNext()) {

                        prodotti.setString(1, (String) iteratore.next());
                        resultSet = prodotti.executeQuery();

                        while (resultSet.next()) {
                            // mi stampo le card dei prodotti
                            costoTotale = costoTotale + resultSet.getDouble("prezzo")
                                    * carrello.getQuantitaItem(resultSet.getString("idprodotto"));
                            costoSpedizioneTotale = costoSpedizioneTotale + resultSet.getDouble("costospedizione")
                                    * carrello.getQuantitaItem(resultSet.getString("idprodotto"));

                            out.println(
                                    "<div class=\"card mb-3 \">"
                                            +

                                            "<div class=\"row mt-3\">" +
                                            "<div class=\"col-lg-2\">" +

                                            "<img style=\"height:200px; width:200px;\" src=\""
                                            + request.getContextPath() + "/img/prodotti/"
                                            + resultSet.getString("immagine")
                                            + "\" class=\"img-fluid rounded-start\" alt=\"...\">" +
                                            "</div>" +
                                            "<div class=\"col-lg-8\">" +
                                            "<div class=\"card-body\">" +
                                            // corpo cards
                                            "<a class=\"mt-auto\" href=\"" + request.getContextPath()
                                            + "/prodotti/prodotti.jsp?id="
                                            + resultSet.getString("prodotto.idprodotto") + "\" >"
                                            + "<h5 class=\"card-title\">" + resultSet.getString("titolo") + "</h5></a>"
                                            // informazioni
                                            + "<img style=\"height:15px; width:15px;\" src=\"../img/localizzazione.png\"><small>"
                                            + resultSet.getString("vistautente.regione") + ", "
                                            + resultSet.getString("vistautente.citta")
                                            + " &nbsp;</small>" +
                                            "<img style=\"height:15px; width:15px;\" src=\"../img/store.png\"><a class=\"px-1\" href=\""
                                            + request.getContextPath() + "/store?iduserstore="
                                            + resultSet.getString("prodotto.iduserstore") + "\"><small>"
                                            + resultSet.getString("vistautente.username") + "</small></a> <br>");
                            if (resultSet.getInt("quantitadisponibile") > 0) {
                                out.println("<strong  style=\"color: green; \">Disponibile</strong>");
                            } else {
                                out.println("<strong  style=\"color: Red; \">Non disponibile</strong>");
                            }

                            out.println(

                                    "<br><div class=\"py-5\"><a style=\"color:blue;\" href=\"../eliminaitemcarrello?id="
                                            + resultSet.getString("idprodotto") + "\">Elimina</a>" +
                                            " | Q.ta': "
                                            + carrello.getQuantitaItem(resultSet.getString("idprodotto")).toString()
                                            + " &nbsp;</div>" +
                                            "</div>" +
                                            "</div>" +

                                            "<div class=\"col-lg-2\">" +
                                            "<strong class=\"py-2\">Prezzo: " + resultSet.getString("prezzo")
                                            + " &euro; </strong><br>" +
                                            "<strong class=\"py-2\">Spedizione: "
                                            + resultSet.getString("costospedizione")
                                            + " &euro; </strong><br>" +

                                            "</div>" +
                                            "</div>" +

                                            "</div>");

                        }

                    }

                    costoFinale = costoTotale + costoSpedizioneTotale;
                    DecimalFormat decimale = new DecimalFormat("0.00");

                    out.println(
                            "<div class=\"card mb-3 \" style=\"padding-top: 20px;\" >"
                                    +
                                    "<h3 class=\"\">Riepilogo ordine</h3><br>" +
                                    "<div style=\"padding-top: 20px;\">" +
                                    "<ul>" +
                                    "<li>Costo articoli: &nbsp;" + decimale.format(costoTotale) + " &euro; </li>" +
                                    "<li>Costo spedizione: &nbsp;" + decimale.format(costoSpedizioneTotale)
                                    + " &euro; </li>"
                                    +
                                    "</ul>" +
                                    "</div>" +

                                    "<div class=\"py-3\">" +
                                    "<h4>Costo totale: " + decimale.format(costoFinale)
                                    + "&euro;</h4>" +
                                    "</div>" +

                                    "</div>" +
                                    "<a href=\"" + request.getContextPath()
                                    + "/ordine/ordine.jsp\" class=\"btn btn-primary  btn-lg text-white\">Procedi all'ordine</a>");
                } else {
                    out.println("<h2>Il tuo carrello e' vuoto</h2><br>");

                }

            } catch (SQLException e) {
                // in caso di errore della query fai questo:
                System.err.println("SQL Problem: " + e.getMessage());
                System.err.println("SQL State: " + e.getSQLState());
                System.err.println("Error: " + e.getErrorCode());
                out.println("<h4>Non e' stato trovato alcun risultato (Problema database) </h4>");
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
                }
            }
            // out.println("</body></html>");
        } else {
            out.println("<h2>Il tuo carrello e' vuoto</h2><br>");
        }

    }
}