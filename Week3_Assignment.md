## Part 1. Create new models to answer the first two questions

**Q: What is our overall conversion rate?**
  A: 62%
  
    select  count(distinct session_id) as total_sessions,
	        count(distinct case when checkouts = 1 then session_id end) as sessions_with_purchase,
	        sessions_with_purchase / total_sessions as conversion_rate
	from DEV_DB.DBT_INAHPATRIZIAGMAILCOM.FACT_PAGE_VIEWS

**Q: What is our conversion rate by product?**

|  Product ID	|Name  | Page Views | Checkouts | Conversion Rate|
|--|--|--|--|--|
|fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80|String of pearls|64|39|0.609375|
|74aeb414-e3dd-4e8a-beef-0fa45225214d|Arrow Head|63|35|0.555556|
|c17e63f7-0d28-4a95-8248-b01ea354840e|Cactus|55|30|0.545455|
|b66a7143-c18a-43bb-b5dc-06bb5d1d3160|ZZ Plant|63|34|0.539683|
|689fb64e-a4a2-45c5-b9f2-480c2155624d|Bamboo|67|36|0.537313|
|579f4cd0-1f45-49d2-af55-9ab2b72c3b35|Rubber Plant|54|28|0.518519|
|be49171b-9f72-4fc9-bf7a-9a52e259836b|Monstera|49|25|0.510204|
|b86ae24b-6f59-47e8-8adc-b17d88cbd367|Calathea Makoyana|53|27|0.509434|
|e706ab70-b396-4d30-a6b2-a1ccf3625b52|Fiddle Leaf Fig|56|28|0.5|
|5ceddd13-cf00-481f-9285-8340ab95d06d|Majesty Palm|67|33|0.492537|
|615695d3-8ffd-4850-bcf7-944cf6d3685b|Aloe Vera|65|32|0.492308|
|35550082-a52d-4301-8f06-05b30f6f3616|Devil's Ivy|45|22|0.488889|
|55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3|Philodendron|62|30|0.483871|
|a88a23ef-679c-4743-b151-dc7722040d8c|Jade Plant|46|22|0.478261|
|5b50b820-1d0a-4231-9422-75e7f6b0cecf|Pilea Peperomioides|59|28|0.474576|
|64d39754-03e4-4fa0-b1ea-5f4293315f67|Spider Plant|59|28|0.474576|
|37e0062f-bd15-4c3e-b272-558a86d90598|Dragon Tree|62|29|0.467742|
|d3e228db-8ca5-42ad-bb0a-2148e876cc59|Money Tree|56|26|0.464286|
|c7050c3b-a898-424d-8d98-ab0aaad7bef4|Orchid|75|34|0.453333|
|05df0866-1a66-41d8-9ed7-e2bbcddd6a3d|Bird of Paradise|60|27|0.45|
|843b6553-dc6a-4fc4-bceb-02cd39af0168|Ficus|68|29|0.426471|
|bb19d194-e1bd-4358-819e-cd1f1b401c0c|Birds Nest Fern|78|33|0.423077|
|80eda933-749d-4fc6-91d5-613d29eb126f|Pink Anthurium|74|31|0.418919|
|e2e78dfc-f25c-4fec-a002-8e280d61a2f2|Boston Fern|63|26|0.412698|
|6f3a3072-a24d-4d11-9cef-25b0b5f8a4af|Alocasia Polly|51|21|0.411765|
|e5ee99b6-519f-4218-8b41-62f48f59f700|Peace Lily|66|27|0.409091|
|e18f33a6-b89a-4fbc-82ad-ccba5bb261cc|Ponytail Palm|70|28|0.4|
|e8b6528e-a830-4d03-a027-473b411c7f02|Snake Plant|73|29|0.39726|
|58b575f2-2192-4a53-9d21-df9a0c14fc25|Angel Wings Begonia|61|24|0.393443|
|4cda01b9-62e2-46c5-830f-b7f262a58fb1|Pothos|61|21|0.344262|



    with product_page_view as (
        select  product_id, 
                count(distinct case when e.event_type = 'page_view' then e.session_id end) as page_views
        from DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_EVENTS e
        group by 1
    ),
    
    product_checkouts as (
    
	    select  oi.product_id, 
	            count(distinct session_id) as checkout
	    from DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_EVENTS e
	    inner join DEV_DB.DBT_INAHPATRIZIAGMAILCOM.STG_ORDER_ITEMS oi on e.order_id = oi.order_id
	    where event_type = 'checkout'
	    group by 1
    )
    
    select  p.product_id,
            name,
            page_views,
            checkout,
            checkout / page_views as conversion_rate
    from DEV_DB.DBT_INAHPATRIZIAGMAILCOM.dim_product p
    left join product_page_view ppv on p.product_id = ppv.product_id
    left join product_checkouts pc on p.product_id = pc.product_id
    order by 5 desc
