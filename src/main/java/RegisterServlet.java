import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.*;
import java.sql.*;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        response.setContentType("text/html;charset=UTF-8");
	        
	        // Get form data
	        String name = request.getParameter("name");
	        String age = request.getParameter("age");
	        String gender = request.getParameter("gender");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        
	        try {
	            // Database connection
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");

	            // Insert data into the database
	            String query = "INSERT INTO users (name, age, gender, email, password) VALUES (?, ?, ?, ?, ?)";
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setString(1, name);
	            pstmt.setInt(2, Integer.parseInt(age));
	            pstmt.setString(3, gender);
	            pstmt.setString(4, email);
	            pstmt.setString(5, password);

	            int rows = pstmt.executeUpdate();

	            // If registration is successful, redirect to login page
	            if (rows > 0) {
	                response.sendRedirect("Login.jsp");
	            } else {
	                response.getWriter().println("Registration failed. Please try again.");
	            }

	            pstmt.close();
	            con.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}