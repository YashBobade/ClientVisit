import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/EditReferenceServlet") 
public class EditReferenceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	String id = request.getParameter("id");
        String updatedReferencename = request.getParameter("Referencename");
        String updatedReferencenumber = request.getParameter("Referencenumber");
        String updatedemail = request.getParameter("email");

        Connection con = null;
        PreparedStatement pst = null;

        try {
       
            Class.forName("com.mysql.jdbc.Driver");
            
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");

         
            String sqlUpdate = "UPDATE addreference SET Referencename = ?, Referencenumber = ?, email = ? WHERE id = ?";
            pst = con.prepareStatement(sqlUpdate);
            pst.setString(1, updatedReferencename);
            pst.setString(2, updatedReferencenumber);
            pst.setString(3, updatedemail);
            pst.setString(4, id);
            pst.executeUpdate();

            response.sendRedirect("AddReference.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    }
}