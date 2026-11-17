<?php

class conexion
{
    private $host = "localhost";
    private $port = "3306";
    private $db_name = "multishop_prueba";
    private $username = "root";
    private $password = "";
    public $conexion;

    public function conectar()
    {
        // MULTISHOP_DB_PORT solo se usa si se quiere apuntar a otra instancia de MySQL (por ejemplo, para pruebas).
        $puerto = getenv('MULTISHOP_DB_PORT') ?: $this->port;
        $dsn = "mysql:host={$this->host};port={$puerto};dbname={$this->db_name};charset=utf8mb4";
        return new PDO($dsn, $this->username, $this->password, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]);
    }
}
