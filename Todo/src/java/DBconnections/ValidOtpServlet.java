package DBconnections;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ValidOtpServlet")
public class ValidOtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		int value=Integer.parseInt(request.getParameter("otp"));
		HttpSession session=request.getSession();
		int otp=(int)session.getAttribute("otp");
		
		
		
		RequestDispatcher dispatcher=null;
		
		
		if (value==otp) 
		{
                    request.setAttribute("email", request.getParameter("email"));
                    request.setAttribute("status", "success");
                    dispatcher=request.getRequestDispatcher("newPassword.jsp");
                    dispatcher.forward(request, response);
			
		}
		else
		{
		String errorMessage = "Wrong OTP entered.";
                    request.setAttribute("error", true);
                    request.setAttribute("errorMessage", errorMessage);
                    response.setContentType("text/html");
                    response.getWriter().println("<script>");
                    response.getWriter().println("alert('" + errorMessage + "');");
                    response.getWriter().println("window.location.href='forgotPassword.jsp';");
                    response.getWriter().println("</script>");	
		}
		
	}

}
