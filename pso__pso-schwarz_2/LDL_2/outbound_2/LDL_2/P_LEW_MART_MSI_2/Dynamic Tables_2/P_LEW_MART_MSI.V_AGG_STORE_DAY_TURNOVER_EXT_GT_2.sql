CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_agg_store_day_turnover_ext_gt_2 AS
-- Die View greift auf die Basistabelle ReceiptLine zu, es findet jedoch keinerlei Logikveränderung beim Zugriff statt. Zwischen der View und der Receipt Line gibt es aus Performancegründen persisitierte Agg-Tabellen

-- WHERE ejr.subitemgroup_id NOT IN (996, 997)

-- In dieser View werden die e-journal Daten nicht verwendet, daher werden die ejournal Daten über den oberen CROSS JOIN aus der Receipt Line geholt. Über dieses Statement werden die TXJ und WAWI Umsätze selektiert.

-- Hole den Umsatz aus KPGES
 -- Basisergebnis mit Hochrechnungen verknüpfen

-- Take ONLY those records which have 0s OR NULLS IN turnover for this store, client and date

-- Die View greift auf die Basistabelle ReceiptLine zu, es findet jedoch keinerlei Logikveränderung beim Zugriff statt. Zwischen der View und der Receipt Line gibt es aus Performancegründen persisitierte Agg-Tabellen

-- WHERE ejr.subitemgroup_id NOT IN (996, 997)

-- In dieser View werden die e-journal Daten nicht verwendet, daher werden die ejournal Daten über den oberen CROSS JOIN aus der Receipt Line geholt. Über dieses Statement werden die TXJ und WAWI Umsätze selektiert.

-- Hole den Umsatz aus KPGES

-- Hole nur die Stores, die tatsächlich geöffnet waren. Anschließend wird Orig_Store_nr rangejoint, um einen Bezug zu Wawi herzustellen

-- Wenn in KPGES kein Information über die Öffnung eines Stores zu finden ist (val_indicator = NULL), dann nehme Information aus MD-Storelist --> !!BIL Layer!!

SELECT basis.client_id AS client_id,
 basis.orig_store_nr AS orig_store_nr,
 basis.dat_formdate AS dat_formdate,
 basis.currency_iso_cd AS currency_iso_cd,
 basis.store_id AS store_id,
 basis.cy_month AS cy_month,
 basis.cnt_customer AS cnt_customer,
 basis.val_rtl AS val_rtl,
 basis.val_rtl_net AS val_rtl_net,
 COALESCE(basis.val_rtl_extrapol, ext.val_rtl_extrapol) AS val_rtl_extrapol,
 COALESCE(basis.val_rtl_net_extrapol, ext.val_rtl_net_extrapol) AS val_rtl_net_extrapol,
 basis.val_rtl_kpges AS val_rtl_kpges,
 basis.val_rtl_net_kpges AS val_rtl_net_kpges,
 basis.val_rtl_wawi AS val_rtl_wawi,
 basis.val_rtl_net_wawi AS val_rtl_net_wawi,
 basis.val_rtl_txj AS val_rtl_txj,
 basis.val_rtl_net_txj AS val_rtl_net_txj,
 basis.val_rtl_ejr AS val_rtl_ejr,
 basis.val_rtl_net_ejr AS val_rtl_net_ejr
