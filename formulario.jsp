<%@page language="java" import="java.sql.*" %>
<%

	String vnome = request.getParameter("txtNome");
	int    vidade = Integer.parseInt(request.getParameter("txtIdade"));
	String vemail = request.getParameter("txtEmail");
	String vmensagem = request.getParameter("txtFeedback");
 
	String banco = "projeto_integrador";
	String endereco = "jdbc:mysql://localhost:3306/" + banco;
	String usuario = "root";
	String senha = "";

	String driver = "com.mysql.jdbc.Driver";
	Class.forName( driver );
	Connection conexao;
	conexao = DriverManager.getConnection(endereco, usuario, senha);

	String sql = "INSERT INTO feedback (nome, idade, email, mensagem) VALUES (?,?,?,?)";

	PreparedStatement stm = conexao.prepareStatement(sql);
	stm.setString(1, vnome);
	stm.setInt(2, vidade);
	stm.setString(3, vemail);
	stm.setString(4, vmensagem);

	stm.execute();
	conexao.close();
	stm.close();
	out.print("Dados efetuados com sucesso!");
%>