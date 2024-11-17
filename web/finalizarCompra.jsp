<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Finalizar Compra</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <%
            String CPFCliente = (String) session.getAttribute("CPFCliente");

            if (CPFCliente == null) {
                out.print("<p>Erro: Cliente não encontrado na sessão.</p>");
                return;
            }

            Connection connec = null;
            PreparedStatement moveCursos = null;
            PreparedStatement removeCursos = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

                String moveQuery = "INSERT INTO cursos_comprados (cpf_cliente, id_curso) " +
                                   "SELECT id_cliente, id_curso FROM clientes_cursos WHERE id_cliente = ?";
                moveCursos = connec.prepareStatement(moveQuery);
                moveCursos.setString(1, CPFCliente);
                int cursosComprados = moveCursos.executeUpdate();

                if (cursosComprados > 0) {
                    String removeQuery = "DELETE FROM clientes_cursos WHERE id_cliente = ?";
                    removeCursos = connec.prepareStatement(removeQuery);
                    removeCursos.setString(1, CPFCliente);
                    removeCursos.executeUpdate();

                    out.print("<p>Compra finalizada com sucesso! Você agora possui " + cursosComprados + " curso(s).</p>");
                } else {
                    out.print("<p>Seu carrinho está vazio. Não há cursos para finalizar a compra.</p>");
                }

            } catch (ClassNotFoundException e) {
                out.print("<p>Erro ao carregar o driver do banco de dados: " + e.getMessage() + "</p>");
            } catch (SQLException e) {
                out.print("<p>Erro ao conectar ao banco de dados ou executar a query: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (moveCursos != null) moveCursos.close();
                    if (removeCursos != null) removeCursos.close();
                    if (connec != null) connec.close();
                } catch (SQLException e) {
                    out.print("<p>Erro ao fechar a conexão com o banco de dados: " + e.getMessage() + "</p>");
                }
            }
        %>

        <a href="inicioAluno.jsp">Voltar para a página inicial</a>
    </body>
</html>
