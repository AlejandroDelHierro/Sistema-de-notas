package servlets;

import java.io.IOException;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logica.Alumno;
import logica.Calificacion;
import logica.Profesor;
import logica.Escuela;

@WebServlet("/CalificacionServlet")
public class CalificacionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtenemos la sesión y el profesor actual para poder calificar a los alumnos
        HttpSession session = request.getSession();
        Profesor profesor = (Profesor) session.getAttribute("usuario");

        // Obtenemos la clase escuela desde el contexto de la aplicación
        ServletContext contexto = getServletContext();
        Escuela escuela = (Escuela) contexto.getAttribute("escuela");

        // Obtenemos los parámetros del formulario en el que añadimos la calificacion
        String loginAlumno = request.getParameter("loginAlumno");
        String asignatura = request.getParameter("asignatura");
        int nota = Integer.parseInt(request.getParameter("nota"));

        // Buscamos al alumno por su login (nombre)
        Alumno alumno = (Alumno) escuela.getUsuarios().get(loginAlumno);

        if (alumno != null) {
            // Creamos una nueva calificación y la añadimos al alumno
            Calificacion calificacion = new Calificacion(profesor, asignatura, nota);
            alumno.getCalificaciones().add(calificacion);

            // Confirmamos que la calificación se ha hecho correctamente
            request.setAttribute("message", "Calificación añadida exitosamente a " + loginAlumno);
        } else {
            // Si el alumno no es encontrado, mostrara un mensaje de error
            request.setAttribute("error", "Alumno no encontrado.");
        }

        // Redirigimos al profesor.jsp
        request.getRequestDispatcher("profesor.jsp").forward(request, response);
    }
}
