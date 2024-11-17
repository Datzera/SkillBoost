<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>login aluno</title>
    </head>
    <body>
        <%
            String u, p;
            Connection connec;
            u = request.getParameter("username");
            p = request.getParameter("password");
            
            Class.forName("com.mysql.cj.jdbc.Driver");

            connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

            PreparedStatement st = connec.prepareStatement("SELECT * FROM vendedor WHERE cpf_vendedor=? AND senha=?");
            st.setString(1, u);
            st.setString(2, p);
            ResultSet resultado = st.executeQuery(); //executa o select
            if(resultado.next()){ //encontrou
                String professorNome = resultado.getString("nome");
                String codigoVendedor = resultado.getString("codigo_vendedor");
                session.setAttribute("professorNome", professorNome);
                session.setAttribute("codigoVendedor", codigoVendedor);
                response.sendRedirect("inicioProfessor.jsp");  
            }
            else{ //nao encontrou
                out.print("Usuario e/ou senha incorretos");
            }
        %>
    </body>
</html>