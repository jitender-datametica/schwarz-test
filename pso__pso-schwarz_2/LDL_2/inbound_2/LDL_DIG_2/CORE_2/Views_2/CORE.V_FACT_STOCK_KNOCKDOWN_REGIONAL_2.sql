CREATE OR REPLACE VIEW CORE.V_FACT_STOCK_KNOCKDOWN_REGIONAL_2(
	KNOCKDOWN_DT COMMENT 'Date at which the loss of value takes effect.',
	WSHOP_CD COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
	PROD_VARIANT_SID COMMENT 'Surrogate key for the Product Variant',
	PROD_VARIANT_NR COMMENT 'The product variant number',
	PROD_SID COMMENT 'The surrogate key for the main product',
	PROD_NR COMMENT 'The number for internal onlineshop product, which is country_2 independent',
	BUS_YEAR COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
	MONTH_OF_BUS_YEAR COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
	INTERNAL_COMPANY_SID COMMENT 'The unique identifier (surrogate key) for the company',
	INTERNAL_COMPANY_CD COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
	FIRST_INBOUND_DT COMMENT 'Earliest posting date in material movement document for each Product Variant.',
	STOCK_KNOCKDOWN_CATEGORY_CD COMMENT ' A code of the category of value knock-down (a.k.a  write-down or devaluation of asset). Categories are based on how long stock remained in the warehouse and how much items were sold.',
	TOTAL_STOCK_CNT COMMENT 'The total stock of the product variant -how many items of the product variant are stored in the warehouse',
	KNOCKDOWN_STOCK_CNT COMMENT 'How many of the stock items stored in the warehouse, lost part of their value',
	UNIT_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL COMMENT 'Base price per single unit_2 of the Product Variant - before the knockdown. Used to evaluate the stock (It is the smallest price assigned to a product variant (between GLD/IVP/EKP/VKP) at the knockdown_dt) ',
	TOTAL_STOCK_NET_EUR_VAL COMMENT 'Total value (before the knockdown process) of all items for this product variant that are  present in stock (independently if they are considered for knockdown or not)',
	TOTAL_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL COMMENT 'Total value of the items considered for knockdown in stock of the Product Variant (equals to KNOCKDOWN_STOCK_CNT *  UNIT_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL).              This amount will be written off from TOTAL_STOCK_NET_EUR_VAL to get the new value of all items in stock after the depreciation',
	TOTAL_STOCK_AFTER_KNOCKDOWN_NET_EUR_VAL COMMENT 'Total value of  all stock after the depreciation process (the knockdown). ',
	UNIT_STOCK_AFTER_KNOCKDOWN_NET_EUR_VAL COMMENT 'Price per single unit_2 of stock after the depreciation process (the knockdown). Calculated as TOTAL_STOCK_AFTER_KNOCKDOWN_NET_EUR_VAL / TOTAL_STOCK_CNT',
	NOT_BLOCKED_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL COMMENT 'Total value of all non-blocked items which are in stock and considered for knockdown.( value before the knockdown)',
	NOT_BLOCKED_UNIT_STOCK_AFTER_KNOCKDOWN_NET_EUR_VAL COMMENT 'Price per single unit_2 of not-blocked stock after the depreciation process (the knockdown). ',
	DIFF_PREV_TOTAL_STOCK_KNOCKDWON_EVAL_NET_EUR_VAL COMMENT 'Difference of the total value of the items considered for knockdown in stock of the Product Variant compared to the previous knockdown date',
	DIFF_PREV_NOT_BLOCKED_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL COMMENT 'Difference of the total value of all non-blocked items considered for knockdown of the Product Variant compared to the previous knockdown date'
) AS 
SELECT
    knockdown_dt
    , wshop_cd
    , prod_variant_sid 
    , prod_variant_nr
    , prod_sid 
    , prod_nr
    , bus_year
    , month_of_bus_year
    , internal_company_sid
    , internal_company_cd
    , first_inbound_dt
    , stock_knockdown_category_cd
    , total_stock_cnt 
    , knockdown_stock_cnt
    , unit_stock_knockdown_eval_net_eur_val
    , total_stock_net_eur_val
    , total_stock_knockdown_eval_net_eur_val
    , total_stock_after_knockdown_net_eur_val
    , unit_stock_after_knockdown_net_eur_val        
    , not_blocked_stock_knockdown_eval_net_eur_val
    , not_blocked_unit_stock_after_knockdown_net_eur_val
    , diff_prev_total_stock_knockdown_eval_net_eur_val
    , diff_prev_not_blocked_stock_knockdown_eval_net_eur_val
