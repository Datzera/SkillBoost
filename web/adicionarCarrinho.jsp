<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionando ao Carrinho</title>
</head>

<body>
    <%
        String cpfCliente = request.getParameter("cpf_cliente");
        String idCurso = request.getParameter("id_curso");

        Connection connec = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            if (cpfCliente != null && idCurso != null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

                String verificaQuery = "SELECT COUNT(*) FROM clientes_cursos WHERE id_cliente = ? AND id_curso = ?";
                st = connec.prepareStatement(verificaQuery);
                st.setString(1, cpfCliente);
                st.setInt(2, Integer.parseInt(idCurso));

                rs = st.executeQuery();
                rs.next();
                boolean jaPossuiCurso = rs.getInt(1) > 0;

                if (jaPossuiCurso) {
                    out.print("<p>Você já possui este curso no seu carrinho ou já está matriculado.</p>");
                } else {
                    // Inserir o curso no carrinho
                    String insertQuery = "INSERT INTO clientes_cursos (id_cliente, id_curso) VALUES (?, ?)";
                    st = connec.prepareStatement(insertQuery);
                    st.setString(1, cpfCliente);
                    st.setInt(2, Integer.parseInt(idCurso));

                    int rowsInserted = st.executeUpdate();

                    if (rowsInserted > 0) {
                        out.print("<p>Curso adicionado ao carrinho com sucesso!</p>");
                    } else {
                        out.print("<p>Erro ao adicionar curso ao carrinho.</p>");
                    }
                }
            } else {
                out.print("<p>Dados inválidos. Tente novamente.</p>");
            }
        } catch (ClassNotFoundException e) {
            out.print("<p>Erro ao carregar o driver do banco de dados: " + e.getMessage() + "</p>");
        } catch (SQLException e) {
            out.print("<p>Erro ao conectar ao banco de dados ou executar a query: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (connec != null) connec.close();
            } catch (SQLException e) {
                out.print("<p>Erro ao fechar conexão com o banco de dados: " + e.getMessage() + "</p>");
            }
        }
    %>
    <a href="inicioAluno.jsp">Voltar para a página inicial</a>
</body>

</html>
