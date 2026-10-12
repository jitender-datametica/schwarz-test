-- Part 1 - Data with no turnover (no customers) => turnover and customers will be extrapolated -- Wieso gibt es Umsätze, die 0 sind, obwohl Store offen hatte?

CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_store_day_turnover_ext (client_id, src_orig_store_nr, dat_formdate,
currency_iso_cd, loc_sid_store, cy_month, cnt_customer, cnt_customer_extrapol, val_rtl, val_rtl_net, val_rtl_extrapol,
val_rtl_net_extrapol, val_rtl_kpges, val_rtl_net_kpges, val_rtl_wawi, val_rtl_net_wawi, val_rtl_txj, val_rtl_net_txj,
val_rtl_ejr, val_rtl_net_ejr) AS -- Basisergebnis mit Hochrechnungen verknüpfen

-- Take ONLY those records which have 0s OR NULLS IN turnover for this store, client AND date

-- Hole nur die Stores, die tatsächlich geöffnet waren. Anschließend wird src_orig_store_nr rangejoint, um einen Bezug zu Wawi herzustellen

-- Wenn in KPGES kein Information über die Öffnung eines Stores zu finden ist (val_indicator = NULL), dann nehme Information aus MD-Storelist --> !!BIL Layer!!

SELECT COALESCE(BASIS.client_id, ext.client_id) AS client_id,
 COALESCE(BASIS.src_orig_store_nr, ext.src_orig_store_nr) AS src_orig_store_nr,
 COALESCE(BASIS.dat_formdate, ext.dat_formdate) AS dat_formdate,
 COALESCE(BASIS.currency_iso_cd, ext.curr_cd_from) AS currency_iso_cd,
 COALESCE(BASIS.loc_sid_store, ext.loc_sid_store) AS loc_sid_store,
 COALESCE(BASIS.cy_month, ext.cy_month) AS cy_month,
 COALESCE(BASIS.cnt_customer, ext.cnt_customer) AS cnt_customer,
  CASE
  WHEN (BASIS.cnt_customer IS NULL OR BASIS.cnt_customer = 0) AND ext.client_id IS NOT NULL
  THEN IFNULL(ext.cnt_customer_extrapol, 0)
  ELSE CAST(IFNULL(BASIS.cnt_customer, 0) AS FLOAT64)
  END AS cnt_customer_extrapol,
 BASIS.val_rtl,
 BASIS.val_rtl_net,
  CASE
  WHEN (BASIS.val_rtl_net IS NULL OR BASIS.val_rtl_net = 0) AND ext.client_id IS NOT NULL
  THEN IFNULL(ext.val_rtl_extrapol, 0)
  ELSE CAST(IFNULL(BASIS.val_rtl, 0) AS FLOAT64)
  END AS val_rtl_extrapol,
  CASE
  WHEN (BASIS.val_rtl_net IS NULL OR BASIS.val_rtl_net = 0) AND ext.client_id IS NOT NULL
  THEN IFNULL(ext.val_rtl_net_extrapol, 0)
  ELSE CAST(IFNULL(BASIS.val_rtl_net, 0) AS FLOAT64)
  END AS val_rtl_net_extrapol,
 BASIS.val_rtl_kpges,
 BASIS.val_rtl_net_kpges,
 BASIS.val_rtl_wawi,
 BASIS.val_rtl_net_wawi,
 BASIS.val_rtl_txj,
 BASIS.val_rtl_net_txj,
 BASIS.val_rtl_ejr,
 BASIS.val_rtl_net_ejr
