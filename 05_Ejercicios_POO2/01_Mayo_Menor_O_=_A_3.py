# Esta funcion evalua si un numero entero es mayor, menor o igual a 10
def evaluar_entero():
    while True:  # usamos un ciclo para repetir hasta que se ingrese bien
        try:
            numero = int(input("Ingresa un número entero: "))  # pedimos el numero al usuario
            if numero > 10:
                print("El número es mayor que 10.")  # si es mayor a 10
            elif numero < 10:
                print("El número es menor que 10.")  # si es menor a 10
            else:
                print("El número es igual a 10.")  # si es igual a 10
            break  # salimos del bucle si todo esta bien
        except ValueError:
            print("Error: Debes ingresar un número entero válido. Intenta nuevamente.")  # si ponen letras o algo raro como decimales
