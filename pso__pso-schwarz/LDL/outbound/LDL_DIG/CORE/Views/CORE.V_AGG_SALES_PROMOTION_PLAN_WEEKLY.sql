CREATE OR REPLACE VIEW ldl_dig_core.v_agg_sales_promotion_plan_weekly (wshop_cd
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
prod_sid OPTIONS(description='The unique identifier (surrogate key) for the product'), promo_id
OPTIONS(description='An identifier from source system to uniqly identify the promotion'), promo_dur_week_cnt
OPTIONS(description='How long was the promotion planned to be active (number of weeks)'), promo_start_dt
OPTIONS(description='Start date of the product promotion in stationary business'), promo_sale_start_dt
OPTIONS(description='Date when sales of promotional goods starts'), supplier_order_qty
OPTIONS(description='Number of products ordered from suppliers. If it is zero, it means that nothing was ordered because there is still stock available from another promotion'),
tgt_prod_sale_qty
OPTIONS(description='Number of products expected to be sold. Product quantities in stock units (no decimal values)'),
estimated_init_promo_stock OPTIONS(description='Estimated initial promotional stock'), current_promo_week_nr
OPTIONS(description='Current week number since the promotion sale start date'), week_nr
OPTIONS(description='For each promotion week, and depending on the promotion duration, there is a planned percentage of units to be sold'),
promo_sale_cluster_cd
OPTIONS(description='A code for aggregation of sales orders assigned to a promotion based on the customer order date'),
tgt_sale_pct OPTIONS(description='Planned percentage of units sold for each promotion week'), cum_tgt_sale_pct
OPTIONS(description='Cumulative planned percentage of units sold for each promotion week'), sale_promo_phase_cd
OPTIONS(description='The phase can be either A (Aktion) which corresponds to the first three week of a promotion, or N (Nachlauf) if it is refering to the remaining weeks - after-promotion phase'),
plan_amc_qty OPTIONS(description='Planned quantity of units solds for each promotion week'), plan_amc_perc
OPTIONS(description='Planned percentage of units sold for each promotion week'), plan_amc_qty_cum
OPTIONS(description='Cumulative Planned quantity of units solds for each promotion week'), plan_amc_cum_perc
OPTIONS(description='Cumulative planned percentage of units sold for each promotion week'), plan_ab_qty
OPTIONS(description='Planned quantity of units solds for each promotion week based on estimated initial promotional stock'),
plan_ab_perc
OPTIONS(description='Planned percentage of units sold for each promotion week based on estimated initial promotional stock'),
plan_ab_qty_cum
OPTIONS(description='Cumulative Planned quantity of units solds for each promotion week based on estimated initial promotional stock'),
plan_ab_cum_perc
OPTIONS(description='Cumulative planned percentage of units sold for each promotion week based on estimated initial promotional stock'),
is_current_fg OPTIONS(description='Flag that indicates the current_week of the promotion'))
OPTIONS(DESCRIPTION = `CALCULATION OF PLAN VALUES FOR EACH PROMOTION FOR EACH WEEK OF THE PROMOTION`) AS WITH
 INIT_PROMO_STOCK AS (SELECT prod_sid,
   promo_id,
   SUM(estimated_init_promo_stock) AS estimated_init_promo_stock
  FROM ldl_dig_core.v_agg_estimated_initial_promotion_stock
  GROUP BY prod_sid,
   promo_id) (SELECT PROMO.wshop_cd,
   PROMO.prod_sid,
   PROMO.promo_id,
   PROMO.promo_dur_week_cnt,
   PROMO.promo_start_dt,
   PROMO.promo_sale_start_dt,
   PROMO.supplier_order_qty,
   PROMO.tgt_prod_sale_qty,
   STOCK.estimated_init_promo_stock,
   CEIL(DATE_DIFF(DATE(CURRENT_TIMESTAMP()), PROMO.promo_sale_start_dt, DAY) / 7) AS current_promo_week_nr,
   TGT.week_nr,
   REL.promo_sale_cluster_cd,
   TGT.tgt_sale_pct,
   TGT.cum_tgt_sale_pct,
   TGT.sale_promo_phase_cd,
    CASE
    WHEN TGT.sale_promo_phase_cd = 'A'
    THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.tgt_sale_pct, 0) AS INTEGER)
    WHEN PROMO.supplier_order_qty > PROMO.tgt_prod_sale_qty
    THEN CAST(ROUND((PROMO.supplier_order_qty - PROMO.tgt_prod_sale_qty) * TGT.tgt_sale_pct, 0) AS INTEGER)
    ELSE 0
    END AS plan_amc_qty,
    CASE
    WHEN PROMO.supplier_order_qty > PROMO.tgt_prod_sale_qty
    THEN ROUND(IF(PROMO.supplier_order_qty = 0, 0, SAFE_DIVIDE(CASE
        WHEN TGT.sale_promo_phase_cd = 'A'
        THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.tgt_sale_pct, 0) AS INTEGER)
        WHEN PROMO.supplier_order_qty > PROMO.tgt_prod_sale_qty
        THEN CAST(ROUND((PROMO.supplier_order_qty - PROMO.tgt_prod_sale_qty) * TGT.tgt_sale_pct, 0) AS INTEGER)
        ELSE 0
        END, PROMO.supplier_order_qty)), 2)
    ELSE ROUND(IF(PROMO.tgt_prod_sale_qty = 0, 0, SAFE_DIVIDE(CASE
        WHEN TGT.sale_promo_phase_cd = 'A'
        THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.tgt_sale_pct, 0) AS INTEGER)
        WHEN PROMO.supplier_order_qty > PROMO.tgt_prod_sale_qty
        THEN CAST(ROUND((PROMO.supplier_order_qty - PROMO.tgt_prod_sale_qty) * TGT.tgt_sale_pct, 0) AS INTEGER)
        ELSE 0
        END, PROMO.tgt_prod_sale_qty)), 2)
    END AS plan_amc_perc,
    CASE
    WHEN TGT.sale_promo_phase_cd = 'A'
    THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.cum_tgt_sale_pct, 0) AS INTEGER)
    WHEN PROMO.supplier_order_qty > PROMO.tgt_prod_sale_qty
    THEN CAST(ROUND((PROMO.supplier_order_qty - PROMO.tgt_prod_sale_qty) * TGT.cum_tgt_sale_pct + PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
    ELSE CAST(ROUND(PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
    END AS plan_amc_qty_cum,
    CASE
    WHEN PROMO.supplier_order_qty > PROMO.tgt_prod_sale_qty
    THEN ROUND(IF(PROMO.supplier_order_qty = 0, 0, SAFE_DIVIDE(CASE
        WHEN TGT.sale_promo_phase_cd = 'A'
        THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.cum_tgt_sale_pct, 0) AS INTEGER)
        WHEN PROMO.supplier_order_qty > PROMO.tgt_prod_sale_qty
        THEN CAST(ROUND((PROMO.supplier_order_qty - PROMO.tgt_prod_sale_qty) * TGT.cum_tgt_sale_pct + PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
        ELSE CAST(ROUND(PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
        END, PROMO.supplier_order_qty)), 2)
    ELSE ROUND(IF(PROMO.tgt_prod_sale_qty = 0, 0, SAFE_DIVIDE(CASE
        WHEN TGT.sale_promo_phase_cd = 'A'
        THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.cum_tgt_sale_pct, 0) AS INTEGER)
        WHEN PROMO.supplier_order_qty > PROMO.tgt_prod_sale_qty
        THEN CAST(ROUND((PROMO.supplier_order_qty - PROMO.tgt_prod_sale_qty) * TGT.cum_tgt_sale_pct + PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
        ELSE CAST(ROUND(PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
        END, PROMO.tgt_prod_sale_qty)), 2)
    END AS plan_amc_cum_perc,
    CASE
    WHEN TGT.sale_promo_phase_cd = 'A'
    THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.tgt_sale_pct, 0) AS INTEGER)
    WHEN STOCK.estimated_init_promo_stock > PROMO.tgt_prod_sale_qty
    THEN CAST(ROUND((STOCK.estimated_init_promo_stock - PROMO.tgt_prod_sale_qty) * TGT.tgt_sale_pct, 0) AS INTEGER)
    ELSE 0
    END AS plan_ab_qty,
    CASE
    WHEN STOCK.estimated_init_promo_stock > PROMO.tgt_prod_sale_qty
    THEN ROUND(IF(STOCK.estimated_init_promo_stock = 0, 0, SAFE_DIVIDE(CASE
        WHEN TGT.sale_promo_phase_cd = 'A'
        THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.tgt_sale_pct, 0) AS INTEGER)
        WHEN STOCK.estimated_init_promo_stock > PROMO.tgt_prod_sale_qty
        THEN CAST(ROUND((STOCK.estimated_init_promo_stock - PROMO.tgt_prod_sale_qty) * TGT.tgt_sale_pct, 0) AS INTEGER)
        ELSE 0
        END, STOCK.estimated_init_promo_stock)), 2)
    ELSE ROUND(IF(PROMO.tgt_prod_sale_qty = 0, 0, SAFE_DIVIDE(CASE
        WHEN TGT.sale_promo_phase_cd = 'A'
        THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.tgt_sale_pct, 0) AS INTEGER)
        WHEN STOCK.estimated_init_promo_stock > PROMO.tgt_prod_sale_qty
        THEN CAST(ROUND((STOCK.estimated_init_promo_stock - PROMO.tgt_prod_sale_qty) * TGT.tgt_sale_pct, 0) AS INTEGER)
        ELSE 0
        END, PROMO.tgt_prod_sale_qty)), 2)
    END AS plan_ab_perc,
    CASE
    WHEN TGT.sale_promo_phase_cd = 'A'
    THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.cum_tgt_sale_pct, 0) AS INTEGER)
    WHEN STOCK.estimated_init_promo_stock > PROMO.tgt_prod_sale_qty
    THEN CAST(ROUND((STOCK.estimated_init_promo_stock - PROMO.tgt_prod_sale_qty) * TGT.cum_tgt_sale_pct + PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
    ELSE CAST(ROUND(PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
    END AS plan_ab_qty_cum,
    CASE
    WHEN STOCK.estimated_init_promo_stock > PROMO.tgt_prod_sale_qty
    THEN ROUND(IF(STOCK.estimated_init_promo_stock = 0, 0, SAFE_DIVIDE(CASE
        WHEN TGT.sale_promo_phase_cd = 'A'
        THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.cum_tgt_sale_pct, 0) AS INTEGER)
        WHEN STOCK.estimated_init_promo_stock > PROMO.tgt_prod_sale_qty
        THEN CAST(ROUND((STOCK.estimated_init_promo_stock - PROMO.tgt_prod_sale_qty) * TGT.cum_tgt_sale_pct + PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
        ELSE CAST(ROUND(PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
        END, STOCK.estimated_init_promo_stock)), 2)
    ELSE ROUND(IF(PROMO.tgt_prod_sale_qty = 0, 0, SAFE_DIVIDE(CASE
        WHEN TGT.sale_promo_phase_cd = 'A'
        THEN CAST(ROUND(PROMO.tgt_prod_sale_qty * TGT.cum_tgt_sale_pct, 0) AS INTEGER)
        WHEN STOCK.estimated_init_promo_stock > PROMO.tgt_prod_sale_qty
        THEN CAST(ROUND((STOCK.estimated_init_promo_stock - PROMO.tgt_prod_sale_qty) * TGT.cum_tgt_sale_pct + PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
        ELSE CAST(ROUND(PROMO.tgt_prod_sale_qty, 0) AS INTEGER)
        END, PROMO.tgt_prod_sale_qty)), 2)
    END AS plan_ab_cum_perc,
    CASE
    WHEN CEIL(DATE_DIFF(DATE(CURRENT_TIMESTAMP()), PROMO.promo_sale_start_dt, DAY) / 7) = TGT.week_nr
    THEN TRUE
    WHEN CEIL(DATE_DIFF(DATE(CURRENT_TIMESTAMP()), PROMO.promo_sale_start_dt, DAY) / 7) > TGT.week_nr AND TGT.week_nr =
       (MAX(TGT.week_nr) OVER (PARTITION BY CAST(PROMO.promo_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING))
    THEN TRUE
    ELSE FALSE
    END AS is_current_fg
  FROM ldl_dig_core.v_agg_sales_promotion AS PROMO
   INNER JOIN ldl_dig_core.t_fact_sales_promotion_week_target AS TGT ON PROMO.wshop_cd = TGT.wshop_cd AND PROMO.promo_dur_week_cnt
       = TGT.promo_dur_week_cnt AND PROMO.promo_start_dt BETWEEN DATE(TGT.dwh_valid_from_tmsp) AND (DATE(TGT.dwh_valid_to_tmsp
       ))
   INNER JOIN INIT_PROMO_STOCK AS STOCK ON PROMO.promo_id = STOCK.promo_id
   LEFT JOIN ldl_dig_core.t_rel_promotion_sales_cluster_week AS REL ON TGT.week_nr = REL.week_nr
  WHERE TGT.tgt_sale_pct <> 0
   AND CEIL(DATE_DIFF(DATE(CURRENT_TIMESTAMP()), PROMO.promo_sale_start_dt, DAY) / 7) > 0);