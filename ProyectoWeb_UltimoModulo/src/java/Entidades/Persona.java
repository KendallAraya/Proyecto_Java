package Entidades;

public class Persona {

    private String cedula;
    private String nombreCompleto;
    private int edad;
    private String telefono;
    private String direccion;
    private String correo;
    private boolean existe;
    
    //Constructor con parametros 
    public Persona(String cedula, String nombreCompleto, int edad, String telefono, String direccion, String correo, boolean existe) {
        this.cedula = cedula;
        this.nombreCompleto = nombreCompleto;
        this.edad = edad;
        this.telefono = telefono;
        this.direccion = direccion;
        this.correo = correo;
        this.existe = existe;
    }
    
    //Constructor sin parametros 
    public Persona() {
        this.cedula = "";
        this.nombreCompleto = "";
        this.edad = 0;
        this.telefono = "";
        this.direccion = "";
        this.correo = "";
        this.existe = false;
    }
    
    //Metodos de entrada 
    public String getCedula() {
        return cedula;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public int getEdad() {
        return edad;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public String getCorreo() {
        return correo;
    }
    
    public boolean isExiste() {
        return existe;
    }
    
    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }
    
    public void setExiste(boolean existe) {
        this.existe = existe;
    }
    
}
