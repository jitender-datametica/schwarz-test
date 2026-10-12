
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STR_DAY_NET_ASIS_EXT 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
       ext.client_id,
   ext.store_id,
   ext.dat_formdate,
   ext.cy_month,
   cry.currency_iso_cd,
   ext.val_retail_net_ASis / cry.rate_currency_exchange AS val_retail_net_ASis,
   ext.val_retail_net_extrapol_ASis / cry.rate_currency_exchange AS val_retail_net_extrapol_ASis
   FROM (
       /* That UNION provides the full aggregation view with all turnover values or
       extrapolated values (if calculated) in the extrapol column. */
       /* Part 1 - Data with no turnover => turnover will be extrapolated */
       SELECT
           sb.client_id,
   sb.store_id,
   sb.dat_open AS dat_formdate,
   (EXTRACT (YEAR FROM e.dat_calendar)*100 + EXTRACT (MONTH FROM e.dat_calendar) ) AS cy_month,
   sb.val_retail_net_ASis AS val_retail_net_ASis,
   COALESCE(AVG(CASE WHEN f.val_rtl_net = 0 THEN NULL ELSE f.val_rtl_net END ),0) AS val_retail_net_extrapol_ASis
      FROM (
          /* take only those records which have 0s or NULLs in turnover for this store, client and date */
          SELECT
              mds.client_id,
   mds.store_id,
   mds.dat_open,
   fs.val_rtl_net AS val_retail_net_ASis
          FROM p_lew_mart_msi.v_sys_md_storelist AS mds
   LEFT OUTER JOIN p_lew_mart_msi.v_agg_str_day_ejr_kpg_net_ASis AS fs
   ON  mds.dat_open=fs.dat_formdate
   AND mds.client_id=fs.client_id
   AND mds.store_id = fs.store_id
   WHERE (fs.val_rtl_net = 0 OR fs.val_rtl_net IS NULL)
) sb
   INNER JOIN p_lew_mart_msi.v_cal_day_rel_extrapol e
   ON  e.dat_calendar = sb.dat_open
   LEFT OUTER JOIN p_lew_mart_msi.v_agg_str_day_ejr_kpg_net_ASis AS f
   ON  e.dat_calendar_extrapol = f.dat_formdate
   AND sb.client_id = f.client_id
   AND sb.store_id  =  f.store_id
   /* the source table v_agg_str_day_ejr_txj_ww ensures the key (client_id, st_loc_sid, dat_formdate).
   That means, grouping the fields cnt_customer and val_retail is practicable. */
   GROUP BY 1,2,3,4,5
   UNION
   /* Part 2 - Data with turnover => just select the turnover
   Unite with all other rows from fact table, which have turnover values and needed no
   additional calculation. */
   SELECT
       dt_a.client_id,
   dt_a.store_id,
   dt_a.dat_formdate,
   (EXTRACT (YEAR FROM dt_a.dat_formdate)*100 + EXTRACT (MONTH FROM dt_a.dat_formdate) ) AS cy_month,
   dt_a.val_rtl_net AS val_retail_net_ASis,
   dt_a.val_rtl_net AS val_retail_net_extrapol_ASis
      FROM p_lew_mart_msi.v_agg_str_day_ejr_kpg_net_ASis AS dt_a
   /* take all those rows that were NOT used for extrapolation */
   WHERE dt_a.val_rtl_net IS NOT NULL AND dt_a.val_rtl_net <> 0
   ) ext
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate cry
   ON ext.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
;
