/*
    split into two parts (see NBI-4317):
        1) dates from 2022-05-19 and later have daily distribution percentages, which can be used to calculate the allocations
        2) dated before 2022-05-19 do not have daily distribution percentages; use the most recent distribution percentages to calculate the allocations
        
Change History
08.05.2023      ABA     -Replaced core.v_agg_stock_warehouse_daily by core.t_fact_stock_warehouse_daily
                        -Added INNER JOINS of FE_MSTR_LIDLDIGITAL.V_DIM_CAL_DAY and FE_MSTR_LIDLDIGITAL.V_DIM_CAL_MONTH in order to filter on Last day of month for past months
                        -For FE_MSTR_LIDLDIGITAL.V_DIM_PRODUCT_VARIANT and FE_MSTR_LIDLDIGITAL.V_FACT_STOCK_WAREHOUSE_WEBSHOP_ALLOCATION_DAILY changed from LEFT OUTER to INNER JOINS for better performance

02.08.2023      ABA     -replaced V_FACT_STOCK_WAREHOUSE_WEBSHOP_ALLOCATION_DAILY by T_FACT_STOCK_WAREHOUSE_ALLOCATION_DAILY to introduce stock allocations by wh alloc entity (KL_DE, LI_DE, INT ...) instead of Webshops
                        -added wh_alloc_entity_cd field
                        -Left join to t_dim_distribution_channel added to still get webshop information. This is planned to keep during transitions phase to make webshop replacement in MSTR easier. After replacement the CROSS JOIN will be deleted.

30.10.2023      ABA     -delete CROSS JOIN with t_dim_distribution_channel and remove wshop_cd field
31.10.2023      ABA     -added CROSS JOIN to t_dim_warehouse_allocation_entity to get WH_ALLOC_ENTITY_COUNTRY_CD field which is needed for regional product hierarchy joins in MSTR
14.01.2025      EMO     -deleted covered_remain_cnt field
18.02.2025      ABA     -changed where condition to restrict cal_dt, old solution was too inperformant
                        -deleted joins to calendar tables
                        -deleted union all statement for entries older than May 2022 as data is filtered to last 24 months
*/


CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_stock_warehouse_daily_allocated (wh_sid, prod_variant_sid,
cal_dt, active_fg, blocked_stock_cnt_allocated, blocked_stock_val_allocated, blocked_stock_return_cnt_allocated,
blocked_stock_return_val_allocated, unrestricted_stock_cnt_allocated, unrestricted_stock_val_allocated,
restricted_stock_cnt_allocated, restricted_stock_val_allocated, in_transfer_cnt_allocated, in_transfer_val_allocated,
in_transit_cnt_allocated, in_transit_val_allocated, in_qty_inspection_cnt_allocated, in_qty_inspection_val_allocated,
avail_to_promise_cnt_allocated, avail_to_promise_val_allocated, avail_to_sell_cnt_allocated, avail_to_sell_val_allocated
, receiv_on_dock_cnt_allocated, receiv_on_dock_val_allocated, total_stock_cnt_allocated, total_stock_val_allocated,
wh_alloc_entity_cd, wh_alloc_entity_country_cd, prod_sid, distribution_pct, alloc_promo_class_cd, supplier_sid, curr_cd
, ekp_price_val, gc_lc_cd) AS SELECT IFNULL(AGG_SWD.wh_sid, - 1) AS wh_sid,
 IFNULL(AGG_SWD.prod_variant_sid, - 1) AS prod_variant_sid,
 AGG_SWD.cal_dt,
 AGG_SWD.active_fg,
  AGG_SWD.blocked_stock_cnt * FACT_SWAD.distribution_pct AS blocked_stock_cnt_allocated,
   AGG_SWD.blocked_stock_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS blocked_stock_val_allocated,
  AGG_SWD.blocked_stock_return_cnt * FACT_SWAD.distribution_pct AS blocked_stock_return_cnt_allocated,
   AGG_SWD.blocked_stock_return_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS
 blocked_stock_return_val_allocated,
  AGG_SWD.unrestricted_stock_cnt * FACT_SWAD.distribution_pct AS unrestricted_stock_cnt_allocated,
   AGG_SWD.unrestricted_stock_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS unrestricted_stock_val_allocated
 ,
  AGG_SWD.restricted_stock_cnt * FACT_SWAD.distribution_pct AS restricted_stock_cnt_allocated,
   AGG_SWD.restricted_stock_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS restricted_stock_val_allocated,
  AGG_SWD.in_transfer_cnt * FACT_SWAD.distribution_pct AS in_transfer_cnt_allocated,
   AGG_SWD.in_transfer_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS in_transfer_val_allocated,
  AGG_SWD.in_transit_cnt * FACT_SWAD.distribution_pct AS in_transit_cnt_allocated,
   AGG_SWD.in_transit_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS in_transit_val_allocated,
  AGG_SWD.in_qty_inspection_cnt * FACT_SWAD.distribution_pct AS in_qty_inspection_cnt_allocated,
   AGG_SWD.in_qty_inspection_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS in_qty_inspection_val_allocated,
  AGG_SWD.avail_to_promise_cnt * FACT_SWAD.distribution_pct AS avail_to_promise_cnt_allocated,
   AGG_SWD.avail_to_promise_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS avail_to_promise_val_allocated,
  AGG_SWD.avail_to_sell_cnt * FACT_SWAD.distribution_pct AS avail_to_sell_cnt_allocated,
   AGG_SWD.avail_to_sell_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS avail_to_sell_val_allocated,
  AGG_SWD.receiv_on_dock_cnt * FACT_SWAD.distribution_pct AS receiv_on_dock_cnt_allocated,
   AGG_SWD.receiv_on_dock_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS receiv_on_dock_val_allocated,
  AGG_SWD.total_stock_cnt * FACT_SWAD.distribution_pct AS total_stock_cnt_allocated,
   AGG_SWD.total_stock_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val AS total_stock_val_allocated,
 IFNULL(FACT_SWAD.wh_alloc_entity_cd, '-1') AS wh_alloc_entity_cd,
 IFNULL(DIM_WAE.wh_alloc_entity_country_cd, '-1') AS wh_alloc_entity_country_cd,
 IFNULL(FACT_SWAD.prod_sid, - 1) AS prod_sid,
 FACT_SWAD.distribution_pct,
  CASE
  WHEN FACT_SWAD.alloc_promo_class_cd = ''
  THEN '-1'
  ELSE IFNULL(FACT_SWAD.alloc_promo_class_cd, '-1')
  END AS alloc_promo_class_cd,
 IFNULL(FACT_PPS.supplier_sid, - 1) AS supplier_sid,
  CASE
  WHEN FACT_PPS.curr_cd = ''
  THEN '-1'
  ELSE IFNULL(FACT_PPS.curr_cd, '-1')
  END AS curr_cd,
 FACT_PPS.price_val AS ekp_price_val,
 'GC' AS gc_lc_cd
FROM ldl_dig_lec_share.v_fact_stock_warehouse_daily AS AGG_SWD
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_product_variant AS DIM_PV ON AGG_SWD.prod_variant_sid = DIM_PV.prod_variant_sid
  
 INNER JOIN ldl_dig_lec_share.v_fact_stock_warehouse_allocation_daily AS FACT_SWAD ON AGG_SWD.wh_sid = FACT_SWAD.wh_sid
   AND DIM_PV.prod_sid = FACT_SWAD.prod_sid AND AGG_SWD.cal_dt = FACT_SWAD.cal_dt
 INNER JOIN ldl_dig_lec_share.v_dim_warehouse_allocation_entity AS DIM_WAE ON FACT_SWAD.wh_alloc_entity_cd = DIM_WAE.wh_alloc_entity_cd
  
 LEFT JOIN ldl_dig_lec_share.v_fact_product_price_supplier AS FACT_PPS ON DIM_PV.main_supplier_sid = FACT_PPS.supplier_sid
        AND DIM_PV.prod_variant_sid = FACT_PPS.prod_variant_sid AND AGG_SWD.cal_dt BETWEEN CAST(FACT_PPS.active_from_tmsp AS DATE)
      AND (CAST(FACT_PPS.active_to_tmsp AS DATE)) AND FACT_PPS.wshop_cd = 'DE' AND FACT_PPS.price_type_cd = 'EKP' AND
   FACT_PPS.curr_cd = 'EUR'
WHERE AGG_SWD.cal_dt >= DATE('2022-05-19')
 AND (AGG_SWD.active_fg OR AGG_SWD.cal_dt BETWEEN DATE_TRUNC(IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE
         ,INTERVAL - 24 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 24 MONTH)), MONTH) AND (LAST_DAY(IF(CURRENT_DATE =
         LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL -
         1 MONTH)), MONTH)) AND AGG_SWD.cal_dt = LAST_DAY(AGG_SWD.cal_dt, MONTH));