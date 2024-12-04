import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
@WebServlet("/ImageServlet")
public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	 protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
		 String id = request.getParameter("id");
	        Connection con = null;
	        PreparedStatement pst = null;
	        ResultSet rs = null;

	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");

	            String query = "SELECT image FROM client_history WHERE id = ?"; 
	            pst = con.prepareStatement(query);
	            pst.setString(1, id);
	            rs = pst.executeQuery();

	            if (rs.next()) {
	                byte[] imgData = rs.getBytes("image");

	                response.setContentType("image/jpeg"); 
	                OutputStream out = response.getOutputStream();
	                out.write(imgData);
	                out.flush();
	                out.close();
	            } else {
	                response.sendError(HttpServletResponse.SC_NOT_FOUND); 
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            try {
	                if (rs != null) rs.close();
	                if (pst != null) pst.close();
	                if (con != null) con.close();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }
	    }
	}