FROM ldl_p_lew_bil.v_agg_store_day_turnover_base AS BASIS
 FULL JOIN (SELECT sb.client_id,
   sb.src_orig_store_nr,
   sb.dat_open AS dat_formdate,
   sb.curr_cd_from,
   sb.loc_sid_store,
     EXTRACT(YEAR FROM E.cal_dt) * 100 + EXTRACT(MONTH FROM E.cal_dt) AS cy_month,
   sb.cnt_customer,
   sb.val_rtl,
   sb.val_rtl_net,
   sb.val_rtl_kpges,
   sb.val_rtl_net_kpges,
   sb.val_rtl_wawi,
   sb.val_rtl_net_wawi,
   sb.val_rtl_txj,
   sb.val_rtl_net_txj,
   sb.val_rtl_ejr,
   sb.val_rtl_net_ejr,
    CASE
    WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL
    THEN AVG(CASE
      WHEN f.val_rtl = 0
      THEN NULL
      ELSE f.val_rtl
      END)
    ELSE NULL
    END AS val_rtl_extrapol,
    CASE
    WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL
    THEN AVG(CASE
      WHEN f.val_rtl_net = 0
      THEN NULL
      ELSE f.val_rtl_net
      END)
    ELSE NULL
    END AS val_rtl_net_extrapol,
    CASE
    WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL
    THEN AVG(CASE
      WHEN f.cnt_customer = 0
      THEN NULL
      ELSE f.cnt_customer
      END)
    ELSE NULL
    END AS cnt_customer_extrapol
  FROM (SELECT COALESCE(t0.client_id, FS.client_id) AS client_id,
     COALESCE(t0.loc_sid_store, FS.loc_sid_store) AS loc_sid_store,
     COALESCE(t0.src_orig_store_nr, FS.src_orig_store_nr) AS src_orig_store_nr,
     COALESCE(t0.dat_open, FS.dat_formdate) AS dat_open,
     t0.dat_open AS dat_open_md_storelist,
     FS.cnt_customer,
     COALESCE(t0.curr_cd_from, FS.currency_iso_cd) AS curr_cd_from,
     FS.val_rtl,
     FS.val_rtl_net,
     FS.val_rtl_kpges,
     FS.val_rtl_net_kpges,
     FS.val_rtl_wawi,
     FS.val_rtl_net_wawi,
     FS.val_rtl_txj,
     FS.val_rtl_net_txj,
     FS.val_rtl_ejr,
     FS.val_rtl_net_ejr -- Sublect aus erster Query

    FROM ldl_p_lew_bil.v_agg_store_day_turnover_base AS FS
     FULL JOIN (SELECT MDS.client_id,
       MDS.loc_sid_wh,
       MDS.loc_sid_store,
       MDS.dat_open,
       MDS.kpges_fg,
       CURR.curr_cd_from,
       SKEY.src_orig_store_nr
      FROM ldl_p_lew_bil.v_sys_md_storelist AS MDS
       INNER JOIN ldl_p_lew_core_ac.v_location AS SKEY ON MDS.client_id = SKEY.client_id AND MDS.loc_sid_store = SKEY.loc_sid
         
       INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CURR ON MDS.client_id = CURR.client_id AND
          CURRENT_DATE BETWEEN CURR.active_from_dt AND CURR.active_to_dt AND CURRENT_DATE BETWEEN CURR.dwh_valid_from
         AND CURR.dwh_valid_to
       INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS CURR_TYPE ON CURR.client_id = CURR_TYPE.client_id AND CURR.x_rate_type_sid
           = CURR_TYPE.x_rate_type_sid AND CURR_TYPE.src_kurst = '@BEWE'
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(MDS.client_id AS STRING), CAST(MDS.loc_sid_store AS STRING), MDS.dat_open
            , CURR.curr_cd_from ORDER BY SKEY.src_orig_store_nr IS NULL, SKEY.src_orig_store_nr)) = 1) AS t0 ON FS.dat_formdate
          = t0.dat_open AND FS.client_id = t0.client_id AND FS.src_orig_store_nr = t0.src_orig_store_nr AND FS.currency_iso_cd
       /* #   
            # Only records which have 0s OR NULLS IN turnover FOR this store, client AND date   
            # stores with a valid dat_open have to be selected AND stores with only 
            # filled cnt_customer   
            # val_rtl_net column will be driving column for extrapolation   
            # */
       = t0.curr_cd_from
    WHERE (FS.val_rtl_net IS NULL OR FS.val_rtl_net = 0)
     AND (t0.dat_open IS NOT NULL OR t0.dat_open IS NULL AND FS.cnt_customer <> 0)
     AND COALESCE(t0.dat_open, FS.dat_formdate) < CURRENT_DATE) AS sb
   INNER JOIN ldl_p_lew_bil.v_cal_day_rel_extrapol AS E ON sb.dat_open = E.cal_dt
   LEFT JOIN (SELECT client_id,
     src_orig_store_nr,
     dat_formdate,
     currency_iso_cd,
     loc_sid_store,
     cy_month,
     cnt_customer,
     val_rtl,
     val_rtl_net
    FROM ldl_p_lew_bil.v_agg_store_day_turnover_base
    WHERE dat_formdate < CURRENT_DATE) AS f ON E.dat_calendar_extrapol = f.dat_formdate AND sb.client_id = f.client_id
     AND sb.src_orig_store_nr = f.src_orig_store_nr AND sb.curr_cd_from = f.currency_iso_cd
  GROUP BY sb.client_id,
   sb.src_orig_store_nr,
   dat_formdate,
   sb.curr_cd_from,
   sb.loc_sid_store,
   cy_month,
   sb.cnt_customer,
   sb.val_rtl,
   sb.val_rtl_net,
   sb.val_rtl_kpges,
   sb.val_rtl_net_kpges,
   sb.val_rtl_wawi,
   sb.val_rtl_net_wawi,
   sb.val_rtl_txj,
   sb.val_rtl_net_txj,
   sb.val_rtl_ejr,
   sb.val_rtl_net_ejr) AS ext ON BASIS.client_id = ext.client_id AND BASIS.dat_formdate = ext.dat_formdate AND BASIS.src_orig_store_nr
      = ext.src_orig_store_nr AND BASIS.loc_sid_store = ext.loc_sid_store AND BASIS.currency_iso_cd = ext.curr_cd_from;