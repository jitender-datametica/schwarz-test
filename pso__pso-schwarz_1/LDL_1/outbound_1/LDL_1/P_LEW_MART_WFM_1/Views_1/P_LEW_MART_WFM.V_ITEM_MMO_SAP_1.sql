CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_mmo_sap_1 (client_id, orig_wh_nr, orig_store_nr, orig_item_nr,
unit_cd_class, qty_max_stock, qty_min_order, qty_max_stock_cases, qty_min_order_cases, qty_orientation_stock,
case_factor_dd, case_factor_euro, case_factor_layer) AS SELECT DISTINCT MMO.client_id,
 ST2WH.orig_wh_nr,
 ST2WH.orig_store_nr,
 ROUND(CAST(COALESCE(ITM.config_item_cd, ITM.src_orig_item_nr) AS BIGNUMERIC), 0) AS orig_item_nr,
  CASE
  WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'K'
  THEN 0
  WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'L'
  THEN 1
  WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'D'
  THEN 2
  WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'P'
  THEN 3
  ELSE - 1
  END AS unit_cd_class,
 MMO.max_stock_qty AS qty_max_stock,
 MMO.min_order_qty AS qty_min_order,
  CASE
  WHEN CASE
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'K'
    THEN 0
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'L'
    THEN 1
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'D'
    THEN 2
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'P'
    THEN 3
    ELSE - 1
    END = 1
  THEN ROUND(CAST(MMO.max_stock_qty * COALESCE(CAST(NULL AS BIGNUMERIC), 1) AS BIGNUMERIC), 5)
  WHEN CASE
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'K'
    THEN 0
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'L'
    THEN 1
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'D'
    THEN 2
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'P'
    THEN 3
    ELSE - 1
    END = 2
  THEN ROUND(CAST(MMO.max_stock_qty * COALESCE(ITM_LOC_INFO.pallet_factor_dus, 1) AS BIGNUMERIC), 5)
  WHEN CASE
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'K'
    THEN 0
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'L'
    THEN 1
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'D'
    THEN 2
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'P'
    THEN 3
    ELSE - 1
    END = 3
  THEN ROUND(CAST(MMO.max_stock_qty * COALESCE(ITM_LOC_INFO.pallet_factor, 1) AS BIGNUMERIC), 5)
  WHEN CASE
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'K'
    THEN 0
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'L'
    THEN 1
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'D'
    THEN 2
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'P'
    THEN 3
    ELSE - 1
    END = 0
  THEN CAST(MMO.max_stock_qty AS BIGNUMERIC)
  ELSE NULL
  END AS qty_max_stock_cases,
  CASE
  WHEN CASE
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'K'
    THEN 0
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'L'
    THEN 1
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'D'
    THEN 2
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'P'
    THEN 3
    ELSE - 1
    END = 1
  THEN ROUND(CAST(MMO.min_order_qty * COALESCE(CAST(NULL AS BIGNUMERIC), 1) AS BIGNUMERIC), 5)
  WHEN CASE
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'K'
    THEN 0
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'L'
    THEN 1
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'D'
    THEN 2
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'P'
    THEN 3
    ELSE - 1
    END = 2
  THEN ROUND(CAST(MMO.min_order_qty * COALESCE(ITM_LOC_INFO.pallet_factor_dus, 1) AS BIGNUMERIC), 5)
  WHEN CASE
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'K'
    THEN 0
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'L'
    THEN 1
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'D'
    THEN 2
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'P'
    THEN 3
    ELSE - 1
    END = 3
  THEN ROUND(CAST(MMO.min_order_qty * COALESCE(ITM_LOC_INFO.pallet_factor, 1) AS BIGNUMERIC), 5)
  WHEN CASE
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'K'
    THEN 0
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'L'
    THEN 1
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'D'
    THEN 2
    WHEN SUBSTR(ITM_UOM.uom_cd, 1, 1) = 'P'
    THEN 3
    ELSE - 1
    END = 0
  THEN CAST(MMO.min_order_qty AS BIGNUMERIC)
  ELSE NULL
  END AS qty_min_order_cases,
 NULL AS qty_orientation_stock,
 ITM_LOC_INFO.pallet_factor_dus AS case_factor_dd,
 ITM_LOC_INFO.pallet_factor AS case_factor_euro,
 NULL AS case_factor_layer
FROM ldl_p_lew_core_ac.v_item_location_replenishment_info_hist_1 AS MMO
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS CLNT_MIGRATION ON MMO.client_id = CLNT_MIGRATION.client_id AND
   MMO.dwh_valid_from BETWEEN CLNT_MIGRATION.migration_dat_valid_from AND CLNT_MIGRATION.migration_dat_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLNT ON MMO.client_id = CLNT.client_id
 INNER JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist_1 AS ITM_LOC_INFO ON MMO.client_id = ITM_LOC_INFO.client_id
    AND MMO.item_sid = ITM_LOC_INFO.item_sid AND MMO.loc_sid = ITM_LOC_INFO.loc_sid AND CURRENT_DATE BETWEEN
   ITM_LOC_INFO.dwh_valid_from AND ITM_LOC_INFO.dwh_valid_to
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_1 AS ST2WH ON MMO.client_id = ST2WH.client_id AND MMO.loc_sid = ST2WH.loc_sid_store
     AND CURRENT_DATE BETWEEN ST2WH.dwh_valid_from AND ST2WH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON MMO.client_id = LOC.client_id AND MMO.loc_sid = LOC.loc_sid AND LOC.wh_store_mark
     = 'A' AND CAST(LOC.global_loc_type_cd AS FLOAT64) = 0
 INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON MMO.client_id = ITM.client_id AND MMO.item_sid = ITM.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_1 AS ITM_UOM ON MMO.client_id = ITM_UOM.client_id AND MMO.item_sid
    = ITM_UOM.item_sid
WHERE CURRENT_DATE BETWEEN MMO.dwh_valid_from AND MMO.dwh_valid_to
 AND MMO.deleted_fg = 0
 AND CAST(ITM.log_var_cd AS FLOAT64) = 2
 AND LENGTH(ITM_UOM.uom_cd) > 2
 AND REGEXP_CONTAINS(itm_uom.uom_cd, r'(?i)[KLPD][0-9]{2}')
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ITM.client_id AS STRING), CAST(ST2WH.orig_wh_nr AS STRING), CAST(ST2WH.orig_store_nr AS STRING)
      , CAST(orig_item_nr AS STRING) ORDER BY unit_cd_class IS NULL, unit_cd_class)) = 1;