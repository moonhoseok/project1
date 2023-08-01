<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:if test="${!empty c[0].time1}">
		<option value="${c[0].time1}">${c[0].time1}</option>
	</c:if>
	<c:if test="${!empty c[0].time2}">
		<option value="${c[0].time2}">${c[0].time2}</option>
	</c:if>
	<c:if test="${!empty c[0].time3}">
		<option value="${c[0].time3}">${c[0].time3}</option>
	</c:if>