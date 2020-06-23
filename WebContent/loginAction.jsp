<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어 있습니다.')");//창 띄우기
		script.println("location.href = 'main.jsp'"); //main.jsp로 돌려보냄
		script.println("</script>");
	}
	UserDAO userDAO = new UserDAO();
	//userDAO에서 만든 login메서드
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	//로그인 성공 했을 때------------------------------------------
	if (result == 1) { // 비밀번호 일치
		session.setAttribute("userID", user.getUserID()); //로그인 한 회원은 세션을 부여받음
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main.jsp'"); //메인 페이지로 이동
		script.println("</script>");
		//----------------------------------------------------
	} else if (result == 0) { //비밀번호가 다를 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()"); //로그인 페이지로 돌려보냄
		script.println("</script>");
	} else if (result == -1) { //아이디가 존재하지 않음.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 존재하지 않습니다.')");
		script.println("history.back()"); //로그인 페이지로 돌려보냄
		script.println("</script>");
	} else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>