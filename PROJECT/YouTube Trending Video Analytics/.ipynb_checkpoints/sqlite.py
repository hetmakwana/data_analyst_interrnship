import sqlite3

conn = sqlite3.connect('youtube.db')
df_us.to_sql('us_data', conn, if_exists='replace', index=False)

query = """
SELECT category_id, AVG(views) as avg_views
FROM us_data
GROUP BY category_id
ORDER BY avg_views DESC;
"""

ranked = pd.read_sql(query, conn)