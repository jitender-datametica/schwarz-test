CREATE OR REPLACE VIEW ldl_dig_core.v_fact_stock_knockdown_regional_2 (knockdown_dt
OPTIONS(description='Date at which the loss of value takes effect.'), wshop_cd
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2'),
prod_variant_sid OPTIONS(description='Surrogate key for the Product Variant'), prod_variant_nr
OPTIONS(description='The product variant number'), prod_sid
OPTIONS(description='The surrogate key for the main product'), prod_nr
OPTIONS(description='The number for internal onlineshop product, which is country_2 independent'), bus_year
OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'), month_of_bus_year
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
internal_company_sid OPTIONS(description='The unique identifier (surrogate key) for the company'), internal_company_cd
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
first_inbound_dt OPTIONS(description='Earliest posting date in material movement document for each Product Variant.'),
stock_knockdown_category_cd
OPTIONS(description=' A code of the category of value knock-down (a.k.a  write-down or devaluation of asset). Categories are based on how long stock remained in the warehouse and how much items were sold.'),
total_stock_cnt
OPTIONS(description='The total stock of the product variant -how many items of the product variant are stored in the warehouse'),
knockdown_stock_cnt OPTIONS(description='How many of the stock items stored in the warehouse, lost part of their value'),
unit_stock_knockdown_eval_net_eur_val
OPTIONS(description='Base price per single unit_2 of the Product Variant - before the knockdown. Used to evaluate the stock (It is the smallest price assigned to a product variant (between GLD/IVP/EKP/VKP) at the knockdown_dt) '),
total_stock_net_eur_val
OPTIONS(description='Total value (before the knockdown process) of all items for this product variant that are  present in stock (independently if they are considered for knockdown or not)'),
total_stock_knockdown_eval_net_eur_val
OPTIONS(description='Total value of the items considered for knockdown in stock of the Product Variant (equals to KNOCKDOWN_STOCK_CNT *  UNIT_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL).              This amount will be written off from TOTAL_STOCK_NET_EUR_VAL to get the new value of all items in stock after the depreciation'),
total_stock_after_knockdown_net_eur_val
OPTIONS(description='Total value of  all stock after the depreciation process (the knockdown). '),
unit_stock_after_knockdown_net_eur_val
OPTIONS(description='Price per single unit_2 of stock after the depreciation process (the knockdown). Calculated as TOTAL_STOCK_AFTER_KNOCKDOWN_NET_EUR_VAL / TOTAL_STOCK_CNT'),
not_blocked_stock_knockdown_eval_net_eur_val
OPTIONS(description='Total value of all non-blocked items which are in stock and considered for knockdown.( value before the knockdown)'),
not_blocked_unit_stock_after_knockdown_net_eur_val
OPTIONS(description='Price per single unit_2 of not-blocked stock after the depreciation process (the knockdown). '),
diff_prev_total_stock_knockdwon_eval_net_eur_val
OPTIONS(description='Difference of the total value of the items considered for knockdown in stock of the Product Variant compared to the previous knockdown date'),
diff_prev_not_blocked_stock_knockdown_eval_net_eur_val
OPTIONS(description='Difference of the total value of all non-blocked items considered for knockdown of the Product Variant compared to the previous knockdown date'))
AS SELECT FSK.knockdown_dt,
 swad.wshop_cd_mod AS wshop_cd,
 FSK.prod_variant_sid,
 FSK.prod_variant_nr,
 FSK.prod_sid,
 FSK.prod_nr,
 FSK.bus_year,
 FSK.month_of_bus_year,
 FSK.internal_company_sid,
 FSK.internal_company_cd,
 FSK.first_inbound_dt,
 FSK.stock_knockdown_category_cd,
 CAST(ROUND(FSK.total_stock_cnt * swad.distribution_pct, 0) AS INTEGER) AS total_stock_cnt,
 CAST(ROUND(FSK.knockdown_stock_cnt * swad.distribution_pct, 0) AS INTEGER) AS knockdown_stock_cnt,
 FSK.unit_stock_knockdown_eval_net_eur_val,
 ROUND(FSK.total_stock_net_eur_val * swad.distribution_pct, 5) AS total_stock_net_eur_val,
 ROUND(FSK.total_stock_knockdown_eval_net_eur_val * swad.distribution_pct, 5) AS total_stock_knockdown_eval_net_eur_val
 ,
 ROUND(FSK.total_stock_after_knockdown_net_eur_val * swad.distribution_pct, 5) AS
 total_stock_after_knockdown_net_eur_val,
 FSK.unit_stock_after_knockdown_net_eur_val,
 ROUND(FSK.not_blocked_stock_knockdown_eval_net_eur_val * swad.distribution_pct, 5) AS
 not_blocked_stock_knockdown_eval_net_eur_val,
 FSK.not_blocked_unit_stock_after_knockdown_net_eur_val,
  IFNULL(LAG(ROUND(FSK.total_stock_knockdown_eval_net_eur_val * swad.distribution_pct, 5)) OVER (PARTITION BY swad.wshop_cd_mod
      , CAST(FSK.prod_variant_sid AS STRING) ORDER BY swad.wshop_cd_mod IS NULL, swad.wshop_cd_mod, FSK.knockdown_dt
      IS NULL, FSK.knockdown_dt), 0) - ROUND(FSK.total_stock_knockdown_eval_net_eur_val * swad.distribution_pct, 5) AS
 diff_prev_total_stock_knockdwon_eval_net_eur_val,
  IFNULL(LAG(ROUND(FSK.not_blocked_stock_knockdown_eval_net_eur_val * swad.distribution_pct, 5)) OVER (PARTITION BY swad
      .wshop_cd_mod, CAST(FSK.prod_variant_sid AS STRING) ORDER BY swad.wshop_cd_mod IS NULL, swad.wshop_cd_mod, FSK.knockdown_dt
      IS NULL, FSK.knockdown_dt), 0) - ROUND(FSK.not_blocked_stock_knockdown_eval_net_eur_val * swad.distribution_pct, 5
   ) AS diff_prev_not_blocked_stock_knockdown_eval_net_eur_val
FROM ldl_dig_core.t_fact_stock_knockdown_2 AS FSK
 INNER JOIN (SELECT SAED.prod_sid,
    CASE
    WHEN DDC.wshop_cd = 'INT'
    THEN 'DE'
    ELSE DDC.wshop_cd
    END AS wshop_cd_mod,
   SUM(SAED.distribution_pct) AS distribution_pct,
   SAED.cal_dt
  FROM ldl_dig_core.t_fact_stock_allocation_entity_daily_2 AS SAED
   INNER JOIN ldl_dig_core.t_dim_warehouse_allocation_entity_2 AS WAE ON SAED.wh_alloc_entity_cd = WAE.wh_alloc_entity_cd
   INNER JOIN ldl_dig_core.t_dim_distribution_channel_2 AS DDC ON WAE.dist_channel_cd = DDC.dist_channel_cd
  GROUP BY wshop_cd_mod,
   SAED.prod_sid,
   SAED.cal_dt) AS swad ON FSK.prod_sid = swad.prod_sid AND FSK.knockdown_dt = swad.cal_dt;