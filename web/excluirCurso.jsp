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
            String i;
            int status;
            Connection connec;
            i = request.getParameter("idCursoExcluir");
            Class.forName("com.mysql.cj.jdbc.Driver");
            connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");
            PreparedStatement st = connec.prepareStatement("DELETE FROM cursos WHERE id_curso=?");
            st.setString(1, i);
            status = st.executeUpdate(); //executa o delete
            if (status == 1){
                out.print("deletado com sucesso");
            }
            else{
                out.print("codigo não encontrado");
            }
        %>
        <p>
            <a href="gerenciar.jsp">Voltar para o Painel do Vendedor</a>
        </p>
    </body>
</html>