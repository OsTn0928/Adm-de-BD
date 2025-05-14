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
