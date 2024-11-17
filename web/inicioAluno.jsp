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
                <li><a href="#courses">Cursos</a></li>
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
        <button>Saiba Mais</button>
    </section>

    <section id="courses" class="cursos">
        <h2>Cursos Populares</h2>
        <div class="listaCursos">
            <div class="curso1">
                <h3>Curso de Programação</h3>
                <p>Aprenda a programar do zero com os melhores professores.</p>
                <button>Saiba Mais</button>
            </div>
            <div class="curso1">
                <h3>Curso de Design Gráfico</h3>
                <p>Domine ferramentas e técnicas de design.</p>
                <button>Saiba Mais</button>
            </div>
            <div class="curso1">
                <h3>Curso de Marketing Digital</h3>
                <p>Desenvolva habilidades para o mercado digital.</p>
                <button>Saiba Mais</button>
            </div>
        </div>
    </section>

    <footer>
        <p>vou pensar em alguma coisa pra colocar</p>
    </footer>
</body>

</html>
