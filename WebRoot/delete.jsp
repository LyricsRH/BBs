<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.sql.*" %>
<%!
   private void del(Connection con,int id)
   {
     Statement statement=null;
     ResultSet rSet=null;
     try{
       statement=con.createStatement();
       String sql="select * from article where pid="+id;
       rSet=statement.executeQuery(sql);
       while(rSet.next())
       {
         del(con, rSet.getInt("id"));
       }
       statement.executeUpdate("delete from article where id="+id);
     }
     catch(Exception sqlException)
     {sqlException.printStackTrace();}
     finally
     {try{
      if(rSet!=null){
       rSet.close();
       rSet=null;
      }
     if(statement!=null)
     { statement.close();
       statement=null;}
     }
     catch(Exception e)
     {e.printStackTrace();}
   }
   }
 
   %>

<% 
   int id=Integer.parseInt(request.getParameter("id"));
   int pid=Integer.parseInt(request.getParameter("pid"));
   
   Class.forName("com.mysql.jdbc.Driver");
  String url="jdbc:mysql://localhost:3306/bbs?user=root&password=123456&useSSL=true";
  Connection con=DriverManager.getConnection(url);
  
  con.setAutoCommit(false);
  
  del(con, id);
  Statement statement=con.createStatement();
  ResultSet rs=statement.executeQuery("select count(*) from article where pid="+pid);
  
  rs.next();
  int count=rs.getInt(1);
  rs.close();
  statement.close();
  
  
  if(count<=0){
    Statement stateUpdate=con.createStatement();  
    stateUpdate.executeUpdate("update article set isleaf=0 where id="+pid);
    stateUpdate.close();
  }
  
  con.commit();
  con.setAutoCommit(true);
  response.sendRedirect("MyJsp.jsp");
  
%>