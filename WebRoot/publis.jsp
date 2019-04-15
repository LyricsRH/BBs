<%@page import="jdk.nashorn.internal.ir.RuntimeNode.Request"%>
<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.sql.*" %>
<% 
  String title=request.getParameter("title");
  String cont=request.getParameter("cont");
  String post=request.getParameter("action");
  
  if(post!=null&&post.equals("post")){
  Class.forName("com.mysql.jdbc.Driver");
  String url="jdbc:mysql://localhost:3306/bbs?user=root&password=123456&useSSL=true";
  Connection con=DriverManager.getConnection(url);
  String sql="insert into article values(null,0,?,?,?,now(),0)";
  PreparedStatement statement=con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
  statement.setInt(1,-1);
  statement.setString(2, title);
  statement.setString(3, cont);
  statement.executeUpdate();
  
  ResultSet rskey=statement.getGeneratedKeys();
  rskey.next();
  int key=rskey.getInt(1);
  statement.executeUpdate("update article set rootid="+key+" where id="+key);


  
  statement.close();
  con.close();
  }
%>
<html>
  <head>
  </head>
  <body>
   <form method="post" action="publis.jsp">
     <input type="hidden" name="action" value="post">
     <table border="1">
        <tr>
          <td>
            <input type="text" name="title" size="30">
          </td>
        </tr>
        <tr>
          <td>
            <textarea cols="60" rows="12" name="cont"></textarea>
          </td>
        </tr>
        <tr>
           <td>
            <input type="submit" value="Ìá½»">
           </td>
        </tr>   
     </table>
   </form>
  </body>
</html>
