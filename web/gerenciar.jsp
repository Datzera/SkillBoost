<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel do Professor</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <%
     Integer codigoVendedor = null;
    Object codigoVendedorObj = session.getAttribute("codigoVendedor");

    if (codigoVendedorObj != null) {
        try {
            codigoVendedor = Integer.valueOf(codigoVendedorObj.toString());
        } catch (NumberFormatException e) {
            out.println("Código do vendedor inválido.");
        }
    }
    
    Connection connec = null;
    ResultSet cursos = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

        PreparedStatement listarCursosStmt = connec.prepareStatement(
            "SELECT id_curso, nome_do_curso, preco FROM cursos WHERE codigo_vendedor = ?"
        );
        listarCursosStmt.setInt(1, codigoVendedor);
        cursos = listarCursosStmt.executeQuery();
    } catch (Exception e) {
        out.println("Erro ao conectar ao banco de dados: " + e.getMessage());
    }
    %>
    
    <header>
        <div class="logo">
            <a href="index.html"><img src="logo2.png" alt="SkillBoost Logo"></a>
            <h1>Painel do Professor</h1>
        </div>
        <nav>
            <ul>
                <li><a href="#adicionarCurso">Adicionar Curso</a></li>
                <li><a href="#listarCursos">Listar Cursos</a></li>
                <li><a href="#alterarCurso">Alterar Curso</a></li>
                <li><a href="#excluirCurso" style="padding-right: 10ch">Excluir Curso</a></li>
            </ul>
        </nav>
    </header>

    <main style="padding-top: 100px;">
        <!-- Adicionar Curso -->
        <section id="adicionarCurso" class="conteudo">
            <h2>Adicionar Novo Curso</h2>
            <form method="post" action="adicionarCurso.jsp">
                <label for="cursoNome">Título do Curso</label>
                <input type="text" id="cursoNome" name="cursoNome" required>

                <label for="cursoPreco">Preço do Curso</label>
                <input type="number" id="cursoPreco" name="cursoPreco" min="0" step="0.01" required>

                <button type="submit">Adicionar Curso</button>
            </form>
        </section>

        <!-- Listar Cursos -->
        <section id="listarCursos" class="conteudo">
            <h2>Meus Cursos</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Título do Curso</th>
                        <th>Preço</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (cursos != null) {
                            while (cursos.next()) {
                    %>
                        <tr>
                            <td><%= cursos.getInt("id_curso") %></td>
                            <td><%= cursos.getString("nome_do_curso") %></td>
                            <td>R$ <%= cursos.getBigDecimal("preco").setScale(2) %></td>
                        </tr>
                    <% 
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="3">Nenhum curso encontrado.</td>
                        </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </section>

        <!-- Alterar Curso -->
        <section id="alterarCurso" class="conteudo">
            <h2>Alterar Curso</h2>
            <form method="post" action="alterarCurso.jsp">
                <label for="idCurso">ID do Curso</label>
                <input type="number" id="idCurso" name="idCurso" required>

                <label for="novoTitulo">Novo Título</label>
                <input type="text" id="novoTitulo" name="novoTitulo" required>

                <label for="novoPreco">Novo Preço</label>
                <input type="number" id="novoPreco" name="novoPreco" min="0" step="0.01" required>

                <button type="submit">Alterar Curso</button>
            </form>
        </section>

        <!-- Excluir Curso -->
        <section id="excluirCurso" class="conteudo">
            <h2>Excluir Curso</h2>
            <form method="post" action="excluirCurso.jsp">
                <label for="idCursoExcluir">ID do Curso</label>
                <input type="number" id="idCursoExcluir" name="idCursoExcluir" required>

                <button type="submit">Excluir Curso</button>
            </form>
        </section>
    </main>
</body>

</html>
