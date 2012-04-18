<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Web page testing user parameters</title>
</head>
<h1>User Information</h1>
<body>

<form>
	First name: <%=request.getParameter("userFirstName") %>
	last name: <%=request.getParameter("userLastName") %>
	
</form>
</body>
</html>