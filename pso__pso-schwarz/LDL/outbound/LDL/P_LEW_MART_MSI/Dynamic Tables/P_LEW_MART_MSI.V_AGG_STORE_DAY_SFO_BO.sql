
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_agg_store_day_sfo_bo
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT BO.client_id,
 BO.loc_sid_store AS store_id,
 BO.src_orig_store_nr AS orig_store_nr,
 BO.booking_dat AS dat_formdate,
 BO.cy_month,
 BO.sfotype_id,
 BO.sfo_total_qty AS qty_total_sfo,
 BO.sfo_wrtoff_zero_qty AS qty_total_sfo_wrtoff_zero,
 BO.sfo_total_rtl_rl_val AS val_rtl_rl_sfo,
 BO.sfo_total_rtl_rl_net_val AS val_rtl_rl_net_sfo,
 BO.sfo_wrtoff_zero_rtl_rl_val AS val_wrtoff_zero,
 BO.sfo_wrtoff_zero_rtl_rl_net_val AS val_wrtoff_zero_net
FROM ldl_p_lew_bil_ac.v_agg_store_day_sfo_bo AS BO
 LEFT JOIN (SELECT client_id,
   MIN(migrated_start_dt) AS migrated_start_dt
  FROM ldl_p_lew_process_ac.v_sap_migration_wh
  GROUP BY client_id) AS mig ON BO.client_id = mig.client_id
WHERE (mig.client_id IS NULL OR BO.booking_dat < mig.migrated_start_dt)
 AND BO.client_id <> 33;

