package logica;

public class Calificacion {
	private Profesor profesor;
	private String asignatura;
	private int nota; // Valor entre 0 y 100.
	
	public Calificacion(Profesor profesor, String asignatura, int nota) {
		super();
		this.profesor = profesor;
		this.asignatura = asignatura;
		this.nota = nota;
	}

	public Profesor getProfesor() {
		return profesor;
	}

	public void setProfesor(Profesor profesor) {
		this.profesor = profesor;
	}

	public String getAsignatura() {
		return asignatura;
	}

	public void setAsignatura(String asignatura) {
		this.asignatura = asignatura;
	}

	public int getNota() {
		return nota;
	}

	public void setNota(int nota) {
		this.nota = nota;
	}

	@Override
	public String toString() {
		return "Asignatura: " + asignatura + ", Nota: " + nota + " - Calificado por " + this.profesor.toString();
	}
	
	
}
