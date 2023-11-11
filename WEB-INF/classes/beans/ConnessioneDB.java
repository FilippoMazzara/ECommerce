package beans;

public class ConnessioneDB {

    private String connectionURL = "jdbc:mysql://localhost:3307/ecommerce";
    private String username = "root";
    private String password = "1234";

    public String getUrl() {
        return connectionURL;
    }

    public String getUser() {
        return username;
    }

    public String getPassword() {
        return password;
    }
}
