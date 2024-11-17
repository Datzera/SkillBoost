<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Aluno</title>
    </head>
    <body>
        <%
            String u = request.getParameter("username"); // CPF do cliente
            String p = request.getParameter("password"); // Senha do cliente
            
            Connection connec = null;
            PreparedStatement st = null;
            ResultSet resultado = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

                String query = "SELECT cpf_cliente, nome FROM clientes WHERE cpf_cliente=? AND senha=?";
                st = connec.prepareStatement(query);
                st.setString(1, u); 
                st.setString(2, p); 

                resultado = st.executeQuery();
                if (resultado.next()) { // Encontrou o usuário
                    String CPFCliente = resultado.getString("cpf_cliente"); 
                    String alunoNome = resultado.getString("nome");

                    session.setAttribute("alunoNome", alunoNome);
                    session.setAttribute("CPFCliente", CPFCliente);

                    response.sendRedirect("inicioAluno.jsp");
                } else { // Não encontrou o usuário
                    out.print("Usuário e/ou senha incorretos.");
                }
            } catch (ClassNotFoundException e) {
                out.print("<p>Erro ao carregar o driver do banco de dados: " + e.getMessage() + "</p>");
            } catch (SQLException e) {
                out.print("<p>Erro ao conectar ao banco de dados ou executar a query: " + e.getMessage() + "</p>");
            }
        %>
    </body>
</html>
