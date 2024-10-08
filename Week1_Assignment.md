Q: How many users do we have?  
A: 130 Users

    SELECT COUNT(DISTINCT USER_ID)
    FROM DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_USERS

Q: On average, how many orders do we receive per hour?  
A: 7-8 orders per hour (real answer was 7.5)

    SELECT AVG(HOURLY_ORDERS)
    FROM (
	      SELECT	DATE_TRUNC('HOUR', CREATED_AT), 
				    COUNT(DISTINCT ORDER_ID) AS HOURLY_ORDERS
	      FROM DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_ORDERS
	      GROUP BY 1
	      ORDER BY 1
		)

Q: On average, how long does an order take from being placed to being delivered?  
A: 93 hours or approximately 4 days. 

    SELECT 	AVG(TIME_TO_DELIVERY) as TIME_TO_DELIVERY_HRS, 
		    AVG(TIME_TO_DELIVERY)/24 as TIME_TO_DELIVERY_DAYS
    FROM (
    SELECT 	ORDER_ID, 
		    CREATED_AT, 
		    DELIVERED_AT, 
		    DATEDIFF('HOURS', CREATED_AT, DELIVERED_AT) AS TIME_TO_DELIVERY
    FROM DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_ORDERS
    WHERE STATUS = 'delivered'
    )

 Q: How many users have only made one purchase? Two purchases? Three+ purchases?  
 A: 1 Order = 25 Users, 2 Orders = 28 Users, 3+ Orders = 71 Users. 

    SELECT 	CASE   WHEN NUM_ORDERS >= 3 THEN '3+'
				   ELSE TO_VARCHAR(NUM_ORDERS) 
				   END AS NUM_ORDERS,
		    COUNT(DISTINCT USER_ID) AS USER_COUNT
    FROM (
		    SELECT  DISTINCT U.USER_ID,
				    COUNT(DISTINCT O.ORDER_ID) AS NUM_ORDERS
		    FROM DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_USERS U
		    INNER JOIN DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_ORDERS O ON U.USER_ID = O.USER_ID
		    GROUP BY 1
	    )
    GROUP BY 1
    ORDER BY 1

  
Q: On average, how many unique sessions do we have per hour?  
 A: 16 sessions

    SELECT AVG(HOURLY_SESSIONS)
    FROM (
	    SELECT 	DATE_TRUNC('HOUR', CREATED_AT), 
			    COUNT(DISTINCT SESSION_ID) AS HOURLY_SESSIONS
	    FROM DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_EVENTS
	    GROUP BY 1
	    ORDER BY 1
	    )

