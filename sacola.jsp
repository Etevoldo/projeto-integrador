
<%@page language="java" import="java.sql.*" %>
<%
    String[] produto_qtd = new String[10];
    int i;
    for (i = 0; i < produto_qtd.length; i++){
        produto_qtd[i] = request.getParameter(Integer.toString(i + 1));
    }
    String vcpf = request.getParameter("cpf");
 
	String banco = "projeto_integrador";
	String endereco = "jdbc:mysql://localhost:3306/" + banco;
	String usuario = "root";
	String senha = "";

	String driver = "com.mysql.jdbc.Driver";
	Class.forName( driver );
	Connection conexao;
	conexao = DriverManager.getConnection(endereco, usuario, senha);

	String create_pedido = "INSERT INTO pedido (cpf) VALUES (?);";

	PreparedStatement create_pedido_stm = conexao.prepareStatement(create_pedido);
	create_pedido_stm.setString(1, vcpf);
    create_pedido_stm.execute();

    String select_cod_pedido = "SELECT cod_pedido from pedido " + 
                               "ORDER BY cod_pedido DESC LIMIT 1;";
	PreparedStatement select_cod_pedido_stm = conexao.prepareStatement(select_cod_pedido);

    ResultSet dados = select_cod_pedido_stm.executeQuery();
    dados.next();
    String cod_pedido = dados.getString("cod_pedido");

    out.print("Codigo do pedido: ");
    out.print(cod_pedido);

    //inserir dados em itens_pedido
    String variavel = "SET @qndmult := (select preco from produto where cod_produto = ?);";
    PreparedStatement variavel_stm = conexao.prepareStatement(variavel);

    String itens_pedido = "insert into itens_pedido (cod_pedido, cod_produto, qtd, subtotal) "
                        + "values (?, ?, ?, ? * @qndmult);";

    PreparedStatement itens_pedido_stm = conexao.prepareStatement(itens_pedido);
    for (i = 0; i < produto_qtd.length; i++){
        if (Integer.parseInt(produto_qtd[i]) <= 0)
            continue;
        variavel_stm.setString(1, Integer.toString(i + 1));
        variavel_stm.execute();
        itens_pedido_stm.setString(1, cod_pedido);
        itens_pedido_stm.setString(2, Integer.toString(i + 1));
        itens_pedido_stm.setString(3, produto_qtd[i]);
        itens_pedido_stm.setString(4, produto_qtd[i]);
        itens_pedido_stm.execute();
    }
    
    String soma_total = "update pedido "
                      + "set total = (select sum(subtotal) "
                      + "             from itens_pedido "
			          + "             where cod_pedido = ?) "
			          + "where cod_pedido = ?;";

    PreparedStatement soma_total_stm = conexao.prepareStatement(soma_total);
    soma_total_stm.setString(1, cod_pedido);
    soma_total_stm.setString(2, cod_pedido);
    soma_total_stm.execute();

    create_pedido_stm.close();
    itens_pedido_stm.close();
    soma_total_stm.close();
	conexao.close();
	create_pedido_stm.close();
	select_cod_pedido_stm.close();
    for (i = 0; i < produto_qtd.length; i++){
        out.print("<br>" + produto_qtd[i]);
    }
    
    
%>