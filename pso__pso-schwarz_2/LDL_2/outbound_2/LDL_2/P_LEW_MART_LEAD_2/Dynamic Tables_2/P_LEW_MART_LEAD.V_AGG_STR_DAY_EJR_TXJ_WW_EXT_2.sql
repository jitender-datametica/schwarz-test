CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.v_agg_str_day_ejr_txj_ww_ext_2
AS
SELECT sb.client_id,
 sb.store_id,
 sb.dat_open AS dat_formdate,
   EXTRACT(YEAR FROM e.dat_calendar) * 100 + EXTRACT(MONTH FROM e.dat_calendar) AS cy_month,
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
FROM (SELECT COALESCE(mds.client_id, FS.client_id) AS client_id,
   COALESCE(mds.store_id, FS.store_id) AS store_id,
   COALESCE(mds.dat_open, FS.dat_formdate) AS dat_open,
   mds.dat_open AS dat_open_md_storelist,
   COALESCE(FS.currency_iso_cd, CUR.currency_iso_cd) AS currency_iso_cd,
   FS.cnt_customer_asis,
   FS.val_retail_asis,
   FS.val_retail_net_asis
  FROM (SELECT SL.client_id,
     WH.src_wh_id AS wh_id,
     SL.loc_sid_store AS store_id,
     SL.dat_open
    FROM ldl_p_lew_bil_ac.v_sys_md_storelist_2 AS SL
     INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON SL.loc_sid_wh = WH.loc_sid_wh AND SL.client_id = WH.client_id AND
       WH.dwh_actual_fg = 1) AS mds
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CUR ON mds.client_id = CUR.client_id AND CURRENT_DATE
     BETWEEN CUR.dat_rec_start AND CUR.dat_rec_end
   FULL JOIN ldl_p_lew_mart_lead_ac.v_agg_str_day_ejr_txj_ww_asis_2 AS FS ON mds.dat_open = FS.dat_formdate AND mds.client_id
        = FS.client_id AND mds.store_id = FS.store_id AND CUR.currency_iso_cd = FS.currency_iso_cd
  WHERE (FS.val_retail_asis IS NULL OR FS.val_retail_asis = 0)
   AND (mds.dat_open IS NOT NULL OR mds.dat_open IS NULL AND FS.cnt_customer_asis <> 0)
   AND COALESCE(mds.dat_open, FS.dat_formdate) < CURRENT_DATE) AS sb
 INNER JOIN (SELECT cal_dt AS dat_calendar,
   dat_calendar_extrapol
  FROM ldl_p_lew_bil_ac.v_cal_day_rel_extrapol_2 AS A
  WHERE EXTRACT(YEAR FROM cal_dt) < (SELECT MAX(EXTRACT(YEAR FROM cal_dt)) - 6
     FROM ldl_p_lew_bil_ac.v_cal_day_rel_extrapol_2)) AS e ON sb.dat_open = e.dat_calendar
 LEFT JOIN ldl_p_lew_mart_lead_ac.v_agg_str_day_ejr_txj_ww_asis_2 AS F ON e.dat_calendar_extrapol = F.dat_formdate AND sb
      .client_id = F.client_id AND sb.store_id = F.store_id AND sb.currency_iso_cd = F.currency_iso_cd AND F.dat_formdate
    < CURRENT_DATE
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
FROM ldl_p_lew_mart_lead_ac.v_agg_str_day_ejr_txj_ww_asis_2
WHERE val_retail_asis <> 0
 AND dat_formdate < CURRENT_DATE;
