package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CerrarSesion")
public class CerrarSesion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	// Guarda la sesion actual en una variable
        HttpSession session = request.getSession(false);
        
        // Si existe la sesion la invalida, es decir, cierra sesion y redirige al usuario al index.jsp
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("index.jsp");
    }
}
