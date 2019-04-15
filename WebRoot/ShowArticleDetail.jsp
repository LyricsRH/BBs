<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.sql.*"%>
<%
  Class.forName("com.mysql.jdbc.Driver");
  String url="jdbc:mysql://localhost:3306/bbs?user=root&password=123456&useSSL=true";
  Connection con=DriverManager.getConnection(url);
  
  Statement statement=con.createStatement();
  
  ResultSet rs=statement.executeQuery("select * from article where id="+request.getParameter("id"));
  
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  </head>
  <body>
  <%if(rs.next()){ %>
    <table border=1>
      <tr>
        <td>id</td><td><%=rs.getInt("id")%></td>
      </tr>
      <tr>
        <td>title</td><td><%=rs.getString("title")%> </td>
      </tr>
      <tr>
        <td>content</td><td><%=rs.getString("cont") %></td>
      </tr>
    </table>
    
    <a href="Reply.jsp?id=<%=rs.getInt("id")%>&rootid=<%=rs.getInt("rootid")%>">·¢²¼Ìû×Ó</a>
  
  <%}
  rs.close();
  statement.close();
  con.close();
   %>
  </body>
</html>
