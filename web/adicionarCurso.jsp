<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adicionar Curso</title>
    </head>
    <body>
        <%
            String nome_curso = request.getParameter("cursoNome");
            String preco_curso = request.getParameter("cursoPreco");
            Integer codigo_vendedor = null;  
            Connection connec = null;
            PreparedStatement st = null;

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
            
            if (nome_curso != null && !nome_curso.isEmpty() && preco_curso != null && !preco_curso.isEmpty() && codigo_vendedor != null) {
                try {
                    double preco = 0;
                    try {
                        preco = Double.parseDouble(preco_curso);
                    } catch (NumberFormatException e) {
                        out.print("<p>O preço do curso deve ser um número válido.</p>");
                        return;
                    }

                    Class.forName("com.mysql.cj.jdbc.Driver");

                    connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

                    String query = "INSERT INTO Cursos (nome_do_curso, codigo_vendedor, preco) VALUES (?, ?, ?)";
                    st = connec.prepareStatement(query);
                    st.setString(1, nome_curso);
                    st.setInt(2, codigo_vendedor);
                    st.setDouble(3, preco);

                    int result = st.executeUpdate();

                    if (result > 0) {
                        out.print("<p>Curso adicionado com sucesso!</p>");
                    } else {
                        out.print("<p>Erro ao adicionar o curso. Tente novamente.</p>");
                    }
                } catch (ClassNotFoundException e) {
                    out.print("<p>Erro ao carregar o driver do banco de dados: " + e.getMessage() + "</p>");
                } catch (SQLException e) {
                    out.print("<p>Erro ao conectar ao banco de dados ou executar a query: " + e.getMessage() + "</p>");
                } finally {
                    try {
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