FROM
    (
SELECT
    fsk.knockdown_dt
    , swad.wshop_cd_mod AS wshop_cd
    , fsk.prod_variant_sid 
    , fsk.prod_variant_nr
    , fsk.prod_sid 
    , fsk.prod_nr
    , fsk.bus_year
    , fsk.month_of_bus_year
    , fsk.internal_company_sid
    , fsk.internal_company_cd
    , fsk.first_inbound_dt
    , fsk.stock_knockdown_category_cd
    , ROUND(fsk.total_stock_cnt * distribution_pct,0)                               AS total_stock_cnt 
    , ROUND(fsk.knockdown_stock_cnt * distribution_pct,0)                           AS knockdown_stock_cnt
    , fsk.unit_stock_knockdown_eval_net_eur_val                                     AS unit_stock_knockdown_eval_net_eur_val
    , ROUND(fsk.total_stock_net_eur_val * distribution_pct,5)                       AS total_stock_net_eur_val
    , ROUND(fsk.total_stock_knockdown_eval_net_eur_val * distribution_pct,5)        AS total_stock_knockdown_eval_net_eur_val
    , ROUND(fsk.total_stock_after_knockdown_net_eur_val * distribution_pct,5)       AS total_stock_after_knockdown_net_eur_val
    , fsk.unit_stock_after_knockdown_net_eur_val                                    AS unit_stock_after_knockdown_net_eur_val        
    , ROUND(fsk.not_blocked_stock_knockdown_eval_net_eur_val * distribution_pct,5)  AS not_blocked_stock_knockdown_eval_net_eur_val
    , fsk.not_blocked_unit_stock_after_knockdown_net_eur_val                        AS not_blocked_unit_stock_after_knockdown_net_eur_val
    , IFNULL(LAG(ROUND(fsk.total_stock_knockdown_eval_net_eur_val * distribution_pct,5)) OVER (PARTITION BY wshop_cd, prod_variant_sid ORDER BY wshop_cd, knockdown_dt),0) - ROUND(fsk.total_stock_knockdown_eval_net_eur_val * distribution_pct,5) AS diff_prev_total_stock_knockdown_eval_net_eur_val
    , IFNULL(LAG(ROUND(fsk.not_blocked_stock_knockdown_eval_net_eur_val * distribution_pct,5)) OVER (PARTITION BY wshop_cd, prod_variant_sid ORDER BY wshop_cd, knockdown_dt),0) - ROUND(fsk.not_blocked_stock_knockdown_eval_net_eur_val * distribution_pct,5) AS diff_prev_not_blocked_stock_knockdown_eval_net_eur_val
FROM
    core.t_fact_stock_knockdown_2 AS fsk
JOIN
    (
    SELECT 
        saed.prod_sid
        ,CASE WHEN ddc.wshop_cd = 'INT' THEN 'DE' ELSE ddc.wshop_cd END AS wshop_cd_mod --INT wshop is by default assigned to DE
        ,SUM(saed.distribution_pct) AS distribution_pct
        ,saed.cal_dt
    FROM
        core.t_fact_stock_allocation_entity_daily_2 AS saed
    JOIN 
        core.t_dim_warehouse_allocation_entity_2 AS wae
    ON 
        wae.wh_alloc_entity_cd = saed.wh_alloc_entity_cd
    JOIN
        core.t_dim_distribution_channel_2 AS ddc
    ON
        ddc.dist_channel_cd = wae.dist_channel_cd
    GROUP BY 
         wshop_cd_mod
        ,prod_sid
        ,cal_dt
    ) AS swad 
        ON      fsk.prod_sid = swad.prod_sid
            AND fsk.knockdown_dt = swad.cal_dt
    )
;