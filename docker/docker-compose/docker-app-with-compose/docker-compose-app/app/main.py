from pymongo import MongoClient

sensor_1 = {"id": "001", "name": "Temp", "location": "room1", "Value": "18"}
sensor_2 = {"id": "002", "name": "Temp", "location": "room2", "Value": "22"}

db_client = MongoClient('localhost', 27017)

data = db_client.detals
 
storage = data.storage

status = storage.insert_one(sensor_1)
print(status)