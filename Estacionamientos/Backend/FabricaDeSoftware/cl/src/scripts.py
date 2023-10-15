import torch
from pathlib import Path
import sys


sys.path.append(str(Path(__file__).parent / 'yolov5'))
from yolov5.models.experimental import attempt_load
from yolov5.utils.dataloaders import LoadImages
from yolov5.utils.general import check_img_size, non_max_suppression, apply_classifier, scale_segments, xyxy2xywh
from yolov5.utils.downloads import attempt_download




def count_vehicles(img_path):
    # Cargar el modelo de yolo
    model = attempt_load('yolov5/Backend/yolov5s.pt')

    #Se definen las id de los vehiculos a detectar
    car_id = 2
    truck_id = 7

    dataset = LoadImages(img_path, img_size=640)
    path, img, im0s, _ , s= next(iter(dataset))
    img = torch.from_numpy(img).to(torch.device('cpu'))
    img = img.float()
    img /= 255.0
    if img.ndimension() == 3:
        img = img.unsqueeze(0)
    pred = model(img)[0]
    pred = non_max_suppression(pred, 0.25, 0.45, classes=[car_id, truck_id], agnostic=None)


    #Se cuentan la cantidad de autos detectados al igual que las camionetas
    car_count = 0
    truck_count = 0

    for det in pred:
        if det is not None and len(det):
            for *xyxy, conf, cls in det:
                if cls.item() == car_id:
                    car_count += 1
                elif cls.item() == truck_id:
                    truck_count += 1
    #Se retorna la suma de los autos y camionetas detectados
    return car_count + truck_count