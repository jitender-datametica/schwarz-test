CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_sendungssplit_master
OPTIONS(DESCRIPTION = `2024-10-23_LCI-217: - FACT_COL CTE: REMOVED PROD_QTY,CY_WEEK_OFFSET, INNER JOIN WITH CAL_DAY, WHERE CONDITION ON CY_WEEK_OFFSET BETWEEN -57 AND 0- FACT_ICOL CTE: REMOVED PROD_QTY,CY_WEEK_OFFSET, INNER JOIN WITH CAL_DAY, WHERE CONDITION ON CY_WEEK_OFFSET BETWEEN -57 AND 0- COL_HELPER_FIELDS CTE: REMOVED INNER JOIN WITH CAL_DAY, WHERE CONDITION ON CY_WEEK_OFFSET BETWEEN -57 AND 0- ICOL_HELPER_FIELDS CTE: REMOVED INNER JOIN WITH CAL_DAY, WHERE CONDITION ON CY_WEEK_OFFSET BETWEEN -57 AND 0- FINAL SELECT: ADDED REL_OP.PACK_ORDER_NR, REL_OP.PACK_POS_NR, REL_OP.PROD_VARIANT_SID, FACT_SPS.PACK_MATERIAL_NR, IS_SINGLE_POSITION_WH, PROD_VARIANT_PACKING_TYPE_MPO_FG- FINAL SELECT: REMOVED MAX() BECAUSE WE ARE NOW IN LOWEST GRANULARITY, INCREASED GRANULARITY BECAUSE OF USERS NEED (DORIS GAMPPER) TO MAKE EPO/MPO DISTINCTION AND TO DISPLAY DATA ON VARIANT LEVEL- DELETED FACT_ICOL.CY_WEEK_OFFSET BETWEEN -57 AND 0 /FACT_COL.CY_WEEK_OFFSET BETWEEN -57 AND 0 FROM FINAL WHERE BECAUSE THE FILTER IS IMPLEMENTED IN MSTR CUBE2025-01-20 ABA-DELETED NOT NEEDED JOINS TO CTES (T_FACT_CUSTOMER_ORDER_LINE AND T_FACT_INTERCOMPANY_ORDER_LINE)-DELETED IS_SINGLE_POSITION_FG & IS_CANCEL_FG: BOTH ARE NOT USED IN FRONTEND`)
AS SELECT COALESCE(FACT_SPS.wshop_cd, '-1') AS wshop_cd,
 FACT_SPS.dist_channel_cd,
 FACT_SPS.wh_sid,
 FACT_SPS.pack_order_nr,
 REL_OP.pack_pos_nr,
 REL_OP.prod_variant_sid,
 FACT_SPS.pack_material_nr,
 FACT_SPS.pack_tracking_nr,
 FACT_SPS.delivery_order_nr,
 FACT_SPS.cust_order_dt,
 REL_OP.cust_order_sid,
 FACT_SPS.cust_order_nr,
 FACT_SPS.cust_order_type_cd,
 FACT_SPS.ic_order_dt,
 REL_OP.ic_order_sid,
 FACT_SPS.ic_order_nr,
 REL_OP.deliv_prod_qty,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.wh_leave_tgt_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS wh_leave_tgt_tmsp,
 DATE(FACT_SPS.wh_leave_tgt_tmsp) AS wh_leave_tgt_date,
  CASE
  WHEN (SUM(REL_OP.deliv_prod_qty) OVER (PARTITION BY FACT_SPS.delivery_order_nr, DATE(FACT_SPS.wh_leave_actual_tmsp), CAST(FACT_SPS.wh_sid AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 1
  THEN 1
  ELSE 0
  END AS is_single_position_wh,
  CASE
  WHEN (SUM(REL_OP.deliv_prod_qty) OVER (PARTITION BY FACT_SPS.delivery_order_nr, DATE(FACT_SPS.wh_leave_actual_tmsp), CAST(FACT_SPS.wh_sid AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 1
  THEN 'EPO'
  WHEN (COUNTIF(CAST(DIM_PV.prod_variant_packing_type_cd AS FLOAT64) <> 2002) OVER (PARTITION BY FACT_SPS.delivery_order_nr
        , DATE(FACT_SPS.wh_leave_actual_tmsp), CAST(FACT_SPS.wh_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) > 0 AND (SUM(REL_OP.deliv_prod_qty) OVER (PARTITION BY FACT_SPS.delivery_order_nr, DATE(FACT_SPS
         .wh_leave_actual_tmsp), CAST(FACT_SPS.wh_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) > 1
  THEN 'MPO Karton'
  ELSE 'MPO Tüte'
  END AS prod_variant_packing_type_mpo_fg,
 IF(FACT_SPS.wh_leave_actual_tmsp > SAFE_CAST('2017-09-22 00:00:00' as TIMESTAMP), 'Ja', 'Nein') AS
 is_wh_leave_booked,
 IF(DIM_P.is_wine_spirits_fg = SAFE_CAST('true' as BOOL), 'Wein', DIM_WH.wh_storage_type_cd) AS wh_storage_type_desc_alt
 ,
 CAST(CONCAT(FACT_SPS.pack_order_nr, IF(DIM_P.is_wine_spirits_fg = SAFE_CAST('true' as BOOL), 'Wein', DIM_WH.wh_storage_type_cd), FACT_SPS.wh_sid) AS STRING)
 AS pack_order_nr_wh_storage_type_desc_alt_wh_sid,
 CONCAT(COALESCE(FACT_SPS.cust_order_nr, FACT_SPS.ic_order_nr), IF(DIM_P.is_wine_spirits_fg = SAFE_CAST('true' as BOOL)
   , 'Wein', DIM_WH.wh_storage_type_cd)) AS cust_order_nr_wh_storage_type_desc_alt,
 CAST(CONCAT(COALESCE(FACT_SPS.cust_order_nr, FACT_SPS.ic_order_nr), IF(DIM_P.is_wine_spirits_fg = SAFE_CAST('true' as BOOL), 'Wein', DIM_WH.wh_storage_type_cd), FACT_SPS.wh_sid) AS STRING)
 AS cust_order_nr_wh_storage_type_desc_alt_wh_sid
FROM ldl_dig_lec_share.v_rel_order_packaging AS REL_OP
 LEFT JOIN ldl_dig_lec_share.v_fact_sales_package_shipment AS FACT_SPS ON REL_OP.pack_sid = FACT_SPS.pack_sid
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_warehouse AS DIM_WH ON FACT_SPS.wh_sid = DIM_WH.wh_sid
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_product_variant AS DIM_PV ON REL_OP.prod_variant_sid = DIM_PV.prod_variant_sid
  
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_product AS DIM_P ON DIM_PV.prod_sid = DIM_P.prod_sid
WHERE REL_OP.cust_order_sid IS NOT NULL
 OR REL_OP.ic_order_sid IS NOT NULL;