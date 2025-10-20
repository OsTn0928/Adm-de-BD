import mysql.connector
from mysql.connector import Error

try:
    conn = mysql.connector.connect(
        host='Localhost',     
        user='root',        
        password='1234',
        database='camaras_seguridad_db', 
        port=3306
    )

    if conn.is_connected():
        print("Conectado correctamente a MySQL")

        cursor = conn.cursor()

        # Ejemplo de consulta:
        consulta = "SELECT * FROM camaras"   # coloca tu tabla
        cursor.execute(consulta)

        resultados = cursor.fetchall()
        for fila in resultados:
            print(fila)

        cursor.close()

except Error as e:
    print("Error al conectar a MySQL:", e)

finally:
    if 'conn' in locals() and conn.is_connected():
        conn.close()
        print("Conexión cerrada")
