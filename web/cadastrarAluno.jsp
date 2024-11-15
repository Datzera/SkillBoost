<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Cliente</title>
    </head>
    <body>
        <%
        String cpf_cliente, senha, nome;
        Connection connec;
        cpf_cliente = request.getParameter("cpf_cliente");
        senha = request.getParameter("senha");
        nome = request.getParameter("nome");
        Class.forName("com.mysql.cj.jdbc.Driver");
    
        // Cria a conexão
        connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");
    
        // Cria o holder de comandos
        PreparedStatement st;
    
        // Query para inserir os dados
        String query = "INSERT INTO Clientes (cpf_cliente, senha, nome) VALUES (?, ?, ?)";
    
        // Preenche os valores e executa a query
        st = connec.prepareStatement(query);
        st.setString(1, cpf_cliente);
        st.setString(2, senha);
        st.setString(3, nome);
        st.executeUpdate();
        out.print("Cadastro de Cliente realizado com sucesso");
    %>
    
        <p>
            <a href="../inicio/index.html">Logar</a>    
        </p>    

    </body>
</html>
