<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.sql.*" %>
<% 
   int rootid=Integer.parseInt(request.getParameter("rootid"));
   int id =Integer.parseInt(request.getParameter("id"));
%>

<html>
  <head>
  </head>
  <body>
   <form method="post" action="ReplyOk.jsp">
     <input type="hidden" name="id" value="<%=id %>">
     <input type="hidden" name="rootid" value="<%=rootid%>">
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
