<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="logica.Escuela"%>
<%@ page import="logica.Alumno"%>
<%@ page import="logica.Usuario"%>
<%@ page import="java.util.Map"%>
<%@ page import="logica.Calificacion"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel del Profesor</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }

    .header-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .alumnos-container {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
    }

    h2 {
        color: #333;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th,
    td {
        padding: 10px;
        border: 1px solid #ccc;
        text-align: left;
    }

    th {
        background-color: #007BFF;
        color: white;
    }

    .form-container {
        margin-top: 20px;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    /* Estilo para el botón de logout */
    .logout-button {
        background-color: #f44336;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    .logout-button:hover {
        background-color: #d32f2f;
    }

    .form-group {
        margin-bottom: 15px; 
    }

    label {
        display: block;
        margin-bottom: 5px; 
        font-weight: bold; 
    }

    input[type="text"],
    input[type="number"],
    select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc; 
        border-radius: 5px;
        font-size: 16px; 
        transition: border-color 0.3s;
    }

    input[type="text"]:focus,
    input[type="number"]:focus,
    select:focus {
        border-color: #007BFF;
        outline: none; 
    }

    .submit-button {
        background-color: #007BFF; 
        color: white; 
        border: none; 
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px; 
        transition: background-color 0.3s; 
    }

    .submit-button:hover {
        background-color: #0056b3; 
    }

    .success-message {
        color: green;
        margin-top: 10px;
    }

    .error-message {
        color: red;
        margin-top: 10px;
    }
</style>

</head>
<body>
    <div class="header-container">
        <h1>Bienvenido, ${sessionScope.usuario.login}</h1>
        <!-- Botón para volver al login -->
        <form action="CerrarSesion" method="post">
            <button type="submit" class="logout-button">Cerrar Sesion</button>
        </form>
    </div>

    <div class="alumnos-container">
        <h2>Lista de Alumnos</h2>
        <table>
            <thead>
                <tr>
                    <th>Login</th>
                    <th>Calificaciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Obtenemos la escuela desde el contexto de la aplicación
                    Escuela escuela = (Escuela) application.getAttribute("escuela");
                    // Obtenemos la lista de los usuarios que sean alumnos
                    Map<String, Usuario> usuarios = escuela.getUsuarios();

                    // Filtramos y mostramos solo los alumnos del mapa de usuarios
                    for (Usuario usuario : usuarios.values()) {
                        if (usuario instanceof Alumno) {
                            Alumno alumno = (Alumno) usuario;
                %>
                    <tr>	
                        <td><%= alumno.getLogin() %></td>
                        <td>
                            <%
                            	// Ahora hacemos un if que en caso de que el array de calificaciones no este vacio con un bucle for lo recorremos y mostramos todo su contenido
                                if (!alumno.getCalificaciones().isEmpty()) {
                                    out.print("<ul>");
                                    for (Calificacion calificacion : alumno.getCalificaciones()) {
                                        out.print("<li>" + calificacion.getAsignatura() + " (" + calificacion.getProfesor().getLogin() + "): " + calificacion.getNota() + "</li>");
                                    }
                                    out.print("</ul>");
                                } else {
                                    out.print("Sin calificaciones.");
                                }
                            %>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <div class="form-container">
    <h2>Añadir Calificación</h2>
    <form action="CalificacionServlet" method="post">
        <label for="loginAlumno">Login del Alumno:</label>
        <input type="text" id="loginAlumno" name="loginAlumno" required><br><br>

        <label for="asignatura">Asignatura:</label>
        <select id="asignatura" name="asignatura" required>
            <option value="">Seleccione una asignatura</option>
            <option value="Matemáticas">Matemáticas</option>
            <option value="Física">Física</option>
            <option value="Química">Química</option>
            <option value="Lengua">Lengua</option>
            <option value="Educación Física">Educación Física</option>
        </select><br><br>

        <label for="nota">Nota (1-100):</label>
        <input type="number" id="nota" name="nota" min="1" max="100" required><br><br>

        <button type="submit" class="submit-button">Añadir Calificación</button>
    </form>

    <%
    	// Si la calificacion se ha mandado correctamente mostrara un mensaje en verde
        if (request.getAttribute("message") != null) {
            out.print("<p style='color:green'>" + request.getAttribute("message") + "</p>");
        }
    	// Si ha habido algun error mandará un mensaje en rojo
        if (request.getAttribute("error") != null) {
            out.print("<p style='color:red'>" + request.getAttribute("error") + "</p>");
        }
    %>
    </div>
</body>
</html>
