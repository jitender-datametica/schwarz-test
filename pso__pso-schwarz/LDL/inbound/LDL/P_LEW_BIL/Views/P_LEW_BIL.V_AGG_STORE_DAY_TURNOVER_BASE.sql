CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_STORE_DAY_TURNOVER_BASE
/*
#DescStart#
#$Revision: 9023 $, $LastChangedBy: mueding $
#SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
#DescEnd#
*/
(
     client_id
,          src_orig_store_nr
,          dat_formdate
,          currency_iso_cd
,          loc_sid_store
,          cy_month
,          cnt_customer
,          val_rtl
,          val_rtl_net
,          val_rtl_extrapol
,          val_rtl_net_extrapol
,          val_rtl_kpges
,          val_rtl_net_kpges
,          val_rtl_wawi
,          val_rtl_net_wawi
,          val_rtl_txj
,          val_rtl_net_txj
,          val_rtl_ejr
,          val_rtl_net_ejr
)
AS
   (
SELECT
Coalesce(kpges.client_id, ewa.client_id)                                                                                                         AS client_id,
   Coalesce(kpges.src_orig_store_nr, ewa.src_orig_store_nr,0)                                                                                       AS src_orig_store_nr,
   Coalesce(kpges.dat_formdate, ewa.dat_formdate)                                                                                                   AS dat_formdate,
   Coalesce(kpges.currency_iso_cd, ewa.currency_iso_cd)                                                                                             AS currency_iso_cd,
   Coalesce(kpges.loc_sid_store, ewa.loc_sid_store)                                                                                                 AS loc_sid_store,
   (Extract(YEAR From Coalesce(kpges.dat_formdate, ewa.dat_formdate)) * 100) + Extract(MONTH From Coalesce(kpges.dat_formdate, ewa.dat_formdate))    AS cy_month,
   ewa.cnt_customer                                                                                                                                 AS cnt_customer,
   Coalesce(kpges.val_rtl_kpges,ewa.val_rtl_wawi,ewa.val_rtl_txj,ewa.val_rtl_ejr,0)                                                                 AS val_rtl,
   Coalesce(kpges.val_rtl_net_kpges,ewa.val_rtl_net_wawi,ewa.val_rtl_net_txj,ewa.val_rtl_net_ejr,0)                                                 AS val_rtl_net,
   Coalesce(kpges.val_rtl_kpges,ewa.val_rtl_wawi,ewa.val_rtl_txj,ewa.val_rtl_ejr,0)                                                                 AS val_rtl_extrapol,
   Coalesce(kpges.val_rtl_net_kpges,ewa.val_rtl_net_wawi,ewa.val_rtl_net_txj,ewa.val_rtl_net_ejr,0)                                                 AS val_rtl_net_extrapol,
   kpges.val_rtl_kpges                                                                                                                              AS val_rtl_kpges,
   kpges.val_rtl_net_kpges                                                                                                                          AS val_rtl_net_kpges,
   ewa.val_rtl_wawi                                                                                                                                 AS val_rtl_wawi,
   ewa.val_rtl_net_wawi                                                                                                                             AS val_rtl_net_wawi,
   ewa.val_rtl_txj                                                                                                                                  AS val_rtl_txj,
   ewa.val_rtl_net_txj                                                                                                                              AS val_rtl_net_txj,
   ewa.val_rtl_ejr                                                                                                                                  AS val_rtl_ejr,
   ewa.val_rtl_net_ejr                                                                                                                              AS val_rtl_net_ejr

  FROM

  (
  SELECT
    Coalesce(wawi.client_id,ejr1.client_id)                 AS client_id,
   Coalesce(wawi.loc_sid_store,ejr1.loc_sid_store)         AS loc_sid_store,
   Coalesce(wawi.src_orig_store_nr,ejr1.src_orig_store_nr) AS src_orig_store_nr,
   Coalesce(wawi.dat_formdate,ejr1.dat_formdate)           AS dat_formdate,
   Coalesce(wawi.currency_iso_cd,ejr1.currency_iso_cd)     AS currency_iso_cd,
   wawi.cnt_customer                                       AS cnt_customer,
   wawi.val_rtl_wawi                                       AS val_rtl_wawi,
   wawi.val_rtl_net_wawi                                   AS val_rtl_net_wawi,
   wawi.val_rtl_txj                                        AS val_rtl_txj,
   wawi.val_rtl_net_txj                                    AS val_rtl_net_txj,
   ejr1.val_rtl_ejr                                        AS val_rtl_ejr,
   ejr1.val_rtl_net_ejr                                    AS val_rtl_net_ejr

  FROM

  -- Die View greift auf die Basistabelle ReceiptLine zu, es findet jedoch keinerlei Logikveränderung beim Zugriff statt. Zwischen der View und der Receipt Line gibt es aus Performancegründen persisitierte Agg-Tabellen

       (
            SELECT      Ejr.client_id                                                                       AS client_id,
   Ejr.dwh_cal_dt                                                                      AS dat_formdate,
   Locn.src_orig_store_nr                                                              AS src_orig_store_nr,
   Ejr.loc_sid_store                                                                   AS loc_sid_store,
   Curr.curr_cd_from                                                                   AS currency_iso_cd,
   Sum((Ejr.sales_gross_val + Ejr.return_gross_val)/ CASE WHEN Curr.exchange_rate = 0 THEN null ELSE Curr.exchange_rate END)    AS val_rtl_ejr,
   Sum((Ejr.sales_net_val + Ejr.return_net_val)/ CASE WHEN Curr.exchange_rate = 0 THEN null ELSE Curr.exchange_rate END)        AS val_rtl_net_ejr

   FROM p_lew_bil.t_agg_pos_store_day_sig_asis          AS Ejr
   INNER JOIN p_lew_core_ac.v_location                        AS Locn
   ON
   Ejr.client_id = Locn.client_id
  AND
   Ejr.loc_sid_store = Locn.loc_sid
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist        AS Curr
   ON
   Curr.client_id = Ejr.client_id
  AND
   Current_Date BETWEEN Curr.active_from_dt AND Curr.active_to_dt
  AND
   Current_Date BETWEEN Curr.dwh_valid_from AND Curr.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type              AS Curr_type
   ON
   Curr_type.client_id = Curr.client_id
  AND
   Curr_type.x_rate_type_sid = Curr.x_rate_type_sid
  AND
   Curr_type.src_kurst = '@BEWE'

--        where       Ejr.subitemgroup_id not in (996, 997)

GROUP BY    Ejr.client_id
,                     Ejr.dwh_cal_dt
,                     Locn.src_orig_store_nr
,                     Ejr.loc_sid_store
,                     Curr.curr_cd_from
--,                   Curr.exchange_rate
)        AS ejr1
   FULL OUTER JOIN
   -- In dieser View werden die e-journal Daten nicht verwendet, daher werden die ejournal Daten über den oberen Join aus der Receipt Line geholt. Über dieses Statement werden die TXJ und WAWI Umsätze selektiert. 
   (SELECT
         agg.client_id,
   agg.dat_formdate,
   agg.src_orig_store_nr,
   agg.loc_sid_store,
   agg.currency_iso_cd,
   SUM(agg.cnt_customer_asis)        AS cnt_customer,
   SUM(agg.val_retail_wawi_asis)     AS val_rtl_wawi,
   SUM(agg.val_retail_net_wawi_asis) AS val_rtl_net_wawi,
   SUM(agg.val_retail_txj_asis)      AS val_rtl_txj,
   SUM(agg.val_retail_net_txj_asis)  AS val_rtl_net_txj

      FROM p_lew_bil.v_agg_str_day_ejr_txj_ww_asis AS agg

   GROUP BY
     agg.client_id
   , agg.dat_formdate
   , agg.src_orig_store_nr
   , agg.loc_sid_store
   , agg.currency_iso_cd
) wawi
   ON ejr1.client_id        = wawi.client_id
   AND ejr1.loc_sid_store   = wawi.loc_sid_store
   AND ejr1.dat_formdate    = wawi.dat_formdate
   AND ejr1.currency_iso_cd = wawi.currency_iso_cd

   ) ewa
   FULL OUTER JOIN

   -- Hole den Umsatz aus KPGES

   (SELECT
        ind.client_id,
   ind.org_unit_nr AS src_orig_store_nr,
   store.loc_sid_store,
   ind.dat_formdate,
   curr.curr_cd_from AS currency_iso_cd,
   Sum(CASE WHEN  ind.indicator_id = 158 THEN ind.val_indicator/curr.exchange_rate ELSE NULL END) AS val_rtl_kpges,
   Sum(CASE WHEN  ind.indicator_id = 157 THEN ind.val_indicator/curr.exchange_rate ELSE NULL END) AS val_rtl_net_kpges
   FROM p_lew_bil.v_indicator_day AS ind
   INNER JOIN p_lew_bil.v_org_store_merge AS store
   ON store.client_id = ind.client_id
   AND  store.src_orig_store_nr = ind.org_unit_nr
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS curr
   ON curr.client_id = ind.client_id
   AND Current_Date BETWEEN curr.active_from_dt AND curr.active_to_dt
   AND Current_Date BETWEEN curr.dwh_valid_from AND curr.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type curr_type
   ON curr_type.client_id = curr.client_id
   AND curr_type.x_rate_type_sid = curr.x_rate_type_sid
   AND curr_type.src_kurst = '@BEWE'

   WHERE ind.org_type_id       = 90                        -- Filiale
   AND   ind.indicator_type_id = 1                            -- Laufendes Jahr
   AND   ind.indicator_id      IN (157,158)                 --  157: Umsatz Netto in Landeswährung, 158: Umsatz Brutto in Landeswährung
   AND   store.aspect_id         = 1                        -- Betriebsgesellschaft

   GROUP BY ind.client_id,
       ind.org_unit_nr,
       store.loc_sid_store,
       ind.dat_formdate,
        curr.curr_cd_from
) kpges
   ON  kpges.client_id = ewa.client_id
   AND kpges.loc_sid_store = ewa.loc_sid_store
   AND kpges.dat_formdate = ewa.dat_formdate
   AND kpges.currency_iso_cd = ewa.currency_iso_cd
         )
   ;