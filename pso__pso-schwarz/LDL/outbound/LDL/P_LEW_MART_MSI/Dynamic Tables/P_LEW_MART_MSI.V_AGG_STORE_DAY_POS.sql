
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_agg_store_day_pos
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT CHST.client_id,
 CHST.st_loc_sid AS store_id,
 CHST.dat_dayend,
 CHST.checker_id,
 SUM(CASE
   WHEN cbal.recordtype_id_cashbalance = 'S'
   THEN CHST.cnt_item_scanned
   ELSE 0
   END) AS cnt_item_scan_ejr,
 SUM(CASE
   WHEN cbal.recordtype_id_cashbalance = 'S'
   THEN CHST.cnt_item_direct
   ELSE 0
   END) AS cnt_item_man_ejr,
 SUM(CASE
   WHEN cbal.recordtype_id_cashbalance = 'S'
   THEN CHST.dur_service
   ELSE 0.00
   END) AS dur_service_ejr
FROM ldl_p_lew_core_ac.v_wawi_ejr_checkerstatus AS CHST
 INNER JOIN (SELECT client_id,
   st_loc_sid,
   dat_dayend,
   checker_id,
   recordtype_id_cashbalance
  FROM ldl_p_lew_core_ac.v_wawi_ejr_cashbalance
  GROUP BY client_id,
   st_loc_sid,
   dat_dayend,
   checker_id,
   recordtype_id_cashbalance) AS cbal ON CHST.client_id = cbal.client_id AND CHST.st_loc_sid = cbal.st_loc_sid AND CHST
    .checker_id = cbal.checker_id AND CHST.dat_dayend = cbal.dat_dayend
GROUP BY CHST.client_id,
 store_id,
 CHST.dat_dayend,
 CHST.checker_id;
