CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_agg_str_day_net_asis_ext_2 AS
/* That UNION provides the full aggregation view with all turnover values or
       extrapolated values (if calculated) in the extrapol column. */
/* Part 1 - Data with no turnover => turnover will be extrapolated */
/* take only those records which have 0s or NULLs in turnover for this store, client and date */
/* Part 2 - Data with turnover => just select the turnover
   Unite with all other rows from fact table, which have turnover values and needed no
   additional calculation. */
/* take all those rows that were NOT used for extrapolation */ 
SELECT ext.client_id AS client_id,
 ext.store_id AS store_id,
 ext.dat_formdate AS dat_formdate,
 ext.cy_month AS cy_month,
 CRY.currency_iso_cd AS currency_iso_cd,
  ext.val_retail_net_asis / CRY.rate_currency_exchange AS val_retail_net_asis,
  ext.val_retail_net_extrapol_asis / CRY.rate_currency_exchange AS val_retail_net_extrapol_asis
FROM (SELECT sb.client_id,
    sb.store_id,
    sb.dat_open AS dat_formdate,
      EXTRACT(YEAR FROM E.dat_calendar) * 100 + EXTRACT(MONTH FROM E.dat_calendar) AS cy_month,
    sb.val_retail_net_asis,
    AVG(CASE
      WHEN F.val_rtl_net = 0
      THEN NULL
      ELSE F.val_rtl_net
      END) AS val_retail_net_extrapol_asis
   FROM (SELECT MDS.client_id,
      MDS.store_id,
      MDS.dat_open,
      FS.val_rtl_net AS val_retail_net_asis
     FROM ldl_p_lew_mart_msi.v_sys_md_storelist_2 AS MDS
      LEFT JOIN ldl_p_lew_mart_msi.v_agg_str_day_ejr_kpg_net_asis_2 AS FS ON MDS.dat_open = FS.dat_formdate AND MDS.client_id
          = FS.client_id AND MDS.store_id = FS.store_id
     WHERE FS.val_rtl_net IS NULL
      OR FS.val_rtl_net = 0) AS sb
    INNER JOIN ldl_p_lew_mart_msi.v_cal_day_rel_extrapol_2 AS E ON sb.dat_open = E.dat_calendar
    LEFT JOIN ldl_p_lew_mart_msi.v_agg_str_day_ejr_kpg_net_asis_2 AS F ON E.dat_calendar_extrapol = F.dat_formdate AND sb
       .client_id = F.client_id AND sb.store_id = F.store_id
      /* the source table v_agg_str_day_ejr_txj_ww ensures the key (client_id, st_loc_sid, dat_formdate).
   That means, grouping the fields cnt_customer and val_retail is practicable. */
      
   GROUP BY sb.client_id,
    sb.store_id,
    dat_formdate,
    cy_month,
    sb.val_retail_net_asis
   UNION DISTINCT
   SELECT client_id,
    store_id,
    dat_formdate,
      EXTRACT(YEAR FROM dat_formdate) * 100 + EXTRACT(MONTH FROM dat_formdate) AS cy_month,
    val_rtl_net AS val_retail_net_asis,
    val_rtl_net AS val_retail_net_extrapol_asis
   FROM ldl_p_lew_mart_msi.v_agg_str_day_ejr_kpg_net_asis_2 AS DT_A
   WHERE val_rtl_net <> 0) AS ext
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON ext.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;