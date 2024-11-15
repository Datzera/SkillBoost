<%-- 
    Document   : excluir
    Created on : 30 de set. de 2024, 08:58:27
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete</title>
    </head>
    <body>
        <%
            String c;
            int status;
            Connection connec;
            c = request.getParameter("codigo");
            Class.forName("com.mysql.cj.jdbc.Driver");
            connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");
            PreparedStatement st = connec.prepareStatement("DELETE FROM produtos WHERE codigo=?");
            st.setString(1, c);
            status = st.executeUpdate(); //executa o delete
            if (status == 1){
                out.print("deletado com sucesso");
            }
            else{
                out.print("codigo não encontrado");
            }
        %>
    </body>
</html>