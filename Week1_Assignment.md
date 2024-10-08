Q: How many users do we have?  
A: 130 Users

    SELECT COUNT(DISTINCT USER_ID)
    FROM DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_USERS

Q: On average, how many orders do we receive per hour?  
A: 7-8 orders per hour (real answer was 7.5)

    SELECT AVG(HOURLY_ORDERS)
    FROM (
	      SELECT DATE_TRUNC('HOUR', CREATED_AT), COUNT(DISTINCT ORDER_ID) AS HOURLY_ORDERS
	      FROM DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_ORDERS
	      GROUP BY 1
	      ORDER BY 1
		)