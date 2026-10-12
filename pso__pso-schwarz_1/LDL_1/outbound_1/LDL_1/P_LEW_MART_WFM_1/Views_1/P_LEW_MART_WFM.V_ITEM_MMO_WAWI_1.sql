CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_mmo_wawi_1 (client_id, orig_wh_nr, orig_store_nr, orig_item_nr, unit_cd,
qty_max_stock, qty_min_order, qty_max_stock_cases, qty_min_order_cases, qty_orientation_stock, case_factor_dd,
case_factor_euro, case_factor_layer) AS /* Standardbestelleinheit (pro Filiale) */
/* ADDITIONAL INFO: min_order_unit_id ist immer identisch max_stock_unit_id ist; wenn sich dies Ãýndert muss View angepasst werden */
/* Hoechstbestand in Standardbestelleinheit (pro Filiale) */
/* Mindestbestellmenge in Standardbestelleinheit (pro Filiale) */ /* Lage */ /* DD */ /* Euro Palette */
/* Hoechstbestand in Kolli (pro Filiale) */ /* Lage */ /* DD */ /* Euro Palette */
/* Mindestbestellmenge in Kolli (pro Filiale) */ /* ADDITIONAL INFO, NOT USED FOR IMPORT */
/* Orientierungsbestand (pro Filiale) */ /* Kolli-Faktor DD (pro GES) */ /* Kolli-Faktor Euro (pro GES) */
/* Kolli-Faktor Lage (pro GES) */ /* view is only relevant for calc_values, not for shelf_capacity */ SELECT CASE
  WHEN MMO.client_id = 23
  THEN 7
  ELSE MMO.client_id
  END AS client_id,
 ST2WH.orig_wh_nr,
 ST2WH.orig_store_nr,
 ITM.src_orig_item_nr AS orig_item_nr,
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
  -- AND iiwh.item_status_id BETWEEN 5 AND 13 /* valid status_1 (6-11) win, the others are fallbacks, ONLY BETWEEN 6 AND 11 WE HAVE UNIQUENESS!

  
 AND IIWH.item_status_id BETWEEN 5 AND 9 /* only valid status_1, i.e. item_1 can be ordered store/wh */
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