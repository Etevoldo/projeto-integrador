<%@page language="java" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Consulta de feedback</title>
    <style>
        .tabelas{
            margin-top: 120px;
            height: 100vh;
            margin-left: 15%;
            margin-right: 15%;
			margin-bottom: 20%;
        }
        table {
            width: 100%;
        }
		.tabela_pedido {
			float: right;
			margin-bottom: 2em;
			width: 4em;
		}
        table, tr, td, th {
            border: solid 1px black;
            border-collapse: collapse;
            padding: .3em;
        }
    </style>
    <!--Feito por Filipe-->
</head>
<body>
    <div class="container">
        <header>
            <nav>
                <div class="nav-container">
                    <div id="divBusca">
                        <input type="text" id="txtBusca" placeholder="Buscar..."/>
                    </div>
                    <a href="index.html">
                        <img class="imagem_site" src="https://www.savarejo.com.br/portal/principal/arquivos/imagens/20190520_veganismo_materia.jpg" 
                    alt="Loja">
                    </a>
                    <ul>
                        <li> 
                            <img src="icones/sacola.png" >
                            <a href="sacola.html">Sacola</a>
                        </li>
                        <li> 
                            <img src="icones/fale_conosco.png" alt=""> 
                            <a href="fale_conosco.html">Fale Conosco</a>
                        </li>
                        <li> 
                            <img src="icones/criar_conta_icone.png" alt="criar conta img"> 
                            <a href="cadastro.html">Criar conta</a>
                        </li>
                        <li> 
                            <img src="icones/login.png" alt="login img"> 
                            <a href="login.html">Entrar na sua conta</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <section class="tabelas">
<%

    //variaveis para o banco de dados
    String banco    = "projeto_integrador" ;
    String endereco = "jdbc:mysql://localhost:3306/" + banco;
    String usuario  = "root";
    String senha    = "" ;

    String driver   = "com.mysql.jdbc.Driver" ;

    //Carregar o driver na memória
    Class.forName( driver ) ;

    //Cria a vriavel para Concectar com o banco
    Connection conexao ; 

    //Abri a conexão com o banco
    conexao = DriverManager.getConnection( endereco, usuario, senha) ;

	String pedidos = "SELECT * from pedido";
    PreparedStatement pedidos_stm = conexao.prepareStatement(pedidos) ;
	ResultSet pedidos_dados = pedidos_stm.executeQuery();

    String itens_pedido = "select pedido.cod_pedido AS \"Codigo do pedido\", "
				   + "pedido.cpf AS \"CPF\", "
				   + "itens_pedido.cod_produto AS \"Codigo do produto\", "
				   + "itens_pedido.qtd AS \"Quantidade\" "
				   + "from pedido natural join itens_pedido;";

    PreparedStatement itens_pedido_stm = conexao.prepareStatement(itens_pedido) ;
    ResultSet dados = itens_pedido_stm.executeQuery() ;

	int pedido_codigo, pedido_codigo_check;
    while (pedidos_dados.next()) 
    { 
		out.print("<table>");
			out.print("<tr>");
				out.print("<th>Codigo do pedido</th>");
				out.print("<th>CPF</th>");
				out.print("<th>Total</th>");
			out.print("</tr>");
			out.print("<td>");
				out.print(pedidos_dados.getString("cod_pedido"));
			out.print("</td>");
			out.print("<td>");
				out.print(pedidos_dados.getString("CPF"));
			out.print("</td>");
			out.print("<td>");
				out.print(pedidos_dados.getString("Total"));
			out.print("</td>");
		out.print("</table>");
			out.print("<table class=\"tabela_pedido\">");
				out.print("<th>Codigo do produto</th>");
				out.print("<th>Quantidade</th>");
		while (dados.next())
		{
            pedido_codigo = Integer.valueOf(dados.getString("Codigo do pedido"));
            pedido_codigo_check = Integer.valueOf(pedidos_dados.getString("cod_pedido"));
			if (pedido_codigo != pedido_codigo_check){
                dados.previous();
				break;
            }
			out.print( "<tr>" );
				out.print("<td>") ;
					out.print(  dados.getString("Codigo do produto")  ) ;
				out.print("</td>") ;

				out.print("<td>") ;
					out.print(  dados.getString("Quantidade")  ) ;
				out.print("</td>") ;
			out.print( "</tr>" );
		}
		out.print("</table>");
    }

    conexao.close() ;
    itens_pedido_stm.close() ;

%>
        </section>
        <footer>
            <header id="footer_header">
                <img class="imagem_site" src="https://www.savarejo.com.br/portal/principal/arquivos/imagens/20190520_veganismo_materia.jpg" alt="Loja">
            </header>
            <div id="links">
                <ul>
                    <li>
                        <a href="quem_somos.html">Quem somos</a>
                    </li>
                    <li>
                        <a href="">Facebook</a>
                    </li>
                    <li>
                        <a href="">Twitter</a>
                    </li>
                </ul>
            </div>
            <div id="numero_e_email">
                <p><img src="icones/telefone.png"> 2458-7898</p>
                <p><img src="icones/email.png">veganmail@da.loja.com</p>
            </div>
        </footer>
    </div>
</body>
</html>