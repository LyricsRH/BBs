<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.sql.*" %>

<%!
  String str=""; 
  private void tree(Connection con, int id,int level){
    Statement statement=null;
    ResultSet rs=null;
    String prestr="";
    for(int i =0;i<level;i++)
    {prestr+="-----";
    }
    try{
    statement=con.createStatement();
    String sql="select * from article where pid="+id;
    rs=statement.executeQuery(sql);
    while(rs.next())
    {
      str+="<tr><td>"+rs.getInt("id")+"</td><td>"+"<a href='ShowArticleDetail.jsp?id="+rs.getInt("id")+"'>"+prestr+rs.getString("title")
      +"</a>"+"<td><a href='delete.jsp?id="+rs.getInt("id")+"&pid="+rs.getInt("pid")+"'>删除</a></td>"
      +"</td></tr>";
      if(rs.getInt("isleaf")!=0)
      {
       tree(con,rs.getInt("id"),level+1);
      }
    }
    }catch(Exception e){e.printStackTrace();}
   finally{
     try{
      if(rs!=null) {rs.close();rs=null;}
      if (statement!=null){statement.close();statement=null;}
     }catch(Exception e){e.printStackTrace();
     }
   }
  }
 
%>
<% 
  Class.forName("com.mysql.jdbc.Driver");
  String url="jdbc:mysql://localhost:3306/bbs?user=root&password=123456&useSSL=true";
  Connection con=DriverManager.getConnection(url);
  
  Statement statement=con.createStatement();
  ResultSet rs=statement.executeQuery("select * from article where pid=0");
  
  while(rs.next())
  {  str+="<tr><td>"+rs.getInt("id")+"</td><td>"+"<a href='ShowArticleDetail.jsp?id="+rs.getInt("id")+"'>"+rs.getString("title")+"</a>"
      +"<td><a href='delete.jsp?id="+rs.getInt("id")+"&pid="+rs.getInt("pid")+"'>删除</a></td>"+"</td></tr>";
      if(rs.getInt("isleaf")!=0){
        tree(con,rs.getInt("id"),1);
      }
  }
  rs.close();
  statement.close();
  con.close();
 
%>

<html>
<head>
  <title> 哈</title>
</head>
<body>
  <a href="publis.jsp">发布新帖子</a>
 <table border="1">
 <%=str %>
 <%=str="" %>
 </table>
</body>
</html>
