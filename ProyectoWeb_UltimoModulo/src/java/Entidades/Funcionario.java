package Entidades;

public class Funcionario extends Persona{

    //Atributos
    private int idFuncionario;
    private String ocupacion;
    
    //Constructores
    public Funcionario(int idFuncionario, String ocupacion, String cedula, String nombreCompleto, int edad, String telefono, String direccion, String correo, boolean existe) {
        super(cedula, nombreCompleto, edad, telefono, direccion, correo, existe);
        this.idFuncionario = idFuncionario;
        this.ocupacion = ocupacion;
    }
    
    public Funcionario(int idFuncionario, String ocupacion, String cedula, String nombreCompleto, int edad, String telefono, String direccion, String correo) {
        super(cedula, nombreCompleto, edad, telefono, direccion, correo, true);
        this.idFuncionario = idFuncionario;
        this.ocupacion = ocupacion;
    }
    
     public Funcionario() {
        super();
        this.idFuncionario = 0;
        this.ocupacion = "";
    }
     
    //Metodos de acceso 
    public int getIdFuncionario() {
        return idFuncionario;
    }

    public String getOcupacion() {
        return ocupacion;
    }

    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
    }

    public void setOcupacion(String ocupacion) {
        this.ocupacion = ocupacion;
    }
     
}
