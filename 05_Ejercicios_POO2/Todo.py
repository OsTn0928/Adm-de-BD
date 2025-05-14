# Actividad práctica POO_2
# Echo Por VIcente Rojas 4°C
# Fecha de entrega: 14/05/2025

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
            print("Error: Debes ingresar un número entero válido. Intenta nuevamente.")  # si ponen letras o algo raro

# Esta funcion evalua si un numero decimal es mayor, menor o igual a 10
def evaluar_decimal():
    while True:
        try:
            numero = float(input("Ingresa un número decimal: "))  # pedimos un decimal (float)
            if numero > 10:
                print("El número es mayor que 10.")
            elif numero < 10:
                print("El número es menor que 10.")
            else:
                print("El número es igual a 10.")
            break
        except ValueError:
            print("Error: Debes ingresar un número decimal válido. Intenta nuevamente.")  # por si ponen letras o mal dato

# Esta funcion calcula el area de un triangulo con base y altura
def calcular_area_triangulo():
    while True:
        try:
            base = float(input("Ingresa la base del triángulo: "))  # pedimos base
            altura = float(input("Ingresa la altura del triángulo: "))  # pedimos altura
            area = (base * altura) / 2  # usamos la formula del triangulo
            print(f"El área del triángulo es: {area}")  # mostramos el resultado
            break
        except ValueError:
            print("Error: Ingrese valores numéricos válidos para base y altura.")  # si pone letras o algo raro

# Esta funcion pide nombre y edad y saluda
def saludar():
    nombre = input("Ingresa tu nombre: ")  # pedimos el nombre
    while True:
        try:
            edad = int(input("Ingresa tu edad: "))  # pedimos la edad
            print(f"Hola, {nombre}. Me alegra que tengas {edad} años.")  # saludamos
            break
        except ValueError:
            print("Error: La edad debe ser un número entero. Intenta nuevamente.")  # si ponen mal la edad

# Esta funcion suma varios numeros que el usuario decide
def sumar_numeros():
    while True:
        try:
            cantidad = int(input("¿Cuántos números quieres sumar?: "))  # cuántos numeros quiere sumar
            suma = 0  # iniciamos la suma en 0
            for i in range(cantidad):  # bucle para repetir las veces que dijo el usuario
                while True:
                    try:
                        numero = float(input(f"Ingrese el número {i+1}: "))  # pedimos el numero
                        suma += numero  # lo sumamos al total
                        break  # salimos del while interno
                    except ValueError:
                        print("Error: Ingrese un número válido.")  # si pone letras o algo asi
            print(f"La suma total es: {suma}")  # mostramos la suma final
            break
        except ValueError:
            print("Error: La cantidad debe ser un número entero. Intenta nuevamente.")  # si puso mal el número de veces
