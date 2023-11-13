from scripts import count_vehicles
import cv2


resultado = count_vehicles("detectar/1ddb6186-351a-46f7-bcf3-4e6466d5b2a6.jpeg")


print(resultado)

resultados = []
# Autos en imagen, indice indica la imagen
# imagen 4: 7 o 8?
# imagen 15: entre 12 o 14
# imagen 18: 15?
# imagen 19: 15?
autos_en_imagen = [0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 15, 15]

for i in range(20):
    ruta_imagen = f"detectar/IMG{i}.jpeg"

    resultado = count_vehicles(ruta_imagen)
    resultados.append(resultado)

for i, resultado in enumerate(resultados):
    mensaje = (
        "CORRECTO"
        if resultado == autos_en_imagen[i]
        else f"INCORRECTO {autos_en_imagen[i]}"
    )
    print(f"IMG{i}.jpeg: {resultado} - {mensaje}")
