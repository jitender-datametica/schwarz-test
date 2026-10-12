CREATE OR REPLACE DYNAMIC TABLE  P_LEW_MART_MSI.V_AGG_STORE_DAY_SFO_BO 
(
	client_id
	,store_id
	,orig_store_nr
	,dat_formdate
	,cy_month
	,sfotype_id
	,qty_total_sfo
	,qty_total_sfo_wrtoff_zero
	,val_rtl_rl_sfo
	,val_rtl_rl_net_sfo
	,val_wrtoff_zero
	,val_wrtoff_zero_net

)

TARGET_LAG = '1 hour, 30 minutes' -- dummy value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS

   SELECT
   bo.client_id
   ,bo.loc_sid_store                  AS store_id
   ,bo.src_orig_store_nr              AS orig_store_nr
   ,bo.booking_dat                    AS dat_formdate
   ,bo.cy_month
   ,bo.sfotype_id
   ,bo.sfo_total_qty                  AS qty_total_sfo
   ,bo.sfo_wrtoff_zero_qty            AS qty_total_sfo_wrtoff_zero
   ,bo.sfo_total_rtl_rl_val           AS val_rtl_rl_sfo
   ,bo.sfo_total_rtl_rl_net_val       AS val_rtl_rl_net_sfo
   ,bo.sfo_wrtoff_zero_rtl_rl_val     AS val_wrtoff_zero
   ,bo.sfo_wrtoff_zero_rtl_rl_net_val AS val_wrtoff_zero_net
  FROM p_lew_bil_ac.v_agg_store_day_sfo_bo bo
   LEFT OUTER JOIN
   (SELECT client_id,
   MIN(migrated_start_dt) AS migrated_start_dt
                  FROM p_lew_process_ac.v_sap_migration_wh

                  GROUP BY 1
                 ) mig
   ON bo.client_id = mig.client_id

   WHERE (mig.client_id IS NULL OR bo.booking_dat < mig.migrated_start_dt)  AND  bo.client_id <> 33
;