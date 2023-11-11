package filtri;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.*;

public class FiltroAutenticazione implements Filter {

	FilterConfig filterConfig = null;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	public void destroy() {
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) servletRequest;
		HttpServletResponse resp = (HttpServletResponse) servletResponse;

		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();

		HttpSession sessione = req.getSession(true);

		if (sessione.getAttribute("UserName") == null) {
			out.println("per accedere a questa pagina ti devi registrare o accedere");
			resp.sendRedirect("" + req.getContextPath() + "/login/login.jsp");
		} else {

			filterChain.doFilter(servletRequest, servletResponse);
		}

		// filterChain.doFilter(servletRequest, servletResponse);

	}

}
