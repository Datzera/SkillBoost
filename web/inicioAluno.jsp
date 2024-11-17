<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillBoost</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

    <%
        String alunoNome = (String) session.getAttribute("alunoNome");
        String CPFCliente = (String) session.getAttribute("CPFCliente");
    %>

    <header>
        <div class="logo">
            <a href="index.html"><img src="logo2.png" alt="SkillBoost Logo"></a>
            <h1>SkillBoost</h1>
        </div>
        <nav>
            <ul>
                <li><a href="#inicio">Início</a></li>
                 <li><a href="listaCursos.jsp?CPFCliente=<%= CPFCliente %>">Cursos</a></li>
            </ul>
        </nav>

        <div class="login">
            <p>Seja bem-vindo, <%= alunoNome %>!</p>
            <a href="carrinho.jsp?CPFCliente=<%= CPFCliente %>">Seu Carrinho</a>
        </div>
    </header>

    <section id="inicio" class="fds">
        <h2>Domine novas habilidades com SkillBoost!</h2>
        <p>Escolha entre diversos cursos online e invista em seu futuro.</p>
    </section>

    <section id="courses" class="cursos">
        <h2>Cursos Populares</h2>
        <div class="listaCursos">
            <div class="curso1">
                <h3>Curso de Java</h3>
                <p>Aprenda a programar do zero com os melhores professores.</p>
                <form action="adicionarCarrinho.jsp" method="POST">
                    <input type="hidden" name="id_curso" value="1">
                    <input type="hidden" name="cpf_cliente" value="<%= CPFCliente %>">
                    <button type="submit">Adicionar ao carrinho</button>
                </form>
            </div>
            <div class="curso1">
                <h3>Curso de Python</h3>
                <p>Domine técnicas de para o desenvolvimento em python.</p>
                <form action="adicionarCarrinho.jsp" method="POST">
                    <input type="hidden" name="id_curso" value="2">
                    <input type="hidden" name="cpf_cliente" value="<%= CPFCliente %>">
                    <button type="submit">Adicionar ao carrinho</button>
                </form>
            </div>
            <div class="curso1">
                <h3>Curso de React</h3>
                <p>Desenvolva habilidades para o desenvolvimento web com react.</p>
                <form action="adicionarCarrinho.jsp" method="POST">
                    <input type="hidden" name="id_curso" value="3">
                    <input type="hidden" name="cpf_cliente" value="<%= CPFCliente %>">
                    <button type="submit">Adicionar ao carrinho</button>
                </form>
            </div>
        </div>
    </section>

    <footer>
        <p>vou pensar em alguma coisa pra colocar</p>
    </footer>
</body>

</html>
