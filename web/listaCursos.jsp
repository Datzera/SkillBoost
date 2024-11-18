<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Cursos - SkillBoost</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <header>
        <div class="logo">
            <a href="index.html"><img src="logo2.png" alt="SkillBoost Logo"></a>
            <h1>SkillBoost</h1>
        </div>
        <nav>
            <ul>
                <li><a href="inicioAluno.jsp">Início</a></li>
            </ul>
        </nav>

        <div class="login">
            <p>Escolha um Curso!</p>
        </div>
    </header>

    <section style="margin-top: 120px;" id="lista" class="cursos">
        <h2>Cursos Disponíveis</h2>
        <div class="listaCursos">
            <%
                String CPFCliente = (String) session.getAttribute("CPFCliente");

                if (CPFCliente != null) {
                    CPFCliente = CPFCliente.replaceAll("[^0-9]", "");

                    Connection connec = null;
                    PreparedStatement st = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

                        String query = "SELECT id_curso, nome_do_curso FROM cursos";
                        st = connec.prepareStatement(query);
                        rs = st.executeQuery();

                        while (rs.next()) {
                            String idCurso = rs.getString("id_curso");
                            String nomeCurso = rs.getString("nome_do_curso");
            %>
                            <div class="curso1">
                                <h3><%= nomeCurso %></h3>
                                <form action="adicionarCarrinho.jsp" method="POST">
                                    <input type="hidden" name="id_curso" value="<%= idCurso %>">
                                    <input type="hidden" name="cpf_cliente" value="<%= CPFCliente %>">
                                    <button type="submit">Adicionar ao Carrinho</button>
                                </form>
                            </div>
            <%
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
                            out.print("<p>Erro ao fechar a conexão com o banco de dados: " + e.getMessage() + "</p>");
                        }
                    }
                } else {
                    out.print("<p>Erro: CPF do cliente não encontrado na sessão.</p>");
                }
            %>
        </div>
    </section>

    <footer>
        <p>&copy; Skillboost. Site feito por Caio Abner e Davi Miguel</p>
    </footer>
</body>

</html>
