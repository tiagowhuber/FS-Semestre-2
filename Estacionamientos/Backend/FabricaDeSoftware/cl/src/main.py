from fastapi import FastAPI, Request, WebSocket, WebSocketDisconnect
from pydantic import BaseModel
from typing import Union
from scripts import count_vehicles
import asyncio
import uvicorn
import random
import Router
import cv2
app = FastAPI()

class Item(BaseModel):
    cars: int

#define the total parking spots
global TOTAL_PARKING_SPOTS
TOTAL_PARKING_SPOTS = 50

#define the total available spots
global AVAILABLE_SPOTS
AVAILABLE_SPOTS = TOTAL_PARKING_SPOTS

#define the total used spots in parking
global USED_SPOTS
global img_counter

img_counter=0



USED_SPOTS = count_vehicles("detectar/1ddb6186-351a-46f7-bcf3-4e6466d5b2a6.jpeg")


class ConnectionManager:
    def __init__(self):
        self.active_connections: List[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def send_personal_message(self, message: str, websocket: WebSocket):
        await websocket.send_text(message)

    async def broadcast(self, message: str):
        for connection in self.active_connections:
            await connection.send_text(message)

manager = ConnectionManager()


@app.websocket(Router.WEBOCKET)
async def websocket_endpoint(websocket: WebSocket):
    global TOTAL_PARKING_SPOTS
    global USED_SPOTS
    await manager.connect(websocket)

    try:
        while True:
            await asyncio.sleep(2)
            await websocket.send_text(f"Estacionamientos disponibles: {TOTAL_PARKING_SPOTS - USED_SPOTS}")
    except WebSocketDisconnect:
        manager.disconnect(websocket)
        await manager.broadcast(f"Cliente ha cerrado la conexion")
    

@app.get(Router.GET_MAIN_API_LANDING)
def ping():
    return {"Ping": "Pong"}


@app.get(Router.GET_AVAILABLE_SPACES)
async def available_spaces():
    global USED_SPOTS
    global img_counter

    camara = cv2.VideoCapture(0)

    ret,frame = camara.read()

    if ret == True:
        print("Aderntrooo")

        cv2.imwrite('detectar/IMG'+str(img_counter)+'.jpeg',frame)
        count='detectar/IMG'+str(img_counter)+'.jpeg'
        USED_SPOTS = count_vehicles(count)
        img_counter=img_counter+1
        
        print(USED_SPOTS) 
        
    camara.release()

    return {"cars_parked": USED_SPOTS, "available_spaces": TOTAL_PARKING_SPOTS - USED_SPOTS}


@app.put(Router.PUT_TOTAL_SPACES)
async def update_total_spaces(total_spaces: int):
    global TOTAL_PARKING_SPOTS
    TOTAL_PARKING_SPOTS = total_spaces
    return {"total_spaces": TOTAL_PARKING_SPOTS}


@app.post(Router.POST_USED_SPACES)
async def used_spots(item: Item):
    global USED_SPOTS
    USED_SPOTS = item.cars
    return item

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
    cv2.destroyAllWindows()  
