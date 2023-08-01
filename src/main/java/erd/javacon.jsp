<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<%
  try{
     Class.forName("org.mariadb.jdbc.Driver");
     out.println("오라클 드라이버 검색 성공 <br>");
 }
  catch(ClassNotFoundException e){
      out.println("드라이버 검색 실패<br>");
   }
 String url ="jdbc:mariadb://14.36.141.71:20000/gdudb5";
 String id = "gdu5";
 String pass = "5555";
 try{
     Connection con = DriverManager.getConnection(url,id,pass);
      out.println("MySQL  디비가 연결 되었습니다.");
 }
 catch(SQLException e){ 
     out.println("MySQL 연결에 실패"); 
     e.printStackTrace();
   }
 %>
</body></html>