from pymongo import MongoClient

db_client = MongoClient('localhost', 27017)
db = client.admin
dbs_list = db.command('listDatabases')
pprint(dbs_list)
