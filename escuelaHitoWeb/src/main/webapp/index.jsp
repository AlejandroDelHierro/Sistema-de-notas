<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="logica.Usuario"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.ServletContext"%>
<%@ page import="logica.Alumno"%>
<%@ page import="logica.Profesor"%>
<%@ page import="servlets.Login"%>


<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.login-container {
	background-color: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	width: 300px;
	text-align: center;
}

h2 {
	margin-bottom: 20px;
	font-size: 24px;
	color: #333;
}

.error-message {
	color: red;
	margin-bottom: 15px;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 16px;
	box-sizing: border-box;
}

input[type="text"]:focus, input[type="password"]:focus {
	border-color: #007BFF;
	outline: none;
}

button {
	background-color: #007BFF;
	color: white;
	padding: 10px;
	width: 100%;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
}

button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>

	<%
	// Obtenemos la sesion actual si existe y la almacenamos
    HttpSession currentSession = request.getSession(false);
    if (currentSession != null && currentSession.getAttribute("usuario") != null) {
        Usuario usuario = (Usuario) currentSession.getAttribute("usuario");
        if (usuario instanceof Profesor) {
            response.sendRedirect("profesor.jsp");
        } else if (usuario instanceof Alumno) {
            response.sendRedirect("alumno.jsp");
        }
        return;
    }
    %>
	<div class="login-container">
		<h2>Login</h2>
		<!-- Mostrar el mensaje de error si existe -->
		<c:if test="${not empty errorMessage}">
			<p class="error-message">${errorMessage}</p>
		</c:if>
		<form action="Login" method="post">
			<input type="text" name="login" placeholder="Usuario" required>
			<input type="password" name="password" placeholder="Contraseña"
				required>
			<button type="submit">Iniciar sesión</button>
		</form>
	</div>



</body>
</html>
