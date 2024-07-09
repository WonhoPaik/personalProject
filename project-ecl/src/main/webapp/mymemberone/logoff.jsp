<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    session.invalidate();

// 로그아웃 후 메인 페이지로 리다이렉트합니다.
response.sendRedirect("mainPage.jsp");
%>