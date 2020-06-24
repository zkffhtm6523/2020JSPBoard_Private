<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO	"%>
<%@ page import="bbs.Bbs	"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");//창 띄우기
			script.println("location.href = 'login.jsp'"); //main.jsp로 돌려보냄
			script.println("</script>");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");//창 띄우기
			script.println("location.href = 'bbs.jsp'"); //main.jsp로 돌려보냄
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");//창 띄우기
			script.println("location.href = 'bbs.jsp'"); //main.jsp로 돌려보냄
			script.println("</script>");
		}else {
			BbsDAO bbsDAO = new BbsDAO();
			//userDAO에서 만든 login메서드
			int result = bbsDAO.delete(bbsID);
			//위의 userProperty의 name=user를 받아온다.
		if (result == -1) { // 데이터베이스 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패했습니다.')");
			script.println("history.back()"); //로그인 페이지로 돌려보냄
			script.println("</script>");
		//글 삭제가 성공적으로 이루어졌을 때
		} else { 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글이 성공적으로 삭제되었습니다.')");
			script.println("location.href = 'bbs.jsp'"); 
			script.println("</script>");
		}
			
		}
		
	%>
</body>