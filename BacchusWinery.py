import mysql.connector
from mysql.connector import errorcode

config = {
    "user" : "winery",
    "password" : "ILoveWine!",
    "host": "127.0.0.1",
    "database" : "BacchusWinery",
    "raise_on_warnings": True
}

def get_records(cursor, title,table):
        #getting records
        cursor.execute("""SELECT * FROM {}""".format(table))
        records = cursor.fetchall()

        print("\n  --  {}  --".format(title))
        return records
        

try:
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    #displaying results from products table
    records = get_records(cursor, "RECORDS IN PRODUCTS TABLE", 'products')
    #printing records
    for product in records:
        print("Product ID: {}\nProduct Name: {}\nQuantity in Stock: {}\n".format(product[0],product[1],product[2]))

    #displaying results from parts table 
    records = get_records(cursor, "RECORDS IN PARTS TABLE", 'parts')
    #printing records
    for part in records:
        print("Part ID: {}\nSupplier ID: {}\nPart Name: {}\nQuantity in Stock: {}\n".format(part[0],part[1],part[2],part[3]))

    #displaying results from suppliers table
    records = get_records(cursor, "RECORDS IN SUPPLIERS TABLE", 'suppliers')
    #printing records
    for supplier in records:
        print("Supplier ID: {}\nSupplier Name: {}\nSupplier Address Name: {}\nSupplier Phone: {}\nSupplier Email: {}\n".format(supplier[0],supplier[1],supplier[2],supplier[3],supplier[4]))
    
    #displaying results from distributors table
    records = get_records(cursor, "RECORDS IN DISTRIBUTORS TABLE", 'distributors')
    #printing records
    for distributor in records:
        print("Distributor ID: {}\nDistributor Name: {}\nDistributor Address Name: {}\nDistributor Phone: {}\nDistributor Email: {}\n".format(distributor[0],distributor[1],distributor[2],distributor[3],distributor[4]))
    
    #displaying results from supply_order table
    records = get_records(cursor, "RECORDS IN SUPPLY ORDER TABLE", 'supply_order')
    #printing records
    for order in records:
        print("Order ID: {}\nPart ID: {}\nOrder Date: {}\nExpected Date: {}\nDelivery Date: {}\nQuantity Ordered:  {}\n".format(order[0],order[1],order[2],order[3],order[4],order[5]))
    
    #displaying results from shipments table
    records = get_records(cursor, "RECORDS IN SHIPMENTS TABLE", 'shipments')
    #printing records
    for shipment in records:
        print("Shipment ID: {}\nProduct ID: {}\nDistributor ID: {}\nShipment Date: {}\nTracking Number: {}\nQuantity Sold: {}\n".format(shipment[0],shipment[1],shipment[2],shipment[3],shipment[4],shipment[5]))
    
    #displaying results from employees table
    records = get_records(cursor, "RECORDS IN EMPLOYEES TABLE", 'employees')
    #printing records
    for employee in records:
        print("Employee ID: {}\nManager ID: {}\nDepartment ID: {}\nFirst Name: {}\nLast Name: {}\nDate Hired: {}\nJob Title: {}\nEmployment Status: {}\n".format(employee[0],employee[1],employee[2],employee[3],employee[4],employee[5],employee[6],employee[7]))
    
    #displaying results from departments table
    records = get_records(cursor, "RECORDS IN DEPARTMENTS TABLE", 'departments')
    #printing records
    for department in records:
        print("Department ID: {}\nDepartment Name: {}\n".format(department[0],department[1]))
    
    #displaying results from hours worked table
    records = get_records(cursor, "RECORDS IN HOURS WORKED TABLE", 'hours_worked')
    #printing records
    for hours in records:
        print("Date: {}\nEmployee ID: {}\nHours Worked: {}\n".format(hours[0],hours[1],hours[2]))

              
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("     The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("     The specified database does not exist")

    else:
        print(err)

finally: 
    db.close()
    
