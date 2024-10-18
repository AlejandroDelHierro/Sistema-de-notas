<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="logica.Alumno"%>
<%@ page import="logica.Calificacion"%>
<%@ page import="logica.Escuela"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Calificaciones del Alumno</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #333;
        }
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .calificaciones-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        .logout-button {
            padding: 10px 20px;
            border: none;
            background-color: #f44336;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        .logout-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="header-container">
        <h1>Bienvenido, ${sessionScope.usuario.login}</h1>
        <form action="CerrarSesion" method="post">
            <button type="submit" class="logout-button">Volver al Login</button>
        </form>
    </div>

    <div class="calificaciones-container">
        <h2>Calificaciones</h2>
        <table>
            <thead>
                <tr>
                    <th>Asignatura</th>
                    <th>Nota</th>
                    <th>Profesor</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Obtenemos la sesión y el alumno actual
                    Alumno alumno = (Alumno) session.getAttribute("usuario");

                    // Verificamos si el alumno tiene alguna calificacion y si es asi las mostramos por pantalla
                    if (alumno != null && !alumno.getCalificaciones().isEmpty()) {
                        List<Calificacion> calificaciones = alumno.getCalificaciones();
                        for (Calificacion calificacion : calificaciones) {
                %>
                    <tr>
                        <td><%= calificacion.getAsignatura() %></td>
                        <td><%= calificacion.getNota() %></td>
                        <td><%= calificacion.getProfesor().getLogin() %></td>
                    </tr>
                <%
                        }
                      // Si no tiene calificaciones mostrara el siguiente mensaje
                    } else {
                %>
                    <tr>
                        <td colspan="3">No tienes calificaciones disponibles.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>
