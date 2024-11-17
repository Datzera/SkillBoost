<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Curso</title>
    </head>
    <body>
        <%
            // Obtém os parâmetros do formulário
            String idCurso = request.getParameter("idCurso");
            String novoTitulo = request.getParameter("novoTitulo");
            String novoPreco = request.getParameter("novoPreco");
            Integer codigo_vendedor = null;  
            Connection connec = null;
            PreparedStatement st = null;

            // Verifica a sessão do vendedor
            if (session != null) {
                Object codigoVendedorObj = session.getAttribute("codigoVendedor");

                if (codigoVendedorObj != null) {
                    try {
                        // Tenta fazer o cast para Integer
                        codigo_vendedor = Integer.parseInt(codigoVendedorObj.toString());
                    } catch (NumberFormatException e) {
                        out.print("<p>Erro: Código do vendedor inválido.</p>");
                        return;
                    }
                } else {
                    out.print("<p>Erro: Vendedor não encontrado na sessão.</p>");
                    return;
                }
            } else {
                out.print("<p>Erro: Sessão inválida.</p>");
                return;
            }

            // Verifica se os parâmetros foram preenchidos corretamente
            if (idCurso != null && !idCurso.isEmpty() && novoTitulo != null && !novoTitulo.isEmpty() && novoPreco != null && !novoPreco.isEmpty() && codigo_vendedor != null) {
                try {
                    // Converte o preço para double
                    double preco = 0;
                    try {
                        preco = Double.parseDouble(novoPreco);
                    } catch (NumberFormatException e) {
                        out.print("<p>O preço do curso deve ser um número válido.</p>");
                        return;
                    }

                    // Conecta ao banco de dados
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

                    // Query para alterar o curso no banco de dados
                    String query = "UPDATE Cursos SET nome_do_curso = ?, preco = ? WHERE id_curso = ? AND codigo_vendedor = ?";
                    st = connec.prepareStatement(query);
                    st.setString(1, novoTitulo);
                    st.setDouble(2, preco);
                    st.setInt(3, Integer.parseInt(idCurso));  // Passa o ID do curso
                    st.setInt(4, codigo_vendedor);

                    // Executa a query de atualização
                    int result = st.executeUpdate();

                    if (result > 0) {
                        out.print("<p>Curso alterado com sucesso!</p>");
                    } else {
                        out.print("<p>Erro ao alterar o curso. Verifique se o curso existe ou se você tem permissão para editar.</p>");
                    }
                } catch (ClassNotFoundException e) {
                    out.print("<p>Erro ao carregar o driver do banco de dados: " + e.getMessage() + "</p>");
                } catch (SQLException e) {
                    out.print("<p>Erro ao conectar ao banco de dados ou executar a query: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        // Fecha a conexão e o statement
                        if (st != null) st.close();
                        if (connec != null) connec.close();
                    } catch (SQLException e) {
                        out.print("<p>Erro ao fechar a conexão: " + e.getMessage() + "</p>");
                    }
                }
            } else {
                out.print("<p>Preencha todos os campos do formulário e verifique se está logado.</p>");
            }
        %>

        <p>
            <a href="gerenciar.jsp">Voltar para o Painel do Vendedor</a>
        </p>
    </body>
</html>
