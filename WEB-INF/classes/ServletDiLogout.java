import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ServletDiLogout extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

                HttpSession sessione = request.getSession(false);
                sessione.invalidate();
                response.sendRedirect(request.getContextPath());
            }
}
