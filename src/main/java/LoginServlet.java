import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.*;
import java.sql.*;
@WebServlet("/LoginServlet") 
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        response.setContentType("text/html;charset=UTF-8");

	        String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        try {
	            // Database connection
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");

	            // Query to check if user exists
	            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setString(1, email);
	            pstmt.setString(2, password);

	            ResultSet rs = pstmt.executeQuery();

	            if (rs.next()) {
	                // User exists, redirect to welcome page or dashboard
	                response.sendRedirect("index.jsp");
	            } else {
	                // User does not exist or wrong credentials
	                response.getWriter().println("Invalid email or password.");
	            }

	            pstmt.close();
	            con.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}