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
import logica.Profesor;
import logica.Usuario;
import logica.Escuela;

@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Escuela escuela;

    // Inicializamos usuarios y profesores
    public void init() throws ServletException {
        super.init();

        ServletContext contexto = this.getServletContext();
        // Inicializamos la escuela y su TreeMap de usuarios
        Escuela escuela = new Escuela();

        // Añadimos profesores
        escuela.nuevoProfesor("Alex", "1234", "Matemáticas");
        escuela.nuevoProfesor("David", "1234", "Física");

        // Añadimos alumnos
        escuela.nuevoAlumno("Sergio", "1234");
        escuela.nuevoAlumno("Alberto", "1234");

        contexto.setAttribute("escuela", escuela);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirigir directamente al formulario de login en index.jsp
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ServletContext contexto = getServletContext();

        Escuela escuela = (Escuela) contexto.getAttribute("escuela");

        // Obtenemos parámetros del formulario de login y los almacenamos en variables
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        // Validamos que el login y el password no estén vacíos
        if (login != null && password != null) {
            // Intentamos recuperar el usuario de la escuela		
            Usuario usuario = escuela.getUsuarios().get(login);

            if (usuario != null && usuario.getPassword().equals(password)) {
                // Si las credenciales introducidas son correctas, crea una sesión nueva
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);

                // Redirigir según el tipo de usuario
                if (usuario instanceof Profesor) {
                    response.sendRedirect("profesor.jsp");
                } else if (usuario instanceof Alumno) {
                    response.sendRedirect("alumno.jsp");
                }
            } else {
                // Mensaje de error cuando se introduce uno de los parámetros mal
                request.setAttribute("errorMessage", "Usuario o contraseña incorrectos");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            // Mensaje de error en caso de que uno de los campos esté vacío
            request.setAttribute("errorMessage", "Por favor, rellena todos los campos");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
