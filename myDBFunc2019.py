import mysql.connector
from mysql.connector import Error


class Customer() :
    def __init__(self, data) :
        self.custDataObj = CustomerDB(data)
        
    def write(self) :
        return self.custDataObj.writeDB("project","store")
        
    def search(self) :
        return self.custDataObj.searchDB("project","store")
    
    def searchName(self) :
        return self.custDataObj.searchNameDB("project","store")

    def getInfo(self) :
        return self.custDataObj.data
    

class CustomerDB() :

    def __init__(self, data) :
        self.data = data


    def writeDB(self, databasename, table) :
        wdata=self.data

        try:
            connection = mysql.connector.connect(host='localhost',
                                                 database="project",
                                                 user='root',
                                                 password='bosskungz0121410')
       
            objdata = [wdata[0], wdata[1],wdata[2]]
            
            sqlQuery = "insert into "+ table + " values ({},{},{})".format(objdata[0],objdata[1],objdata[2])
            print(sqlQuery)
            
            cursor = connection.cursor()
            cursor.execute(sqlQuery, objdata)
            
            connection.commit()
            

        except:
            retmsg = ["1", "writing error"]
        else :
            retmsg = ["0", "writing done"]
        finally:
            if (connection.is_connected()):
                connection.close()
                cursor.close()
            return retmsg

                

    #writeDB("testdb", "test", ["0007","Somsiri"])
                
    ##########################################################################

    def searchDB(self, databasename, table) :
        wkey = str(self.data[0])

        try:
            connection = mysql.connector.connect(host='localhost',
                                                 database='project',
                                                 user='root',
                                                 password='bosskungz0121410')
            objdata = (wkey,)
            sqlQuery = "select * from "+table+" where store_id = {}".format(objdata[0])
            print(sqlQuery)
            
            cursor = connection.cursor()
            cursor.execute(sqlQuery)
            records = cursor.fetchone()
            self.data = records
                    
        except:
            retmsg = ["1", "Error"]
        else :
            retmsg = ["1", "Not Found"]
            if records[1] != "" :
                retmsg = ["0", "Found"]
        finally:
            if (connection.is_connected()):
                connection.close()
                cursor.close()
            return retmsg


    ##########################################################################

    def searchNameDB(self, databasename, table) :
        wkey = str(self.data[1]) #correct here

        try:
            connection = mysql.connector.connect(host='localhost',
                                                 database='project',
                                                 user='root',
                                                 password='bosskungz0121410')
            objdata = (wkey,)
            sqlQuery = "select * from "+table+" where name = %s" #correct here
            
            cursor = connection.cursor()
            cursor.execute(sqlQuery, objdata)
            records = cursor.fetchone()
            self.data = records
                    
        except:
            retmsg = ["1", "Error"]
        else :
            retmsg = ["1", "Not Found"]
            if records[1] != "" :
                retmsg = ["0", "Found"]
        finally:
            if (connection.is_connected()):
                connection.close()
                cursor.close()
            return retmsg





