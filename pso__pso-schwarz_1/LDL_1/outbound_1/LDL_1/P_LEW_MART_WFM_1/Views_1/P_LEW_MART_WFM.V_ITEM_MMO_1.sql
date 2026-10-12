/* Euro Palette */ /* Kolli-Faktor Lage (pro GES) */ /* Kolli */ /* Lage */ /* Kolli */ /* Lage */
/* Hoechstbestand in Kolli (pro Filiale) */ /* Standardbestelleinheit (pro Filiale) */ /* DD */
/* Hoechstbestand in Standardbestelleinheit (pro Filiale) */ /* DD */ /* Lage */
/* ADDITIONAL INFO: min_order_unit_id ist immer identisch max_stock_unit_id ist; wenn sich dies Ãýndert muss View angepasst werden */
/* Mindestbestellmenge in Kolli (pro Filiale) */ /* Hoechstbestand in Standardbestelleinheit (pro Filiale) */
/* Hoechstbestand in Kolli (pro Filiale) */ /* ADDITIONAL INFO, NOT USED FOR IMPORT */ /* Lage */
/* view is only relevant for calc_values, not for shelf_capacity */ /* Euro Palette */
/* Mindestbestellmenge in Kolli (pro Filiale) */ /* Kolli-Faktor Euro (pro GES) */
/* Mindestbestellmenge in Standardbestelleinheit (pro Filiale) */
/* Mindestbestellmenge in Standardbestelleinheit (pro Filiale) */ /* Kolli-Faktor DD (pro GES) */
/* Orientierungsbestand (pro Filiale) */ /* Euro Palette */ /* DD */ /* Euro Palette */ /* DD */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_mmo_1 (client_id, wh_id, store, item_1, unit_cd_class, qty_max_stock,
qty_min_order, qty_max_stock_cases, qty_min_order_cases, qty_orientation_stock, case_factor_dd, case_factor_euro,
case_factor_layer) AS SELECT t2.client_id0 AS client_id,
 t2.orig_wh_nr0 AS wh_id,
 t2.orig_store_nr0 AS store,
 t2.orig_item_nr AS item_1,
 t2.unit_cd_class,
 t2.qty_max_stock,
 t2.qty_min_order,
  CASE
  WHEN t2.unit_cd_class = 1
  THEN ROUND(CAST(t2.qty_max_stock * COALESCE(CAST(t2.case_factor_layer AS BIGNUMERIC), 1) AS BIGNUMERIC), 5)
  WHEN t2.unit_cd_class = 2
  THEN ROUND(CAST(t2.qty_max_stock * COALESCE(t2.case_factor_dd, 1) AS BIGNUMERIC), 5)
  WHEN t2.unit_cd_class = 3
  THEN ROUND(CAST(t2.qty_max_stock * COALESCE(t2.case_factor_euro, 1) AS BIGNUMERIC), 5)
  WHEN t2.unit_cd_class = 0
  THEN CAST(t2.qty_max_stock AS BIGNUMERIC)
  ELSE NULL
  END AS qty_max_stock_cases,
  CASE
  WHEN t2.unit_cd_class = 1
  THEN ROUND(CAST(t2.qty_min_order * COALESCE(CAST(t2.case_factor_layer AS BIGNUMERIC), 1) AS BIGNUMERIC), 5)
  WHEN t2.unit_cd_class = 2
  THEN ROUND(CAST(t2.qty_min_order * COALESCE(t2.case_factor_dd, 1) AS BIGNUMERIC), 5)
  WHEN t2.unit_cd_class = 3
  THEN ROUND(CAST(t2.qty_min_order * COALESCE(t2.case_factor_euro, 1) AS BIGNUMERIC), 5)
  WHEN t2.unit_cd_class = 0
  THEN CAST(t2.qty_min_order AS BIGNUMERIC)
  ELSE NULL
  END AS qty_min_order_cases,
 CAST(t2.qty_orientation_stock AS NUMERIC) AS qty_orientation_stock,
 t2.case_factor_dd,
 t2.case_factor_euro,
 CAST(t2.case_factor_layer AS NUMERIC) AS case_factor_layer
