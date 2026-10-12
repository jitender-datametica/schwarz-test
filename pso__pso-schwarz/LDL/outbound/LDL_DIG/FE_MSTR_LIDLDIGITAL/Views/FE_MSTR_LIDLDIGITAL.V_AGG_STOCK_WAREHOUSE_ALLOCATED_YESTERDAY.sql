--View that contains previous day values of stock(pc) and stock(ekp) for BM Main Dossier. The information of previous day is not available in the main BM View v_agg_stock_warehouse_daily_allocated which represents only today's and last day of previous month values. For Nagios Monitoring purposes we need previous day values.


CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_agg_stock_warehouse_allocated_yesterday (total_stock_cnt_allocated
, total_stock_val_allocated) AS SELECT SUM(AGG_SWD.total_stock_cnt * FACT_SWAD.distribution_pct) AS
 total_stock_cnt_allocated,
 SUM(AGG_SWD.total_stock_cnt * FACT_SWAD.distribution_pct * FACT_PPS.price_val) AS total_stock_val_allocated
FROM ldl_dig_lec_share.v_fact_stock_warehouse_daily AS AGG_SWD
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_cal_day AS CALDAY ON AGG_SWD.cal_dt = CALDAY.cal_dt
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_product_variant AS DIM_PV ON AGG_SWD.prod_variant_sid = DIM_PV.prod_variant_sid
  
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_product AS DIM_P ON DIM_PV.prod_sid = DIM_P.prod_sid
 INNER JOIN ldl_dig_lec_share.v_fact_stock_warehouse_allocation_daily AS FACT_SWAD ON AGG_SWD.wh_sid = FACT_SWAD.wh_sid
   AND DIM_PV.prod_sid = FACT_SWAD.prod_sid AND AGG_SWD.cal_dt = FACT_SWAD.cal_dt
 LEFT JOIN ldl_dig_lec_share.v_fact_product_price_supplier AS FACT_PPS ON DIM_PV.main_supplier_sid = FACT_PPS.supplier_sid
        AND DIM_PV.prod_variant_sid = FACT_PPS.prod_variant_sid AND AGG_SWD.cal_dt BETWEEN CAST(FACT_PPS.active_from_tmsp AS DATE)
      AND (CAST(FACT_PPS.active_to_tmsp AS DATE)) AND FACT_PPS.wshop_cd = 'DE'
     -- DE buys all articles, see NBI-5097 (we could also use INTEGER with the same result)
 AND FACT_PPS.price_type_cd
    = 'EKP' AND FACT_PPS.curr_cd = 'EUR'
WHERE
  /* Filtering on PROD_MATERIAL_TYPE_CD and PROD_ORG_LVL_NAME to provide a comparable value for the today's stock on Management Summary Page in the Dossier */
  CALDAY.cal_dt_offset = - 1 /* Filtering on Previous Day */
 AND DIM_P.prod_material_type_cd IN ('ZHAW', 'ZHSB')
 AND DIM_P.prod_org_lvl_name NOT IN ('Spirituosen', 'Weinwelt');