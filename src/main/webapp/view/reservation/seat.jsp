<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<% for (int i=1;i<=20;i++) {
      if (i%5==1) {%><tr><%} %>
		<% List<String> totse = (List<String>)request.getAttribute("totse"); 
  	  if (totse.contains(i+"")) {%>   
  			<td><button type="button" class="btn btn-dark"></button></td> 
 <%}  else {  
        if(i<=5) {%>
            <td><button type="button" class="btn btn-danger" value="<%=i %>"></button></td>
        <% } else if(i<=10) {%>
             <td><button type="button" class="btn btn-warning" value="<%=i %>"> </button></td>
         <%} else if(i<=15){%>
           <td><button type="button" class="btn btn-success" value="<%=i %>"></button></td>
         <% }else if(i<=20){%>
            <td><button type="button" class="btn btn-primary" value="<%=i %>"></button></td>
         <% } %>
<% }if(i%5==0){%>
   </tr>
<% 
}} %>

