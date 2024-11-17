<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Carrinho de Compras</title>
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
            PreparedStatement stCarrinho = null;
            PreparedStatement stComprados = null;
            ResultSet rsCarrinho = null;
            ResultSet rsComprados = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connec = DriverManager.getConnection("jdbc:mysql://localhost:3306/skillboost", "root", "");

                String queryCarrinho = "SELECT c.nome_do_curso, c.preco FROM clientes_cursos cc " +
                                       "JOIN cursos c ON cc.id_curso = c.id_curso " +
                                       "JOIN clientes cli ON cc.id_cliente = cli.cpf_cliente " + 
                                       "WHERE cli.cpf_cliente = ?";
                stCarrinho = connec.prepareStatement(queryCarrinho);
                stCarrinho.setString(1, CPFCliente);
                rsCarrinho = stCarrinho.executeQuery();

                String queryComprados = "SELECT c.nome_do_curso FROM cursos_comprados cc " +
                                        "JOIN cursos c ON cc.id_curso = c.id_curso " +
                                        "WHERE cc.cpf_cliente = ?";
                stComprados = connec.prepareStatement(queryComprados);
                stComprados.setString(1, CPFCliente);
                rsComprados = stComprados.executeQuery();
            } catch (ClassNotFoundException e) {
                out.print("<p>Erro ao carregar o driver do banco de dados: " + e.getMessage() + "</p>");
                return;
            } catch (SQLException e) {
                out.print("<p>Erro ao conectar ao banco de dados ou executar a query: " + e.getMessage() + "</p>");
                return;
            }
        %>

        <header>
            <div class="logo">
                <a href="index.html"><img src="logo2.png" alt="SkillBoost Logo"></a>
                <h2>Carrinho De Compras</h2>
            </div>
            <nav>
                <ul>
                    <li><a href="inicioAluno.jsp?CPFCliente=<%= CPFCliente %>">Início</a></li>
                    <li><a href="listaCursos.jsp" style="padding-right: 10ch">Cursos</a></li>
                </ul>
            </nav>
        </header>

        <main id="conteudo" style="padding-top: 100px;">
            <section class="carrinho">
                <h2>Seu Carrinho de Compras:</h2>
                <%
                    double total = 0.0;
                    try {
                        while (rsCarrinho != null && rsCarrinho.next()) {
                            String nomeCurso = rsCarrinho.getString("nome_do_curso");
                            double preco = rsCarrinho.getDouble("preco");
                            total += preco;
                %>
                            <div class="curso">
                                <h3>Curso de <%= nomeCurso %></h3>
                                <p>Preço: R$ <%= String.format("%.2f", preco) %></p>
                            </div>
                <%
                        }
                    } catch (SQLException e) {
                        out.print("<p>Erro ao exibir os cursos no carrinho: " + e.getMessage() + "</p>");
                    }
                %>

                <div class="total">
                    <h3>Total: R$ <%= String.format("%.2f", total) %></h3>
                </div>

                <button class="finalizar">Finalizar Compra</button>
                <br class="espaço">
                <hr id="linhazinha">
                <br>
                <h2>Cursos já comprados:</h2>
                <%
                    boolean cursosEncontrados = false;
                    try {
                        while (rsComprados != null && rsComprados.next()) {
                            String nomeCursoComprado = rsComprados.getString("nome_do_curso");
                            cursosEncontrados = true;
                %>
                            <div class="curso">
                                <h3><%= nomeCursoComprado %></h3>
                            </div>
                <%
                        }

                        if (!cursosEncontrados) {
                            out.print("<p>Você ainda não comprou nenhum curso.</p>");
                        }

                    } catch (SQLException e) {
                        out.print("<p>Erro ao exibir cursos comprados: " + e.getMessage() + "</p>");
                    }
                %>
            </section>
        </main>

    </body>
</html>
<!--lembrar de estlizar onde vai ficar os cursos tranfomar 
 pra "link" só pela estética(nao vai ter pag)
talvez eu coloque uma imagem de fundo ent lembrar de colocar cor transparente
nos  containerss  -->