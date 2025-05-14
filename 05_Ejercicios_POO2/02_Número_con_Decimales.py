# Esta funcion evalua si un numero decimal es mayor, menor o igual a 10
def evaluar_decimal():
    while True:
        try:
            numero = float(input("Ingresa un número decimal: "))  # pedimos un decimal (float)
            
            if numero > 10:
                print("El número es mayor que 10.") #Muestra si el numero es mayor a 10
            elif numero < 10:
                print("El número es menor que 10.") #Muestra si el numero es menor a 10
            else:
                print("El número es igual a 10.") #Muestra si el numero es igual a 10
            break
        except ValueError:
            print("Error: Debes ingresar un número decimal válido. Intenta nuevamente.")  # por si ponen letras o mal dato
    
evaluar_decimal()