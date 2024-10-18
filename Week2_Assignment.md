Q: What is our user repeat rate?
    Repeat Rate = Users who purchased 2 or more times / users who purchased
    
A: Repeat rate is 80% (99 / 124)
        
    SELECT	COUNT(DISTINCT USER_ID) AS TOTAL_USERS,
		    COUNT(DISTINCT CASE WHEN ORDER_COUNT >= 2 THEN USER_ID END) AS REPEAT_USERS
    FROM (
            SELECT DISTINCT USER_ID,
                   COUNT(DISTINCT ORDER_ID) AS ORDER_COUNT 
            FROM DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_ORDERS O 
            GROUP BY 1
         )
