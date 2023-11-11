import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import beans.ConnessioneDB;

import java.util.*;

import java.sql.*;

public class ServletUpload extends HttpServlet {

    private Connection connection;
    private PreparedStatement statemant;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession sessione = request.getSession();

        String idUser = (String) sessione.getAttribute("IDuser");
        String titolo = null;
        String categoria = null;
        String quantita = null;
        String prezzo = null;
        String spedizione = null;
        String descrizione = null;

        // ----------------- UPLOAD FILE--------------------------------

        // generatore random di interi
        Random rand = new Random();
        int upperbound = 1000000000;
        int int_random = rand.nextInt(upperbound);

        String nomeFoto = int_random + ".jpg";

        // Check that we have a file upload request
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        // Create a factory for disk-based file items
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // Configure a repository (to ensure a secure temp location is used)
        ServletContext servletContext = this.getServletConfig().getServletContext();
        File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
        factory.setRepository(repository);

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // Parse the request

        try {
            List<FileItem> items = upload.parseRequest(request);
            Iterator<FileItem> iter = items.iterator();

            while (iter.hasNext()) {
                FileItem item = iter.next();

                if (item.isFormField()) {
                    String name = item.getFieldName();
                    String value = item.getString();

                    if (name.equals("titolo")) {
                        titolo = value;

                    } else if (name.equals("prezzo")) {
                        prezzo = value;

                    } else if (name.equals("spedizione")) {
                        spedizione = value;

                    } else if (name.equals("categoria")) {
                        categoria = value;

                    } else if (name.equals("quantita")) {
                        quantita = value;

                    } else if (name.equals("descrizione")) {
                        descrizione = value;

                    }

                } else {
                    String fileName = item.getName();
                    String contentType = item.getContentType();

                    // percorso dove salvare il file

                    File uploadedFile = new File(
                            getServletContext().getRealPath("/"), "/img/prodotti/" + nomeFoto);
                    try {
                        // controllo se il file esiste già
                        if (uploadedFile.exists()) {
                            out.println("esiste già");
                        } else {

                            if (!contentType.contains("image/")) {
                                out.println("deve essere un immagine");
                            } else {
                                // upload del file

                                item.write(uploadedFile);
                            }

                        }

                    } catch (Exception e) {
                        // TODO Auto-generated catch block
                        out.println(e.getMessage());
                    }

                }
            }
        } catch (FileUploadException e) {
            // TODO Auto-generated catch block
            out.println(e.getMessage());
        }

        // ------------------PARTE DATABASE-----------------

        ConnessioneDB db = new ConnessioneDB();

        try {

            // connessione driver e database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(db.getUrl(), db.getUser(), db.getPassword());

            // query
            String query = "call ecommerce.registraprodotto(?,?,?,?,?,?,?,?, @pid);";

            statemant = connection.prepareStatement(query);

            statemant.setString(1, idUser);
            statemant.setString(2, categoria);
            statemant.setString(3, quantita);
            statemant.setString(4, prezzo);
            statemant.setString(5, descrizione);
            statemant.setString(6, titolo);
            statemant.setString(7, nomeFoto);
            statemant.setString(8, spedizione);

            statemant.executeUpdate();

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
                    response.sendRedirect(request.getContextPath());

                }

            } catch (SQLException e) {
                out.println("<h4>" + e.getMessage() + " </h4>");

                System.err.println(e.getMessage());
            }
        }

    }
}
