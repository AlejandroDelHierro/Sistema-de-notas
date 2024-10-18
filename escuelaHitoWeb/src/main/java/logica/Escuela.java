package logica;

import java.util.TreeMap;

public class Escuela {
    private TreeMap<String, Usuario> usuarios;

    public Escuela() {
        usuarios = new TreeMap<>();
    }

    public void nuevoProfesor(String login, String password, String especialidad) {
        usuarios.put(login, new Profesor(login, password, especialidad));
    }

    public void nuevoAlumno(String login, String password) {
        usuarios.put(login, new Alumno(login, password));
    }

    public TreeMap<String, Usuario> getUsuarios() {
        return usuarios;
    }
}
