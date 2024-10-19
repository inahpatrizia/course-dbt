## Part 1. Models

**Q: What is our user repeat rate?**
    Repeat Rate = Users who purchased 2 or more times / users who purchased
    
A: Repeat rate is 80% (99 / 124)
        
    SELECT  COUNT(CASE WHEN IS_FREQUENT_BUYER = TRUE THEN USER_ID END),
            COUNT (DISTINCT USER_ID),
            COUNT(CASE WHEN IS_FREQUENT_BUYER = TRUE THEN USER_ID END) / COUNT (DISTINCT USER_ID)
    FROM DEV_DB.DBT_INAHPATRIZIAGMAILCOM.FACT_USER_ORDERS
    WHERE IS_BUYER = TRUE
    
    
**Q: What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?**

Some good indicators of a user who will likely purchase again are:
 - Order frequency
 - Avg. order amount 

Some good indicators of a user who will likely NOT purchase again are:
 - Cart abandonment
 - Single transactions with large discount 

**Q: Explain the product mart models you added. Why did you organize the models in the way you did?**

I added `dim_users` and `dim_products` so that analysts have dimension tables that have data at the user or the product level. I've used similar dimension tables when I had to report on product hierarchy or user segments. In `dim_users` , I removed any PII like first name, last name, phone number, address etc. 

## Part 2. Tests

**Q: Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.**

A: I'd automate a report that shows which tests fail when the data is refreshed at whatever cadence was set (usually before the start of the business hours). If the it's an easy fix, I'll deploy a change but if it requires more investigations, I'd communicate what the issue is and focus on the impact to the stakeholder. I would commit to an update timeline until the issue is resolved.

## Part 3. dbt Snapshots

Unforunately I didn't run my snapshot code last week properly so I only have a Week 2 snapshot. I won't be able to identify which products had their inventory change from week 1 to week 2.

