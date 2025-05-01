import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

# Connect to SQLite DB
conn = sqlite3.connect('sales_data.db')
cursor = conn.cursor()

# Create table
cursor.execute('''
CREATE TABLE IF NOT EXISTS sales (
    id INTEGER PRIMARY KEY,
    product TEXT,
    quantity INTEGER,
    price REAL
)
''')

# Insert sample records
sales_data = [
    ('Laptop', 2, 800),
    ('Laptop', 1, 800),
    ('Mouse', 5, 20),
    ('Keyboard', 3, 50),
    ('Mouse', 2, 20),
    ('Monitor', 1, 150),
    ('Keyboard', 2, 50)
]
cursor.executemany('INSERT INTO sales (product, quantity, price) VALUES (?, ?, ?)', sales_data)
conn.commit()

# Query the summary
query = '''
SELECT product, SUM(quantity) AS total_qty, SUM(quantity * price) AS revenue
FROM sales
GROUP BY product
'''
df = pd.read_sql_query(query, conn)
conn.close()

# Print result
print("Sales Summary")
print(df)

# Plot
df.plot(kind='bar', x='product', y='revenue', legend=False)
plt.title('Revenue by Product')
plt.ylabel('Revenue ($)')
plt.xlabel('Product')
plt.tight_layout()
plt.savefig('sales_chart.png')
plt.show()

