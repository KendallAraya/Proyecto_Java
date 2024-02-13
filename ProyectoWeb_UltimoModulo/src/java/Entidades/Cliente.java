package Entidades;

public class Cliente extends Persona{

    //Atributos
    private int idCliente;
    
    //Constructor con parametros
    public Cliente(int idCliente, String cedula, String nombreCompleto, int edad, String telefono, String direccion, String correo, boolean existe) {
        super(cedula, nombreCompleto, edad, telefono, direccion, correo, existe);
        this.idCliente = idCliente;
    }
    
    public Cliente(int idCliente, String cedula, String nombreCompleto, int edad, String telefono, String direccion, String correo ) {
        super(cedula, nombreCompleto, edad, telefono, direccion, correo, true);
        this.idCliente = idCliente;
    }
    
    //Construcrtor sin parametros
    public Cliente() {
        super();
        this.idCliente = 0;
    }
    
    //Metodos de acceso
    public int getIdCliente() {
        return idCliente;
    }
    
    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }
    
}
