/* #DescStart#
#$Revision: 9023 $, $LastChangedBy: mueding $
#SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_store_day_turnover_base_1 (client_id, src_orig_store_nr, dat_formdate,
currency_iso_cd, loc_sid_store, cy_month, cnt_customer, val_rtl, val_rtl_net, val_rtl_extrapol, val_rtl_net_extrapol,
val_rtl_kpges, val_rtl_net_kpges, val_rtl_wawi, val_rtl_net_wawi, val_rtl_txj, val_rtl_net_txj, val_rtl_ejr,
val_rtl_net_ejr) AS
-- Die View greift auf die Basistabelle ReceiptLine zu, es findet jedoch keinerlei Logikveränderung beim Zugriff statt. Zwischen der View und der Receipt Line gibt es aus Performancegründen persisitierte Agg-Tabellen

-- In dieser View werden die e-journal Daten nicht verwendet, daher werden die ejournal Daten über den oberen CROSS JOIN aus der Receipt Line geholt. Über dieses Statement werden die TXJ und WAWI Umsätze selektiert.

-- Hole den Umsatz aus KPGES
 SELECT COALESCE(kpges.client_id, ewa.client_id) AS client_id,
 COALESCE(kpges.src_orig_store_nr, ewa.src_orig_store_nr, 0) AS src_orig_store_nr,
 COALESCE(kpges.dat_formdate, ewa.dat_formdate) AS dat_formdate,
 COALESCE(kpges.currency_iso_cd, ewa.currency_iso_cd) AS currency_iso_cd,
 COALESCE(kpges.loc_sid_store, ewa.loc_sid_store) AS loc_sid_store,
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
   COALESCE(wawi.loc_sid_store, ejr1.loc_sid_store) AS loc_sid_store,
   COALESCE(wawi.src_orig_store_nr, ejr1.src_orig_store_nr) AS src_orig_store_nr,
   COALESCE(wawi.dat_formdate, ejr1.dat_formdate) AS dat_formdate,
   COALESCE(wawi.currency_iso_cd, ejr1.currency_iso_cd) AS currency_iso_cd,
   wawi.cnt_customer,
   wawi.val_rtl_wawi,
   wawi.val_rtl_net_wawi,
   wawi.val_rtl_txj,
   wawi.val_rtl_net_txj,
   ejr1.val_rtl_ejr,
   ejr1.val_rtl_net_ejr
  FROM (SELECT EJR.client_id,
     EJR.dwh_cal_dt AS dat_formdate,
     LOCN.src_orig_store_nr,
     EJR.loc_sid_store,
     CURR.curr_cd_from AS currency_iso_cd,
     SUM((EJR.sales_gross_val + EJR.return_gross_val) / CASE
        WHEN CURR.exchange_rate = 0
        THEN NULL
        ELSE CURR.exchange_rate
        END) AS val_rtl_ejr,
     SUM((EJR.sales_net_val + EJR.return_net_val) / CASE
        WHEN CURR.exchange_rate = 0
        THEN NULL
        ELSE CURR.exchange_rate
        END) AS val_rtl_net_ejr
    FROM ldl_p_lew_bil.t_agg_pos_store_day_sig_asis_1 AS EJR
     INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOCN ON EJR.client_id = LOCN.client_id AND EJR.loc_sid_store = LOCN.loc_sid
       
     INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CURR ON EJR.client_id = CURR.client_id AND CURRENT_DATE
        BETWEEN CURR.active_from_dt AND CURR.active_to_dt AND CURRENT_DATE BETWEEN CURR.dwh_valid_from AND CURR.dwh_valid_to
       
     INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS CURR_TYPE ON CURR.client_id = CURR_TYPE.client_id AND CURR.x_rate_type_sid
         = CURR_TYPE.x_rate_type_sid AND CURR_TYPE.src_kurst = '@BEWE'
       -- where       Ejr.subitemgroup_id not in (996, 997)

    GROUP BY EJR.client_id,
     dat_formdate,
     LOCN.src_orig_store_nr,
     EJR.loc_sid_store,
     currency_iso_cd -- ,                   Curr.exchange_rate
) AS ejr1
   FULL JOIN (SELECT client_id,
     dat_formdate,
     src_orig_store_nr,
     loc_sid_store,
     currency_iso_cd,
     SUM(cnt_customer_asis) AS cnt_customer,
     SUM(val_retail_wawi_asis) AS val_rtl_wawi,
     SUM(val_retail_net_wawi_asis) AS val_rtl_net_wawi,
     SUM(val_retail_txj_asis) AS val_rtl_txj,
     SUM(val_retail_net_txj_asis) AS val_rtl_net_txj
    FROM ldl_p_lew_bil.v_agg_str_day_ejr_txj_ww_asis_1 AS AGG
    GROUP BY client_id,
     dat_formdate,
     src_orig_store_nr,
     loc_sid_store,
     currency_iso_cd) AS wawi ON ejr1.client_id = wawi.client_id AND ejr1.loc_sid_store = wawi.loc_sid_store AND ejr1.dat_formdate
       = wawi.dat_formdate AND ejr1.currency_iso_cd = wawi.currency_iso_cd) AS ewa
 FULL JOIN (SELECT IND.client_id,
   IND.org_unit_nr AS src_orig_store_nr,
   STORE.loc_sid_store,
   IND.dat_formdate,
   CURR0.curr_cd_from AS currency_iso_cd,
   SUM(CASE
     WHEN IND.indicator_id = 158
     THEN IND.val_indicator / CURR0.exchange_rate
     ELSE NULL
     END) AS val_rtl_kpges,
   SUM(CASE
     WHEN IND.indicator_id = 157
     THEN IND.val_indicator / CURR0.exchange_rate
     ELSE NULL
     END) AS val_rtl_net_kpges
  FROM ldl_p_lew_bil.v_indicator_day_1 AS IND
   INNER JOIN ldl_p_lew_bil.v_org_store_merge_1 AS STORE ON IND.client_id = STORE.client_id AND IND.org_unit_nr = STORE.src_orig_store_nr
     
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CURR0 ON IND.client_id = CURR0.client_id AND CURRENT_DATE
      BETWEEN CURR0.active_from_dt AND CURR0.active_to_dt AND CURRENT_DATE BETWEEN CURR0.dwh_valid_from AND CURR0.dwh_valid_to
     
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS CURR_TYPE0 ON CURR0.client_id = CURR_TYPE0.client_id AND CURR0.x_rate_type_sid
       = CURR_TYPE0.x_rate_type_sid AND CURR_TYPE0.src_kurst = '@BEWE'
  WHERE IND.org_type_id = 90 -- Filiale

   AND IND.indicator_type_id = 1 -- Laufendes Jahr

   AND IND.indicator_id IN (157, 158) -- 157: Umsatz Netto in Landeswährung, 158: Umsatz Brutto in Landeswährung

   AND STORE.aspect_id = 1 -- Betriebsgesellschaft

  GROUP BY IND.client_id,
   src_orig_store_nr,
   STORE.loc_sid_store,
   IND.dat_formdate,
   currency_iso_cd) AS kpges ON ewa.client_id = kpges.client_id AND ewa.loc_sid_store = kpges.loc_sid_store AND ewa.dat_formdate
     = kpges.dat_formdate AND ewa.currency_iso_cd = kpges.currency_iso_cd;