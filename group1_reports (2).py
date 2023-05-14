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

    #supplier delivery report
    cursor.execute("""
    SELECT s.supplier_name as 'Supplier', p.supply_name, so.expected_date as 'Expected Delivery', so.delivery_date 'Actual Delivery',
    DATEDIFF(so.delivery_date,so.expected_date) as Gap
    FROM suppliers s JOIN supplies p ON s.supplier_id = p.supplier_id
    JOIN supply_order so ON so.supply_id = p.supply_id
    """)

    report = cursor.fetchall()

    print("\n  --  SUPPLIER DELIVERY REPORT  --")
    for record in report:
         print("Supplier Name: {}\nSupply: {}\nExpected Delivery Date: {}\nActual Delivery Date: {}\nGap in Dates: {}\n".format(record[0],record[1],record[2],record[3],record[4]))

    #wine distribution report
    cursor.execute("""
    SELECT p.product_name, d.distributor_name, s.product_id, SUM(s.qty_sold)
    FROM products p JOIN shipments s on p.product_id = s.product_id
    JOIN distributors d on d.distributor_id = s.distributor_id
    GROUP BY p.product_name, d.distributor_name, s.product_id
    """)

    report = cursor.fetchall()

    print("\n  --  WINE DISTRIBUTOR REPORT  --")
    for record in report:
         print("Product Name: {}\nDistributor Name: {}\nQTY SOLD: {}\n".format(record[0],record[1],record[3]))

    #employee time report
    cursor.execute("""
    SELECT CONCAT(e.first_name, ' ' , e.last_name) as name, e.job_title, SUM(h.hours_worked)
    FROM employees e JOIN timekeeping h on e.employee_id = h.employee_id
    WHERE (h.date BETWEEN'2023-01-01' AND '2023-03-31')
    GROUP BY e.first_name, e.last_name, e.job_title
    """)

    report = cursor.fetchall()

    print("\n  --  EMPLOYEE TIME REPORT IN LAST QUARTER --")
    for record in report:
         print("Employee Name: {}\nJob Title: {}\nHours Worked {}\n".format(record[0],record[1],record[2]))


except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("     The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("     The specified database does not exist")

    else:
        print(err)

finally: 
    db.close()
    
