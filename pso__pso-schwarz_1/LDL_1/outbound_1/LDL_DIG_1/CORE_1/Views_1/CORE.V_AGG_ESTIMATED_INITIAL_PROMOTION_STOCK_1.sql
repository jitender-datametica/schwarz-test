/*
Change History
08.05.2023    ABA    Replaced core.v_agg_stock_warehouse_daily by core.t_fact_stock_warehouse_daily_1
19.09.2024    NAZ    Fixed STOCK_DISTRIBUTION_PCT by replacing PROMO.PROMO_START_DT, VAR.PROD_SID, PROMO.WSHOP_CD by PROMO_ID
*/


CREATE OR REPLACE VIEW ldl_dig_core.v_agg_estimated_initial_promotion_stock_1 AS WITH PROD_STOCK AS (SELECT VAR0.prod_variant_sid
   ,
   VAR0.prod_sid,
   AGG.cal_dt,
   SUM(AGG.total_stock_cnt) AS total_stock
  FROM ldl_dig_core.t_fact_stock_warehouse_daily_1 AS AGG
   INNER JOIN ldl_dig_core.t_dim_product_variant_1 AS VAR0 ON AGG.prod_variant_sid = VAR0.prod_variant_sid AND VAR0.dwh_valid_fg
    
  WHERE AGG.active_fg
  GROUP BY AGG.cal_dt,
   VAR0.prod_variant_sid,
   VAR0.prod_sid), VARIANT_STOCK AS (SELECT PROD.prod_variant_sid,
   DIS_CHANNEL.wshop_cd,
   PROD.cal_dt,
   PROD.total_stock,
    PROD.total_stock * STOCK.distribution_pct AS variant_stock_country
  FROM ldl_dig_core.t_fact_stock_allocation_entity_daily_1 AS STOCK
   INNER JOIN ldl_dig_core.t_dim_warehouse_allocation_entity_1 AS ENT_ALLOC ON STOCK.wh_alloc_entity_cd = ENT_ALLOC.wh_alloc_entity_cd
    
   INNER JOIN ldl_dig_core.t_dim_distribution_channel_1 AS DIS_CHANNEL ON ENT_ALLOC.dist_channel_cd = DIS_CHANNEL.dist_channel_cd
    
   INNER JOIN PROD_STOCK AS PROD ON STOCK.prod_sid = PROD.prod_sid AND STOCK.cal_dt = PROD.cal_dt
  WHERE STOCK.active_fg), ORDERS AS (SELECT prod_variant_sid,
   wshop_cd,
   promo_sale_start_dt,
   promo_id,
   SUM(prod_qty) AS orders,
   SUM(return_prod_qty) AS return_orders
  FROM ldl_dig_core.t_agg_promotion_sales_daily_1
  GROUP BY wshop_cd,
   promo_id,
   prod_variant_sid,
   promo_sale_start_dt), ESTIMATED_STOCK AS (SELECT PROMO.wshop_cd,
   PROMO.prod_sid,
   PROMO.promo_start_dt,
   PROMO.promo_sale_start_dt,
   PROMO.promo_id,
   VAR.prod_variant_sid,
     IFNULL(CAST(ROUND(STOCK.variant_stock_country, 0) AS INTEGER), 0) + IFNULL(t8.orders, 0) - IFNULL(t8.return_orders
     , 0) AS estimated_init_promo_stock,
   ROUND(IF((SUM(IFNULL(STOCK.variant_stock_country, 0) + IFNULL(t8.orders, 0) - IFNULL(t8.return_orders, 0)) OVER (PARTITION BY CAST(PROMO.promo_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(IFNULL(STOCK.variant_stock_country
         , 0) + IFNULL(t8.orders, 0) - IFNULL(t8.return_orders, 0), SUM(IFNULL(STOCK.variant_stock_country, 0) + IFNULL(t8
          .orders, 0) - IFNULL(t8.return_orders, 0)) OVER (PARTITION BY CAST(PROMO.promo_id AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))), 9) AS stock_distribution_pct
  FROM ldl_dig_core.t_dim_sales_promotion_1 AS PROMO
   LEFT JOIN ldl_dig_core.t_dim_product_variant_1 AS VAR ON PROMO.prod_sid = VAR.prod_sid AND VAR.dwh_valid_fg
   LEFT JOIN VARIANT_STOCK AS STOCK ON VAR.prod_variant_sid = STOCK.prod_variant_sid AND PROMO.wshop_cd = STOCK.wshop_cd
     
   LEFT JOIN ORDERS AS t8 ON VAR.prod_variant_sid = t8.prod_variant_sid AND PROMO.wshop_cd = t8.wshop_cd AND PROMO.promo_sale_start_dt
       = t8.promo_sale_start_dt AND PROMO.promo_id = t8.promo_id
  WHERE PROMO.dwh_valid_fg
   AND PROMO.sale_promo_status_cd = 'ACTIVE'), WITHOUT_STOCK AS (SELECT prod_sid,
   promo_id,
   COUNT(DISTINCT prod_variant_sid) AS cnt,
   SUM(estimated_init_promo_stock) AS stock
  FROM ESTIMATED_STOCK
  GROUP BY prod_sid,
   promo_id
  HAVING stock = 0) (SELECT EST.wshop_cd,
   EST.prod_sid,
   EST.promo_start_dt,
   EST.promo_sale_start_dt,
   EST.promo_id,
   EST.prod_variant_sid,
   EST.estimated_init_promo_stock,
    CASE
    WHEN EST.estimated_init_promo_stock > 0
    THEN EST.stock_distribution_pct
    WHEN EST.estimated_init_promo_stock = 0 AND EST.promo_id IN (SELECT promo_id
       FROM (SELECT prod_sid,
          promo_id,
          COUNT(DISTINCT prod_variant_sid) AS cnt,
          SUM(estimated_init_promo_stock) AS stock
         FROM ESTIMATED_STOCK
         GROUP BY prod_sid,
          promo_id
         HAVING stock = 0) AS t43)
    THEN IF(t28.cnt = 0, 0, SAFE_DIVIDE(1, t28.cnt))
    ELSE 0
    END AS stock_distribution_pct
  FROM ESTIMATED_STOCK AS EST
   LEFT JOIN WITHOUT_STOCK AS t28 ON EST.promo_id = t28.promo_id AND EST.prod_sid = t28.prod_sid);