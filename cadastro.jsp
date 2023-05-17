<%@page language="java" import="java.sql.*" %>
<%

	String vnome = request.getParameter("nome");
	String vcpf = request.getParameter("cpf");
	String vemail = request.getParameter("email");
	String vsenha = request.getParameter("senha");
 
	String banco = "projeto_integrador";
	String endereco = "jdbc:mysql://localhost:3306/" + banco;
	String usuario = "root";
	String senha = "";

	String driver = "com.mysql.jdbc.Driver";
	Class.forName( driver );
	Connection conexao;
	conexao = DriverManager.getConnection(endereco, usuario, senha);

	String sql = "INSERT INTO cliente (nome, cpf, email, senha) VALUES (?,?,?,?)";

	PreparedStatement stm = conexao.prepareStatement(sql);
	stm.setString(1, vnome);
	stm.setString(2, vcpf);
	stm.setString(3, vemail);
	stm.setString(4, vsenha);

	stm.execute();
	conexao.close();
	stm.close();
	out.print("Dados efetuados com sucesso!");
%>