FROM (SELECT DISTINCT MMO.client_id AS client_id0,
   CLNT.src_country_lidl_cd AS country_cd,
   ST2WH.orig_wh_nr AS orig_wh_nr0,
   ST2WH.orig_store_nr AS orig_store_nr0,
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
   NULL AS qty_orientation_stock,
   ITM_LOC_INFO.pallet_factor_dus AS case_factor_dd,
   ITM_LOC_INFO.pallet_factor AS case_factor_euro,
   NULL AS case_factor_layer,
   ITM.client_id,
   ST2WH.orig_wh_nr,
   ST2WH.orig_store_nr,
   ITM.config_item_cd,
   ITM.src_orig_item_nr,
   ITM_UOM.uom_cd
  FROM ldl_p_lew_core_ac.v_item_location_replenishment_info_hist_1 AS MMO
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS CLNT_MIGRATION ON MMO.client_id = CLNT_MIGRATION.client_id AND
     MMO.dwh_valid_from BETWEEN CLNT_MIGRATION.migration_dat_valid_from AND CLNT_MIGRATION.migration_dat_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLNT ON MMO.client_id = CLNT.client_id
   INNER JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist_1 AS ITM_LOC_INFO ON MMO.client_id = ITM_LOC_INFO.client_id
      AND MMO.item_sid = ITM_LOC_INFO.item_sid AND MMO.loc_sid = ITM_LOC_INFO.loc_sid AND CURRENT_DATE BETWEEN
     ITM_LOC_INFO.dwh_valid_from AND ITM_LOC_INFO.dwh_valid_to
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_1 AS ST2WH ON MMO.client_id = ST2WH.client_id AND MMO.loc_sid = ST2WH
      .loc_sid_store AND CURRENT_DATE BETWEEN ST2WH.dwh_valid_from AND ST2WH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON MMO.client_id = LOC.client_id AND MMO.loc_sid = LOC.loc_sid AND LOC
      .wh_store_mark = 'A' AND CAST(LOC.global_loc_type_cd AS FLOAT64) = 0
   INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON MMO.client_id = ITM.client_id AND MMO.item_sid = ITM.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_1 AS ITM_UOM ON MMO.client_id = ITM_UOM.client_id AND MMO.item_sid
      = ITM_UOM.item_sid
  WHERE CURRENT_DATE BETWEEN MMO.dwh_valid_from AND MMO.dwh_valid_to
   AND MMO.deleted_fg = 0
   AND CAST(ITM.log_var_cd AS FLOAT64) = 2
    /* jm: vorerst auf Verkaufvariante eingeschrÃýnkt, bis fachliche Entscheidung kommt (2018-08-16) */
   AND LENGTH(ITM_UOM.uom_cd) > 2
   AND REGEXP_CONTAINS(itm_uom.uom_cd, r'(?i)[KLPD][0-9]{2}')

  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ITM.client_id AS STRING), CAST(ST2WH.orig_wh_nr AS STRING), CAST(ST2WH.orig_store_nr AS STRING)
        , CAST(orig_item_nr AS STRING) ORDER BY unit_cd_class IS NULL, unit_cd_class)) = 1) AS t2
UNION ALL
SELECT CASE
  WHEN MMO.client_id = 23
  THEN 7
  ELSE MMO.client_id
  END AS client_id,
 ST2WH.orig_wh_nr AS wh_id,
 ST2WH.orig_store_nr AS store,
 ROUND(CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0) AS item_1,
 MMO.min_order_unit_id AS unit_cd,
 MMO.max_stock_qty AS qty_max_stock,
 MMO.min_order_qty AS qty_min_order,
  CASE
  WHEN MMO.max_stock_unit_id = 1
  THEN MMO.max_stock_qty * COALESCE(IIWH.layer_factor_qty, 1)
  WHEN MMO.max_stock_unit_id = 2
  THEN MMO.max_stock_qty * COALESCE(IIWH.dd_pallet_factor_qty, 1)
  WHEN MMO.max_stock_unit_id = 3
  THEN MMO.max_stock_qty * COALESCE(IIWH.euro_pallet_factor_qty, 1)
  WHEN MMO.max_stock_unit_id = 0
  THEN MMO.max_stock_qty /* Kolli */
  ELSE NULL
  END AS qty_max_stock_cases,
  CASE
  WHEN MMO.min_order_unit_id = 1
  THEN MMO.min_order_qty * COALESCE(IIWH.layer_factor_qty, 1)
  WHEN MMO.min_order_unit_id = 2
  THEN MMO.min_order_qty * COALESCE(IIWH.dd_pallet_factor_qty, 1)
  WHEN MMO.min_order_unit_id = 3
  THEN MMO.min_order_qty * COALESCE(IIWH.euro_pallet_factor_qty, 1)
  WHEN MMO.min_order_unit_id = 0
  THEN MMO.min_order_qty /* Kolli */
  ELSE NULL
  END AS qty_min_order_cases,
 MMO.orientation_stock_qty AS qty_orientation_stock,
 IIWH.dd_pallet_factor_qty AS case_factor_dd,
 IIWH.euro_pallet_factor_qty AS case_factor_euro,
 IIWH.layer_factor_qty AS case_factor_layer
