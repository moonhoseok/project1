<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<%
  try{
     Class.forName("org.mariadb.jdbc.Driver");
     out.println("����Ŭ ����̹� �˻� ���� <br>");
 }
  catch(ClassNotFoundException e){
      out.println("����̹� �˻� ����<br>");
   }
 String url ="jdbc:mariadb://14.36.141.71:20000/gdudb5";
 String id = "gdu5";
 String pass = "5555";
 try{
     Connection con = DriverManager.getConnection(url,id,pass);
      out.println("MySQL  ��� ���� �Ǿ����ϴ�.");
 }
 catch(SQLException e){ 
     out.println("MySQL ���ῡ ����"); 
     e.printStackTrace();
   }
 %>
</body></html>