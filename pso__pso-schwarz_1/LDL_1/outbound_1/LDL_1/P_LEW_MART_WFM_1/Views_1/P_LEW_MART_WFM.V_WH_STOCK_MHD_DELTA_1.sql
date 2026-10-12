/* WaWi Part */ CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_wh_stock_mhd_delta_1 AS
/* keep NULL for timestamp delta (load_id from export job will be inserted into log table) */
-- Ã„nderung WFM Bugfix config_item_cd = 'EJR-Dummy_1'
 /* Delta */ SELECT client_id,
 wh_id,
 orig_item_nr AS item_1,
 dat_formdate AS stock_dat,
 mhd_worst,
 mhd_best,
 CAST(NULL AS BIGNUMERIC) AS load_id
FROM (SELECT rcv.client_id,
   LOC.src_wh_id AS wh_id,
   COALESCE(ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC), 0), CAST(ITM.src_orig_item_nr AS BIGNUMERIC)) AS
   orig_item_nr,
   rcv.dat_formdate,
   MIN(rcv.dat_min_durability_rcv) AS mhd_worst,
   MAX(rcv.dat_min_durability_rcv) AS mhd_best
  FROM (SELECT RCV1.client_id,
     RCV1.wh_loc_sid,
     RCV1.item_sid,
     RCV1.dat_formdate,
     RCV1.dat_min_durability_rcv
    FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving_1 AS RCV1
     INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS M ON RCV1.client_id = M.client_id AND (RCV1.dat_entry_rcv <
         M.migration_dat_valid_from /* Wawi Laender */ OR RCV1.dat_entry_rcv > M.migration_dat_valid_to
         /* eLWIS rollback Laender */)
     INNER JOIN (SELECT DISTINCT RCV0.client_id,
       RCV0.wh_loc_sid,
       RCV0.dat_formdate
      FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving_1 AS RCV0
       INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_1 AS LEXP ON LEXP.process_name = 'export_wfm_wh_stock_mhd' AND
          LEXP.process_specification = 'delta' AND RCV0.timestamp_mod > LEXP.last_export_tmsp
       INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_1 AS EXPO_SPEC ON LEXP.export_specification = EXPO_SPEC
         .export_specification AND RCV0.client_id = EXPO_SPEC.client_id) AS delta_filter ON RCV1.client_id =
        delta_filter.client_id AND RCV1.wh_loc_sid = delta_filter.wh_loc_sid AND RCV1.dat_formdate = delta_filter.dat_formdate
       
    WHERE RCV1.dat_min_durability_rcv IS NOT NULL) AS rcv
   INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CL ON rcv.client_id = CL.client_id
   INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON rcv.client_id = ITM.client_id AND rcv.item_sid = ITM.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON rcv.client_id = LOC.client_id AND rcv.wh_loc_sid = LOC.loc_sid AND
     LOC.wh_store_mark = 'B'
  WHERE ITM.src_orig_item_nr <> '@NON_ITEM'
    -- UserStory757565+INC11325722: Eleminate non cast-able values to protect CAST in line17

  GROUP BY rcv.client_id,
   wh_id,
   orig_item_nr,
   rcv.dat_formdate) AS mhd_wawi;