FROM ldl_p_lew_core_ac.v_item_location_replenishment_info_hist_1 AS MMO
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS CLNT_MIGRATION ON MMO.client_id = CLNT_MIGRATION.client_id AND (MMO
     .dwh_valid_from < CLNT_MIGRATION.migration_dat_valid_from OR MMO.dwh_valid_from > CLNT_MIGRATION.migration_dat_valid_to
     )
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_1 AS ST2WH ON MMO.client_id = ST2WH.client_id AND MMO.loc_sid = ST2WH.loc_sid_store
     AND CURRENT_DATE BETWEEN ST2WH.dwh_valid_from AND ST2WH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist_1 AS IIWH ON MMO.client_id = IIWH.client_id AND MMO.item_sid =
     IIWH.item_sid AND ST2WH.loc_sid_wh = IIWH.loc_sid AND CURRENT_DATE BETWEEN IIWH.dwh_valid_from AND IIWH.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLNT ON MMO.client_id = CLNT.client_id
 INNER JOIN ldl_p_lew_bil_ac.v_item_1 AS ITM ON MMO.client_id = ITM.client_id AND MMO.item_sid = ITM.item_sid
WHERE CURRENT_DATE BETWEEN MMO.dwh_valid_from AND MMO.dwh_valid_to
 AND MMO.deleted_fg = 0
 AND ITM.active_fg = 1
  -- AND iiwh.item_status_id 5 BETWEEN  AND 13 /* valid status_1 (6-11) win, the others are fallbacks, ONLY BETWEEN 6 AND 11 WE HAVE UNIQUENESS!

  
 AND IIWH.item_status_id BETWEEN 5 AND 9 /* only valid status_1, i.e. item_1 can be ordered and/or sold by store */
 AND (MMO.max_stock_qty IS NOT NULL OR MMO.min_order_qty IS NOT NULL OR MMO.orientation_stock_qty IS NOT NULL)
 AND ST2WH.orig_wh_nr <> ST2WH.orig_store_nr /* no dummy_1 stores */
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(MMO.client_id AS STRING), CAST(ST2WH.orig_wh_nr AS STRING), CAST(ST2WH.orig_store_nr AS STRING)
      , ITM.src_orig_item_nr ORDER BY CASE
       WHEN IIWH.item_status_id BETWEEN 6 AND 9
       THEN 1
       ELSE 2
       END IS NULL, CASE
       WHEN IIWH.item_status_id BETWEEN 6 AND 9
       THEN 1
       ELSE 2
       END, MMO.dwh_valid_from IS NULL, MMO.dwh_valid_from, ROUND(ROUND(CAST(ITM.src_case_size AS BIGNUMERIC), 0), 0)
      IS NULL, ROUND(ROUND(CAST(ITM.src_case_size AS BIGNUMERIC), 0), 0), CAST(MMO.min_order_unit_id AS BIGNUMERIC)
      IS NULL, CAST(MMO.min_order_unit_id AS BIGNUMERIC), CAST(MMO.max_stock_unit_id AS BIGNUMERIC) IS NULL, CAST(MMO.max_stock_unit_id AS BIGNUMERIC)
      )) = 1;