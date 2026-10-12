CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_store_stock_delta_1 AS
/* Filter WAWI Seite: Altbestaende aus ELWIS Zeit_1 fuer AT */ SELECT STC.client_id,
 ST2WH.src_wh_id AS wh_id,
 ST2WH.src_orig_store_nr AS store,
 ROUND(CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0) AS item_1,
 STC.dwh_valid_from AS stock_dat,
 STC.calc_qty AS qty_stc_calc,
 CAST(NULL AS BIGNUMERIC) AS load_id,
  CASE
  WHEN IFNULL(STC.diff_qty_inv_calc, 0) = 0
  THEN STC.calc_qty
  ELSE STC.inv_qty
  END AS qty_stc_real
FROM ldl_p_lew_core_ac.v_item_location_stock_hist_1 AS STC
 INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_1 AS EX ON STC.dwh_updated >= EX.last_export_tmsp AND EX.process_name =
      'export_wfm_store_stock' AND EX.process_specification = 'delta' AND STC.dwh_valid_from BETWEEN DATE_SUB(CURRENT_DATE
     ,INTERVAL 40 DAY) AND (CURRENT_DATE) AND STC.src_space_switch = 3
 INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_1 AS EXPO_SPEC ON EX.export_specification = EXPO_SPEC.export_specification
    AND STC.client_id = EXPO_SPEC.client_id
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS ST2WH ON STC.client_id = ST2WH.client_id AND STC.loc_sid
    = ST2WH.loc_sid_store AND ST2WH.loc_sid_store <> ST2WH.loc_sid_wh /* Exclude stores which represent a warehouse */
 INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON STC.client_id = ITM.client_id AND STC.item_sid = ITM.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON STC.client_id = MIG.client_id AND (STC.dwh_valid_from <
     MIG.migration_dat_valid_from OR STC.dwh_valid_from > MIG.migration_dat_valid_to)
WHERE ITM.src_orig_item_nr IS NOT NULL;