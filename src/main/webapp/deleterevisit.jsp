<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<%
    String id = request.getParameter("id");
    Connection con = null;
    PreparedStatement pst = null;
    int rowsAffected = 0;
    String message = "";

    try {
        
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskvfly", "root", "");

        
        String sqlDelete = "DELETE FROM client_revisit WHERE id = ?";
        pst = con.prepareStatement(sqlDelete);
        pst.setString(1, id);

       
        rowsAffected = pst.executeUpdate();

    
        if (rowsAffected > 0) {
            message = "Record deleted successfully";
        } else {
            message = "Record not found";
        }

    } catch (Exception e) {
        e.printStackTrace();
        message = "An error occurred while deleting the record";
    } finally {
        if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
        if (con != null) try { con.close(); } catch (SQLException ignored) {}
    }
%>

<script type="text/javascript">
    alert("<%= message %>");
    window.location.href = 'client_revisit.jsp';
</script>
</body>
</html>