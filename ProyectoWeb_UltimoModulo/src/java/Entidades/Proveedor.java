package Entidades;


public class Proveedor {
    
    //Atributos
    private int idProveedor;
    private String nombre;
    private String numeroContacto;
    private String ubicacion;
    private boolean existe;
    
    //Constructores
    public Proveedor(int idProveedor, String nombre, String numeroContacto, String ubicacion, boolean existe) {
        this.idProveedor = idProveedor;
        this.nombre = nombre;
        this.numeroContacto = numeroContacto;
        this.ubicacion = ubicacion;
        this.existe = existe;
    }
    
    public Proveedor(int idProveedor, String nombre, String numeroContacto, String ubicacion) {
        this.idProveedor = idProveedor;
        this.nombre = nombre;
        this.numeroContacto = numeroContacto;
        this.ubicacion = ubicacion;
    }
    
    public Proveedor() {
        this.idProveedor = 0;
        this.nombre = "";
        this.numeroContacto = "";
        this.ubicacion = "";
        this.existe = false;
    }
    
    //Metodos de acceso 
    public int getIdProveedor() {
        return idProveedor;
    }

    public String getNombre() {
        return nombre;
    }

    public String getNumeroContacto() {
        return numeroContacto;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setNumeroContacto(String numeroContacto) {
        this.numeroContacto = numeroContacto;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }
    
    public void setExiste(boolean existe) {
        this.existe = existe;
    }

    public boolean isExiste() {
        return existe;
    }
}
