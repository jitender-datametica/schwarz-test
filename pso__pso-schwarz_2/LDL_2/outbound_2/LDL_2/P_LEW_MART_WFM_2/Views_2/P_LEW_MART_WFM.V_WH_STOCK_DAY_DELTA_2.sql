/* WaWi Part */ CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_wh_stock_day_delta_2 AS
/* keep NULL for timestamp delta (load_id from export job will be inserted into log table) */
/* Filter WAWI Seite: Altbestaende aus ELWIS Zeit_2 fuer AT */ SELECT client_id,
 wh_id,
 orig_item_nr AS item_2,
 CAST(dat_formdate AS STRING) AS stock_dat,
 ROUND(CAST(stock AS NUMERIC), 4) AS stock,
 CAST(NULL AS BIGNUMERIC) AS load_id
FROM (SELECT stc.client_id,
   LOC.src_wh_id AS wh_id,
   ROUND(CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0) AS orig_item_nr,
   stc.dat_formdate,
   SUM(stc.calc_qty) AS stock
  FROM (SELECT STC0.client_id,
     STC0.loc_sid,
     STC0.item_sid,
     STC0.dwh_valid_from AS dat_formdate,
     STC0.calc_qty,
     STC0.dwh_load_id
    FROM ldl_p_lew_core_ac.v_item_location_stock_hist_2 AS STC0
     INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_2 AS EX ON STC0.dwh_updated >= EX.last_export_tmsp AND EX.process_name
          = 'export_wfm_wh_stock_day' AND EX.process_specification = 'delta' AND STC0.dwh_valid_from BETWEEN DATE_SUB(CURRENT_DATE
        ,INTERVAL 40 DAY) AND (CURRENT_DATE)
     INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_2 AS EXPO_SPEC ON EX.export_specification = EXPO_SPEC.export_specification
        AND STC0.client_id = EXPO_SPEC.client_id) AS stc
   INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITM ON stc.client_id = ITM.client_id AND stc.item_sid = ITM.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON stc.client_id = LOC.client_id AND stc.loc_sid = LOC.loc_sid AND LOC
     .wh_store_mark = 'B'
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON stc.client_id = MIG.client_id AND (stc.dat_formdate <
       MIG.migration_dat_valid_from OR stc.dat_formdate > MIG.migration_dat_valid_to)
  WHERE ITM.src_orig_item_nr IS NOT NULL
  GROUP BY stc.client_id,
   wh_id,
   orig_item_nr,
   stc.dat_formdate) AS wh_stock_wawi;