FROM (SELECT COALESCE(kpges.client_id, ewa.client_id) AS client_id,
   COALESCE(kpges.orig_store_nr, ewa.orig_store_nr, 0) AS orig_store_nr,
   COALESCE(kpges.dat_formdate, ewa.dat_formdate) AS dat_formdate,
   COALESCE(kpges.currency_iso_cd, ewa.currency_iso_cd) AS currency_iso_cd,
   COALESCE(kpges.store_id, ewa.store_id) AS store_id,
     EXTRACT(YEAR FROM COALESCE(kpges.dat_formdate, ewa.dat_formdate)) * 100 + EXTRACT(MONTH FROM COALESCE(kpges.dat_formdate
      , ewa.dat_formdate)) AS cy_month,
   ewa.cnt_customer,
   COALESCE(kpges.val_rtl_kpges, ewa.val_rtl_wawi, ewa.val_rtl_txj, ewa.val_rtl_ejr, 0) AS val_rtl,
   COALESCE(kpges.val_rtl_net_kpges, ewa.val_rtl_net_wawi, ewa.val_rtl_net_txj, ewa.val_rtl_net_ejr, 0) AS val_rtl_net,
   COALESCE(kpges.val_rtl_kpges, ewa.val_rtl_wawi, ewa.val_rtl_txj, ewa.val_rtl_ejr, 0) AS val_rtl_extrapol,
   COALESCE(kpges.val_rtl_net_kpges, ewa.val_rtl_net_wawi, ewa.val_rtl_net_txj, ewa.val_rtl_net_ejr, 0) AS
   val_rtl_net_extrapol,
   kpges.val_rtl_kpges,
   kpges.val_rtl_net_kpges,
   ewa.val_rtl_wawi,
   ewa.val_rtl_net_wawi,
   ewa.val_rtl_txj,
   ewa.val_rtl_net_txj,
   ewa.val_rtl_ejr,
   ewa.val_rtl_net_ejr
  FROM (SELECT COALESCE(wawi.client_id, ejr1.client_id) AS client_id,
     COALESCE(wawi.store_id, ejr1.store_id) AS store_id,
     COALESCE(wawi.orig_store_nr, ejr1.orig_store_nr) AS orig_store_nr,
     COALESCE(wawi.dat_formdate, ejr1.dat_formdate) AS dat_formdate,
     COALESCE(wawi.currency_iso_cd, ejr1.currency_iso_cd) AS currency_iso_cd,
     wawi.cnt_customer,
     wawi.val_rtl_wawi,
     wawi.val_rtl_net_wawi,
     wawi.val_rtl_txj,
     wawi.val_rtl_net_txj,
     ejr1.val_rtl_ejr,
     ejr1.val_rtl_net_ejr
    FROM (SELECT client_id,
       dat_formdate,
       orig_store_nr,
       store_id,
       currency_iso_cd,
       SUM(val_rtl_ejr_asis + val_return_ejr_asis) AS val_rtl_ejr,
       SUM(val_rtl_net_ejr_asis + val_return_net_ejr_asis) AS val_rtl_net_ejr
      FROM ldl_p_lew_mart_msi.v_agg_store_day_sig_ejr_asis_2 AS EJR
      GROUP BY client_id,
       dat_formdate,
       orig_store_nr,
       store_id,
       currency_iso_cd) AS ejr1
     FULL JOIN (SELECT client_id,
       dat_formdate,
       orig_store_nr,
       store_id,
       currency_iso_cd,
       SUM(cnt_customer_asis) AS cnt_customer,
       SUM(val_retail_wawi_asis) AS val_rtl_wawi,
       SUM(val_retail_net_wawi_asis) AS val_rtl_net_wawi,
       SUM(val_retail_txj_asis) AS val_rtl_txj,
       SUM(val_retail_net_txj_asis) AS val_rtl_net_txj
      FROM ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis_2 AS AGG
      GROUP BY client_id,
       dat_formdate,
       orig_store_nr,
       store_id,
       currency_iso_cd) AS wawi ON ejr1.client_id = wawi.client_id AND ejr1.store_id = wawi.store_id AND ejr1.dat_formdate
         = wawi.dat_formdate AND ejr1.currency_iso_cd = wawi.currency_iso_cd) AS ewa
   FULL JOIN (SELECT IND.client_id,
     IND.org_unit_nr AS orig_store_nr,
     STORE.store_id,
     IND.dat_formdate,
     CURR.curr_cd_from AS currency_iso_cd,
     SUM(CASE
       WHEN IND.indicator_id = 158
       THEN IND.val_indicator / CURR.exchange_rate
       ELSE NULL
       END) AS val_rtl_kpges,
     SUM(CASE
       WHEN IND.indicator_id = 157
       THEN IND.val_indicator / CURR.exchange_rate
       ELSE NULL
       END) AS val_rtl_net_kpges
    FROM ldl_p_lew_mart_msi.v_indicator_day_2 AS IND
     INNER JOIN ldl_p_lew_mart_msi.v_org_store_merge_2 AS STORE ON IND.client_id = STORE.client_id AND IND.org_unit_nr =
       STORE.orig_store_nr
     INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CURR ON IND.client_id = CURR.client_id AND CURRENT_DATE
        BETWEEN CURR.active_from_dt AND CURR.active_to_dt AND CURRENT_DATE BETWEEN CURR.dwh_valid_from AND CURR.dwh_valid_to
       
     INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CURR_TYPE ON CURR.client_id = CURR_TYPE.client_id AND CURR.x_rate_type_sid
         = CURR_TYPE.x_rate_type_sid AND CURR_TYPE.src_kurst = '@BEWE'
    WHERE IND.org_type_id = 90 -- Filiale

     AND IND.indicator_type_id = 1 -- Laufendes Jahr

     AND IND.indicator_id IN (157, 158) -- 157: Umsatz Netto in Landeswährung, 158: Umsatz Brutto in Landeswährung

     AND STORE.aspect_id = 1 -- Betriebsgesellschaft

    GROUP BY IND.client_id,
     orig_store_nr,
     STORE.store_id,
     IND.dat_formdate,
     currency_iso_cd) AS kpges ON ewa.client_id = kpges.client_id AND ewa.client_id = kpges.store_id AND ewa.dat_formdate
       = kpges.dat_formdate AND ewa.currency_iso_cd = kpges.currency_iso_cd) AS basis
 FULL JOIN (SELECT sb.client_id,
   sb.orig_store_nr,
   sb.dat_open AS dat_formdate,
   sb.curr_cd_from,
   sb.store_id,
     EXTRACT(YEAR FROM E.dat_calendar) * 100 + EXTRACT(MONTH FROM E.dat_calendar) AS cy_month,
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
    END AS val_rtl_net_extrapol
  FROM (SELECT COALESCE(t22.client_id, fs.client_id) AS client_id,
     COALESCE(t22.store_id, fs.store_id) AS store_id,
     COALESCE(t22.orig_store_nr, fs.orig_store_nr) AS orig_store_nr,
     COALESCE(t22.dat_open, fs.dat_formdate) AS dat_open,
     t22.dat_open AS dat_open_md_storelist,
     fs.cnt_customer,
     COALESCE(t22.curr_cd_from, fs.currency_iso_cd) AS curr_cd_from,
     fs.val_rtl,
     fs.val_rtl_net,
     fs.val_rtl_kpges,
     fs.val_rtl_net_kpges,
     fs.val_rtl_wawi,
     fs.val_rtl_net_wawi,
     fs.val_rtl_txj,
     fs.val_rtl_net_txj,
     fs.val_rtl_ejr,
     fs.val_rtl_net_ejr -- Subselect aus erster Query

    FROM (SELECT COALESCE(kpges.client_id, ewa.client_id) AS client_id,
       COALESCE(kpges.orig_store_nr, ewa.orig_store_nr, 0) AS orig_store_nr,
       COALESCE(kpges.dat_formdate, ewa.dat_formdate) AS dat_formdate,
       COALESCE(kpges.currency_iso_cd, ewa.currency_iso_cd) AS currency_iso_cd,
       COALESCE(kpges.store_id, ewa.store_id) AS store_id,
         EXTRACT(YEAR FROM COALESCE(kpges.dat_formdate, ewa.dat_formdate)) * 100 + EXTRACT(MONTH FROM COALESCE(kpges.dat_formdate
          , ewa.dat_formdate)) AS cy_month,
       ewa.cnt_customer,
       COALESCE(kpges.val_rtl_kpges, ewa.val_rtl_wawi, ewa.val_rtl_txj, ewa.val_rtl_ejr, 0) AS val_rtl,
       COALESCE(kpges.val_rtl_net_kpges, ewa.val_rtl_net_wawi, ewa.val_rtl_net_txj, ewa.val_rtl_net_ejr, 0) AS
       val_rtl_net,
       COALESCE(kpges.val_rtl_kpges, ewa.val_rtl_wawi, ewa.val_rtl_txj, ewa.val_rtl_ejr, 0) AS val_rtl_extrapol,
       COALESCE(kpges.val_rtl_net_kpges, ewa.val_rtl_net_wawi, ewa.val_rtl_net_txj, ewa.val_rtl_net_ejr, 0) AS
       val_rtl_net_extrapol,
       kpges.val_rtl_kpges,
       kpges.val_rtl_net_kpges,
       ewa.val_rtl_wawi,
       ewa.val_rtl_net_wawi,
       ewa.val_rtl_txj,
       ewa.val_rtl_net_txj,
       ewa.val_rtl_ejr,
       ewa.val_rtl_net_ejr
      FROM (SELECT COALESCE(wawi.client_id, ejr1.client_id) AS client_id,
         COALESCE(wawi.store_id, ejr1.store_id) AS store_id,
         COALESCE(wawi.orig_store_nr, ejr1.orig_store_nr) AS orig_store_nr,
         COALESCE(wawi.dat_formdate, ejr1.dat_formdate) AS dat_formdate,
         COALESCE(wawi.currency_iso_cd, ejr1.currency_iso_cd) AS currency_iso_cd,
         wawi.cnt_customer,
         wawi.val_rtl_wawi,
         wawi.val_rtl_net_wawi,
         wawi.val_rtl_txj,
         wawi.val_rtl_net_txj,
         ejr1.val_rtl_ejr,
         ejr1.val_rtl_net_ejr
        FROM (SELECT client_id,
           dat_formdate,
           orig_store_nr,
           store_id,
           currency_iso_cd,
           SUM(val_rtl_ejr_asis + val_return_ejr_asis) AS val_rtl_ejr,
           SUM(val_rtl_net_ejr_asis + val_return_net_ejr_asis) AS val_rtl_net_ejr
          FROM ldl_p_lew_mart_msi.v_agg_store_day_sig_ejr_asis_2 AS EJR
          GROUP BY client_id,
           dat_formdate,
           orig_store_nr,
           store_id,
           currency_iso_cd) AS ejr1
         FULL JOIN (SELECT client_id,
           dat_formdate,
           orig_store_nr,
           store_id,
           currency_iso_cd,
           SUM(cnt_customer_asis) AS cnt_customer,
           SUM(val_retail_wawi_asis) AS val_rtl_wawi,
           SUM(val_retail_net_wawi_asis) AS val_rtl_net_wawi,
           SUM(val_retail_txj_asis) AS val_rtl_txj,
           SUM(val_retail_net_txj_asis) AS val_rtl_net_txj
          FROM ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis_2 AS AGG
          GROUP BY client_id,
           dat_formdate,
           orig_store_nr,
           store_id,
           currency_iso_cd) AS wawi ON ejr1.client_id = wawi.client_id AND ejr1.store_id = wawi.store_id AND ejr1.dat_formdate
             = wawi.dat_formdate AND ejr1.currency_iso_cd = wawi.currency_iso_cd) AS ewa
       FULL JOIN (SELECT IND0.client_id,
         IND0.org_unit_nr AS orig_store_nr,
         STORE0.store_id,
         IND0.dat_formdate,
         CURR0.curr_cd_from AS currency_iso_cd,
         SUM(CASE
           WHEN IND0.indicator_id = 158
           THEN IND0.val_indicator / CURR0.exchange_rate
           ELSE NULL
           END) AS val_rtl_kpges,
         SUM(CASE
           WHEN IND0.indicator_id = 157
           THEN IND0.val_indicator / CURR0.exchange_rate
           ELSE NULL
           END) AS val_rtl_net_kpges
        FROM ldl_p_lew_mart_msi.v_indicator_day_2 AS IND0
         INNER JOIN ldl_p_lew_mart_msi.v_org_store_merge_2 AS STORE0 ON IND0.client_id = STORE0.client_id AND IND0.org_unit_nr
            = STORE0.orig_store_nr
         INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CURR0 ON IND0.client_id = CURR0.client_id AND
            CURRENT_DATE BETWEEN CURR0.active_from_dt AND CURR0.active_to_dt AND CURRENT_DATE BETWEEN CURR0.dwh_valid_from
           AND CURR0.dwh_valid_to
         INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CURR_TYPE0 ON CURR0.client_id = CURR_TYPE0.client_id AND
            CURR0.x_rate_type_sid = CURR_TYPE0.x_rate_type_sid AND CURR_TYPE0.src_kurst = '@BEWE'
        WHERE IND0.org_type_id = 90 -- Filiale

         AND IND0.indicator_type_id = 1 -- Laufendes Jahr

         AND IND0.indicator_id IN (157, 158) -- 157: Umsatz Netto in Landeswährung, 158: Umsatz Brutto in Landeswährung

         AND STORE0.aspect_id = 1 -- Betriebsgesellschaft

        GROUP BY IND0.client_id,
         orig_store_nr,
         STORE0.store_id,
         IND0.dat_formdate,
         currency_iso_cd) AS kpges ON ewa.client_id = kpges.client_id AND ewa.client_id = kpges.store_id AND ewa.dat_formdate
           = kpges.dat_formdate AND ewa.currency_iso_cd = kpges.currency_iso_cd) AS fs
     FULL JOIN (SELECT MDS.client_id,
       MDS.wh_id,
       MDS.store_id,
       MDS.dat_open,
       CURR1.curr_cd_from,
       SKEY.orig_store_nr
      FROM ldl_p_lew_mart_msi.v_sys_md_storelist_2 AS MDS
       INNER JOIN ldl_p_lew_mart_msi.v_org_store_skey_2 AS SKEY ON MDS.client_id = SKEY.client_id AND MDS.store_id = SKEY
         .store_id
       INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CURR1 ON MDS.client_id = CURR1.client_id AND
          CURRENT_DATE BETWEEN CURR1.active_from_dt AND CURR1.active_to_dt AND CURRENT_DATE BETWEEN CURR1.dwh_valid_from
         AND CURR1.dwh_valid_to
       INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CURR_TYPE1 ON CURR1.client_id = CURR_TYPE1.client_id AND
          CURR1.x_rate_type_sid = CURR_TYPE1.x_rate_type_sid AND CURR_TYPE1.src_kurst = '@BEWE'
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(MDS.client_id AS STRING), CAST(MDS.store_id AS STRING), MDS.dat_open
            , CURR1.curr_cd_from ORDER BY SKEY.orig_store_nr IS NULL, SKEY.orig_store_nr)) = 1) AS t22 ON fs.dat_formdate
          = t22.dat_open AND fs.client_id = t22.client_id AND fs.orig_store_nr = t22.orig_store_nr AND fs.currency_iso_cd
       /* # 
# Only records which have 0s OR NULLS IN turnover FOR this store, client and date
# stores with a valid dat_open have to be selected and stores with only
# filled cnt_customer
# val_rtl_net column will be driving column for extrapolation
# */
       = t22.curr_cd_from
    WHERE (fs.val_rtl_net IS NULL OR fs.val_rtl_net = 0)
     AND (t22.dat_open IS NOT NULL OR t22.dat_open IS NULL AND fs.cnt_customer <> 0)
     AND COALESCE(t22.dat_open, fs.dat_formdate) < CURRENT_DATE) AS sb
   INNER JOIN ldl_p_lew_mart_msi.v_cal_day_rel_extrapol_2 AS E ON sb.dat_open = E.dat_calendar
   LEFT JOIN (SELECT client_id,
     orig_store_nr,
     dat_formdate,
     currency_iso_cd,
     store_id,
     cy_month,
     cnt_customer,
     val_rtl,
     val_rtl_net
    FROM ldl_p_lew_mart_msi.t_agg_store_turnover_ext_2
    WHERE dat_formdate < CURRENT_DATE) AS f ON E.dat_calendar_extrapol = f.dat_formdate AND sb.client_id = f.client_id
     AND sb.orig_store_nr = f.orig_store_nr AND sb.curr_cd_from = f.currency_iso_cd
  GROUP BY sb.client_id,
   sb.orig_store_nr,
   dat_formdate,
   sb.curr_cd_from,
   sb.store_id,
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
   sb.val_rtl_net_ejr) AS ext ON basis.client_id = ext.client_id AND basis.dat_formdate = ext.dat_formdate AND basis.orig_store_nr
      = ext.orig_store_nr AND basis.store_id = ext.store_id AND basis.currency_iso_cd = ext.curr_cd_from;
