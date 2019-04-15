<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.sql.*" %>
<% 
  int id=Integer.parseInt(request.getParameter("id"));
  int root=Integer.parseInt(request.getParameter("rootid"));
  String title=request.getParameter("title");
  String cont=request.getParameter("cont");

  Class.forName("com.mysql.jdbc.Driver");
  String url="jdbc:mysql://localhost:3306/bbs?user=root&password=123456&useSSL=true";
  Connection con=DriverManager.getConnection(url);
  String sql="insert into article values(null,?,?,?,?,now(),0)";
  PreparedStatement statement=con.prepareStatement(sql);
  statement.setInt(1,id);
  statement.setInt(2, root);
  statement.setString(3, title);
  statement.setString(4, cont);
  statement.executeUpdate();
  
  statement.executeUpdate("update article set isleaf=1 where id="+id);

  con.setAutoCommit(true);
  
  statement.close();
  con.close();
  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  
  </head>
  
  <body>
    <font color="red" size="7">
     ok!
    </font>
  </body>
</html>
