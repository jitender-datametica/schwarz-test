/* That UNION provides the full aggregation view with all turnover values or	
   extrapolated values (if calculated) in the extrapol column. */
/* Part 2 - Data with turnover => just select the turnover	
   Unite with all other rows from fact table, which have turnover values and needed no	
   additional calculation. */
/* DescStart	
   $Revision: 12355 $, $LastChangedBy: tkhusainov $	
   SubjectAreas: KPGES Views	
   DescEnd */
/* take all those rows that were NOT used for extrapolation */
/* stores with a valid dat_open have to be selected and stores with only filled cnt_customer_asis */
/* take only those records which have 0s or NULLs in turnover for this store, client and date */
-- Part 1 - Data with no turnover => turnover will be extrapolated

CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_agg_str_day_ejr_txj_ww_ext_1 AS SELECT sb.client_id,
 sb.store_id,
 sb.dat_open AS dat_formdate,
   EXTRACT(YEAR FROM E.dat_calendar) * 100 + EXTRACT(MONTH FROM E.dat_calendar) AS cy_month,
 sb.currency_iso_cd,
 sb.val_retail_asis,
 sb.val_retail_net_asis,
 sb.cnt_customer_asis,
  CASE
  WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL
  THEN AVG(CASE
    WHEN F.val_retail_asis = 0
    THEN NULL
    ELSE F.val_retail_asis
    END)
  ELSE NULL
  END AS val_retail_extrapol_asis,
  CASE
  WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL
  THEN AVG(CASE
    WHEN F.val_retail_net_asis = 0
    THEN NULL
    ELSE F.val_retail_net_asis
    END)
  ELSE NULL
  END AS val_retail_net_extrapol_asis
FROM (SELECT COALESCE(MDS.client_id, FS.client_id) AS client_id,
   COALESCE(MDS.store_id, FS.store_id) AS store_id,
   COALESCE(MDS.dat_open, FS.dat_formdate) AS dat_open,
   MDS.dat_open AS dat_open_md_storelist,
   COALESCE(FS.currency_iso_cd, CUR.currency_iso_cd) AS currency_iso_cd,
   FS.cnt_customer_asis,
   FS.val_retail_asis,
   FS.val_retail_net_asis
  FROM ldl_p_lew_mart_msi.v_sys_md_storelist_1 AS MDS
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CUR ON MDS.client_id = CUR.client_id AND CURRENT_DATE
     BETWEEN CUR.dat_rec_start AND CUR.dat_rec_end
   FULL JOIN ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis_1 AS FS ON MDS.dat_open = FS.dat_formdate AND MDS.client_id
       = FS.client_id AND MDS.store_id = FS.store_id AND CUR.currency_iso_cd = FS.currency_iso_cd
  WHERE (FS.val_retail_asis IS NULL OR FS.val_retail_asis = 0)
   AND (MDS.dat_open IS NOT NULL OR MDS.dat_open IS NULL AND FS.cnt_customer_asis <> 0)
   AND COALESCE(MDS.dat_open, FS.dat_formdate) < CURRENT_DATE) AS sb
 INNER JOIN ldl_p_lew_mart_msi.v_cal_day_rel_extrapol_1 AS E ON sb.dat_open = E.dat_calendar
 LEFT JOIN ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis_1 AS F ON E.dat_calendar_extrapol = F.dat_formdate AND sb.client_id
       = F.client_id AND sb.store_id = F.store_id AND sb.currency_iso_cd = F.currency_iso_cd AND F.dat_formdate <
   CURRENT_DATE
   /* the source table v_agg_str_day_ejr_txj_ww ensures the key (client_id, store_id, dat_formdate).	
   That means, grouping the fields cnt_customer_asis and val_retail_asis is practicable. */
   
GROUP BY sb.client_id,
 sb.store_id,
 dat_formdate,
 cy_month,
 sb.currency_iso_cd,
 sb.val_retail_asis,
 sb.val_retail_net_asis,
 sb.cnt_customer_asis
UNION DISTINCT
SELECT client_id,
 store_id,
 dat_formdate,
 cy_month,
 currency_iso_cd,
 val_retail_asis,
 val_retail_net_asis,
 cnt_customer_asis,
 val_retail_asis AS val_retail_extrapol_asis,
 val_retail_net_asis AS val_retail_net_extrapol_asis
FROM ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis_1
WHERE val_retail_asis <> 0
 AND dat_formdate < CURRENT_DATE;