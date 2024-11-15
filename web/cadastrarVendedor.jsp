<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Vendedor</title>
    </head>
    <body>
        <%
            String cpf_vendedor, senha, nome;
            Connection connec;
            cpf_vendedor = request.getParameter("cpf_vendedor");
            senha = request.getParameter("senha");
            nome = request.getParameter("nome");
            Class.forName("com.mysql.cj.jdbc.Driver");

            connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

            PreparedStatement st;

            String query = "INSERT INTO Vendedor (cpf_vendedor, senha, nome) VALUES (?, ?, ?)";

            st = connec.prepareStatement(query);
            st.setString(1, cpf_vendedor);
            st.setString(2, senha);
            st.setString(3, nome);
            st.executeUpdate();
            out.print("Cadastro de Vendedor realizado com sucesso");
        %>
        <p>
            <a href="index.html">Logar</a>    
        </p>    

    </body>
</html>
