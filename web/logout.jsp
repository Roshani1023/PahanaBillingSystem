<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // Destroys the session
    response.sendRedirect("login.jsp?logout=success");
%>
