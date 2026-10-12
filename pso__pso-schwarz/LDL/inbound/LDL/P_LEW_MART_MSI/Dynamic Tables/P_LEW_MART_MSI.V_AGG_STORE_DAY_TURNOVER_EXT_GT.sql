CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STORE_DAY_TURNOVER_EXT_GT
(
	client_id
	,orig_store_nr
	,dat_formdate
	,currency_iso_cd
	,store_id
	,cy_month
	,cnt_customer
	,val_rtl
	,val_rtl_net
	,val_rtl_extrapol
	,val_rtl_net_extrapol
	,val_rtl_kpges
	,val_rtl_net_kpges
	,val_rtl_wawi
	,val_rtl_net_wawi
	,val_rtl_txj
	,val_rtl_net_txj
	,val_rtl_ejr
	,val_rtl_net_ejr
)


TARGET_LAG = '1 hour, 30 minutes' -- dummy value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS

   SELECT

   basis.client_id                                                                                                                 AS client_id
   ,basis.orig_store_nr                                                                                                             AS orig_store_nr
   ,basis.dat_formdate                                                                                                           AS dat_formdate
   ,basis.currency_iso_cd                                                                                                      AS currency_iso_cd
   ,basis.store_id                                                                                                                  AS store_id
   ,basis.cy_month                                  AS cy_month
   ,basis.cnt_customer                                                                                                                                 AS cnt_customer
   ,basis.val_rtl                                                                                   AS val_rtl
   ,basis.val_rtl_net                                                                      AS val_rtl_net
   ,COALESCE(basis.val_rtl_extrapol,ext.val_rtl_extrapol)                                                                         AS val_rtl_extrapol
   ,COALESCE(basis.val_rtl_net_extrapol,ext.val_rtl_net_extrapol)                                                       AS val_rtl_net_extrapol
   ,basis.val_rtl_kpges                                                                                                                               AS val_rtl_kpges
   ,basis.val_rtl_net_kpges                                                                                                                           AS val_rtl_net_kpges
   ,basis.val_rtl_wawi                                                                                                                                AS val_rtl_wawi
   ,basis.val_rtl_net_wawi                                                                                                                             AS val_rtl_net_wawi
   ,basis.val_rtl_txj                                                                                                                                  AS val_rtl_txj
   ,basis.val_rtl_net_txj                                                                                                                              AS val_rtl_net_txj
   ,basis.val_rtl_ejr                                                                                                                                  AS val_rtl_ejr
   ,basis.val_rtl_net_ejr                                                                                                                              AS val_rtl_net_ejr

   FROM


   (SELECT
     COALESCE(kpges.client_id, ewa.client_id)                                                                                                         AS client_id
   ,COALESCE(kpges.orig_store_nr, ewa.orig_store_nr,0)                                                                                               AS orig_store_nr
   ,COALESCE(kpges.dat_formdate, ewa.dat_formdate)                                                                                                   AS dat_formdate
   ,COALESCE(kpges.currency_iso_cd, ewa.currency_iso_cd)                                                                                             AS currency_iso_cd
   ,COALESCE(kpges.store_id, ewa.store_id)                                                                                                           AS store_id
   ,(EXTRACT(YEAR FROM COALESCE(kpges.dat_formdate, ewa.dat_formdate)) * 100) + EXTRACT(MONTH FROM COALESCE(kpges.dat_formdate, ewa.dat_formdate))    AS cy_month
   ,ewa.cnt_customer                                                                                                                                 AS cnt_customer
   ,COALESCE(kpges.val_rtl_kpges,ewa.val_rtl_wawi,ewa.val_rtl_txj,ewa.val_rtl_ejr,0)                                                                 AS val_rtl
   ,COALESCE(kpges.val_rtl_net_kpges,ewa.val_rtl_net_wawi,ewa.val_rtl_net_txj,ewa.val_rtl_net_ejr,0)                                                 AS val_rtl_net
   ,COALESCE(kpges.val_rtl_kpges,ewa.val_rtl_wawi,ewa.val_rtl_txj,ewa.val_rtl_ejr,0)                                                                 AS val_rtl_extrapol
   ,COALESCE(kpges.val_rtl_net_kpges,ewa.val_rtl_net_wawi,ewa.val_rtl_net_txj,ewa.val_rtl_net_ejr,0)                                                 AS val_rtl_net_extrapol
   ,kpges.val_rtl_kpges                                                                                                                              AS val_rtl_kpges
   ,kpges.val_rtl_net_kpges                                                                                                                          AS val_rtl_net_kpges
   ,ewa.val_rtl_wawi                                                                                                                                 AS val_rtl_wawi
   ,ewa.val_rtl_net_wawi                                                                                                                             AS val_rtl_net_wawi
   ,ewa.val_rtl_txj                                                                                                                                  AS val_rtl_txj
   ,ewa.val_rtl_net_txj                                                                                                                              AS val_rtl_net_txj
   ,ewa.val_rtl_ejr                                                                                                                                  AS val_rtl_ejr
   ,ewa.val_rtl_net_ejr                                                                                                                              AS val_rtl_net_ejr

  FROM

  (
  SELECT
   COALESCE(wawi.client_id,ejr1.client_id)               AS client_id
   ,COALESCE(wawi.store_id,ejr1.store_id)                 AS store_id
   ,COALESCE(wawi.orig_store_nr,ejr1.orig_store_nr)       AS orig_store_nr
   ,COALESCE(wawi.dat_formdate,ejr1.dat_formdate)         AS dat_formdate
   ,COALESCE(wawi.currency_iso_cd,ejr1.currency_iso_cd)   AS currency_iso_cd
   ,wawi.cnt_customer                                     AS cnt_customer
   ,wawi.val_rtl_wawi                                     AS val_rtl_wawi
   ,wawi.val_rtl_net_wawi                                 AS val_rtl_net_wawi
   ,wawi.val_rtl_txj                                      AS val_rtl_txj
   ,wawi.val_rtl_net_txj                                  AS val_rtl_net_txj
   ,ejr1.val_rtl_ejr                                      AS val_rtl_ejr
   ,ejr1.val_rtl_net_ejr                                  AS val_rtl_net_ejr

  FROM

  -- Die View greift auf die Basistabelle ReceiptLine zu, es findet jedoch keinerlei Logikveränderung beim Zugriff statt. Zwischen der View und der Receipt Line gibt es aus Performancegründen persisitierte Agg-Tabellen 

  (SELECT
   ejr.client_id
   ,ejr.dat_formdate
   ,ejr.orig_store_nr
   ,ejr.store_id
   ,ejr.currency_iso_cd
   ,SUM(ejr.val_rtl_ejr_asis + ejr.val_return_ejr_asis)         val_rtl_ejr
   ,SUM(ejr.val_rtl_net_ejr_asis + ejr.val_return_net_ejr_asis) val_rtl_net_ejr

      FROM p_lew_mart_msi.v_agg_store_day_sig_ejr_asis AS ejr


   --WHERE ejr.subitemgroup_id NOT IN (996, 997)

   GROUP BY
     ejr.client_id
   , ejr.dat_formdate
   , ejr.orig_store_nr
   , ejr.store_id
   , ejr.currency_iso_cd
)ejr1
   FULL OUTER JOIN
   -- In dieser View werden die e-journal Daten nicht verwendet, daher werden die ejournal Daten über den oberen Join aus der Receipt Line geholt. Über dieses Statement werden die TXJ und WAWI Umsätze selektiert. 
   (SELECT
   agg.client_id
   ,agg.dat_formdate
   ,agg.orig_store_nr
   ,agg.store_id
   ,agg.currency_iso_cd
   ,SUM(agg.cnt_customer_asis)        cnt_customer
   ,SUM(agg.val_retail_wawi_asis)     val_rtl_wawi
   ,SUM(agg.val_retail_net_wawi_asis) val_rtl_net_wawi
   ,SUM(agg.val_retail_txj_asis)      val_rtl_txj
   ,SUM(agg.val_retail_net_txj_asis)  val_rtl_net_txj

      FROM p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis AS agg

   GROUP BY
     agg.client_id
   , agg.dat_formdate
   , agg.orig_store_nr
   , agg.store_id
   , agg.currency_iso_cd
) wawi
   ON ejr1.client_id        = wawi.client_id
   AND ejr1.store_id        = wawi.store_id
   AND ejr1.dat_formdate    = wawi.dat_formdate
   AND ejr1.currency_iso_cd = wawi.currency_iso_cd

   ) ewa
   FULL OUTER JOIN

   -- Hole den Umsatz aus KPGES 

   (

   SELECT ind.client_id
   ,ind.org_unit_nr AS orig_store_nr
   ,store.store_id
   ,ind.dat_formdate
   ,curr.curr_cd_from AS currency_iso_cd
   ,SUM(CASE WHEN  ind.indicator_id = 158 THEN   ind.val_indicator/curr.exchange_rate ELSE NULL END) val_rtl_kpges
   ,SUM(CASE WHEN  ind.indicator_id = 157 THEN   ind.val_indicator/curr.exchange_rate ELSE NULL END) val_rtl_net_kpges
   FROM p_lew_mart_msi.v_indicator_day AS ind
   INNER JOIN p_lew_mart_msi.v_org_store_merge AS store
   ON store.client_id = ind.client_id
   AND  store.orig_store_nr = ind.org_unit_nr
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist curr
   ON curr.client_id = ind.client_id
   AND CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
   AND CURRENT_DATE BETWEEN curr.dwh_valid_from AND curr.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type curr_type
   ON curr_type.client_id = curr.client_id
   AND curr_type.x_rate_type_sid = curr.x_rate_type_sid
   AND curr_type.src_kurst = '@BEWE'



   WHERE ind.org_type_id       = 90      -- Filiale 
   AND   ind.indicator_type_id = 1       -- Laufendes Jahr
   AND   ind.indicator_id      IN (157,158)     --  157: Umsatz Netto in Landeswährung, 158: Umsatz Brutto in Landeswährung
   AND   store.aspect_id         = 1      -- Betriebsgesellschaft

   GROUP BY ind.client_id,
       ind.org_unit_nr,
       store.store_id,
       ind.dat_formdate,
       curr.curr_cd_from
) kpges
   ON  kpges.client_id = ewa.client_id
   AND kpges.store_id = ewa.client_id
   AND kpges.dat_formdate = ewa.dat_formdate
   AND kpges.currency_iso_cd = ewa.currency_iso_cd

   ) basis
   FULL OUTER JOIN
   -- Basisergebnis mit Hochrechnungen verknüpfen

   (SELECT                        -- Part 1 - Data with no turnover => turnover will be extrapolated -- Wieso gibt es Umsätze, die 0 sind, obwohl Store offen hatte? 
   sb.client_id
   ,sb.orig_store_nr
   ,sb.dat_open AS dat_formdate
   ,sb.curr_cd_from
   ,sb.store_id
   ,(EXTRACT (YEAR FROM e.dat_calendar)*100 + EXTRACT (MONTH FROM e.dat_calendar) ) AS cy_month
   ,sb.cnt_customer
   ,sb.val_rtl
   ,sb.val_rtl_net
   ,sb.val_rtl_kpges
   ,sb.val_rtl_net_kpges
   ,sb.val_rtl_wawi
   ,sb.val_rtl_net_wawi
   ,sb.val_rtl_txj
   ,sb.val_rtl_net_txj
   ,sb.val_rtl_ejr
   ,sb.val_rtl_net_ejr
   ,CASE WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL THEN COALESCE(AVG(CASE WHEN f.val_rtl = 0 THEN NULL ELSE f.val_rtl END ),0)
          ELSE NULL
          END AS val_rtl_extrapol
   ,CASE WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL THEN COALESCE(AVG(CASE WHEN f.val_rtl_net = 0 THEN NULL ELSE f.val_rtl_net END ),0)
          ELSE NULL
          END AS val_rtl_net_extrapol

      FROM
      (   ----Take ONLY those records which have 0s OR NULLS IN turnover for this store, client and date
          SELECT
   COALESCE( mds.client_id, fs.client_id)              AS client_id
   ,COALESCE( mds.store_id, fs.store_id)                AS store_id
   ,COALESCE(mds.orig_store_nr,fs.orig_store_nr)        AS orig_store_nr
   ,COALESCE( mds.dat_open, fs.dat_formdate)            AS dat_open
   ,mds.dat_open                                        AS dat_open_md_storelist
   ,fs.cnt_customer
   ,COALESCE( mds.curr_cd_from, fs.currency_iso_cd)  AS curr_cd_from
   ,fs.val_rtl
   ,fs.val_rtl_net
   ,fs.val_rtl_kpges
   ,fs.val_rtl_net_kpges
   ,fs.val_rtl_wawi
   ,fs.val_rtl_net_wawi
   ,fs.val_rtl_txj
   ,fs.val_rtl_net_txj
   ,fs.val_rtl_ejr
   ,fs.val_rtl_net_ejr


  -- Subselect aus erster Query

    FROM (SELECT
    COALESCE(kpges.client_id, ewa.client_id)                                                                                                         AS client_id
  ,COALESCE(kpges.orig_store_nr, ewa.orig_store_nr,0)                                                                                               AS orig_store_nr
  , COALESCE(kpges.dat_formdate, ewa.dat_formdate)                                                                                                   AS dat_formdate
  , COALESCE(kpges.currency_iso_cd, ewa.currency_iso_cd)                                                                                             AS currency_iso_cd
  , COALESCE(kpges.store_id, ewa.store_id)                                                                                                           AS store_id
  , (EXTRACT(YEAR FROM COALESCE(kpges.dat_formdate, ewa.dat_formdate)) * 100) + EXTRACT(MONTH FROM COALESCE(kpges.dat_formdate, ewa.dat_formdate))    AS cy_month
  , ewa.cnt_customer                                                                                                                                 AS cnt_customer
  , COALESCE(kpges.val_rtl_kpges,ewa.val_rtl_wawi,ewa.val_rtl_txj,ewa.val_rtl_ejr,0)                                                                 AS val_rtl
  , COALESCE(kpges.val_rtl_net_kpges,ewa.val_rtl_net_wawi,ewa.val_rtl_net_txj,ewa.val_rtl_net_ejr,0)                                                 AS val_rtl_net
  , COALESCE(kpges.val_rtl_kpges,ewa.val_rtl_wawi,ewa.val_rtl_txj,ewa.val_rtl_ejr,0)                                                                 AS val_rtl_extrapol
  , COALESCE(kpges.val_rtl_net_kpges,ewa.val_rtl_net_wawi,ewa.val_rtl_net_txj,ewa.val_rtl_net_ejr,0)                                                 AS val_rtl_net_extrapol
  , kpges.val_rtl_kpges                                                                                                                              AS val_rtl_kpges
  , kpges.val_rtl_net_kpges                                                                                                                          AS val_rtl_net_kpges
  , ewa.val_rtl_wawi                                                                                                                                 AS val_rtl_wawi
  , ewa.val_rtl_net_wawi                                                                                                                             AS val_rtl_net_wawi
  , ewa.val_rtl_txj                                                                                                                                  AS val_rtl_txj
  , ewa.val_rtl_net_txj                                                                                                                              AS val_rtl_net_txj
  , ewa.val_rtl_ejr                                                                                                                                  AS val_rtl_ejr
  , ewa.val_rtl_net_ejr                                                                                                                              AS val_rtl_net_ejr

  FROM

  (
  SELECT
    COALESCE(wawi.client_id,ejr1.client_id)               AS client_id
   ,COALESCE(wawi.store_id,ejr1.store_id)                 AS store_id
   ,COALESCE(wawi.orig_store_nr,ejr1.orig_store_nr)       AS orig_store_nr
   ,COALESCE(wawi.dat_formdate,ejr1.dat_formdate)         AS dat_formdate
   ,COALESCE(wawi.currency_iso_cd,ejr1.currency_iso_cd)   AS currency_iso_cd
   ,wawi.cnt_customer                                     AS cnt_customer
   ,wawi.val_rtl_wawi                                     AS val_rtl_wawi
   ,wawi.val_rtl_net_wawi                                 AS val_rtl_net_wawi
   ,wawi.val_rtl_txj                                      AS val_rtl_txj
   ,wawi.val_rtl_net_txj                                  AS val_rtl_net_txj
   ,ejr1.val_rtl_ejr                                      AS val_rtl_ejr
   ,ejr1.val_rtl_net_ejr                                  AS val_rtl_net_ejr

  FROM

  -- Die View greift auf die Basistabelle ReceiptLine zu, es findet jedoch keinerlei Logikveränderung beim Zugriff statt. Zwischen der View und der Receipt Line gibt es aus Performancegründen persisitierte Agg-Tabellen 

  (SELECT
   ejr.client_id
   ,ejr.dat_formdate
   ,ejr.orig_store_nr
   ,ejr.store_id
   ,ejr.currency_iso_cd
   ,SUM(ejr.val_rtl_ejr_asis + ejr.val_return_ejr_asis)         val_rtl_ejr
   ,SUM(ejr.val_rtl_net_ejr_asis + ejr.val_return_net_ejr_asis) val_rtl_net_ejr

      FROM p_lew_mart_msi.v_agg_store_day_sig_ejr_asis AS ejr


   --WHERE ejr.subitemgroup_id NOT IN (996, 997)

   GROUP BY
     ejr.client_id
   , ejr.dat_formdate
   , ejr.orig_store_nr
   , ejr.store_id
   , ejr.currency_iso_cd
)ejr1
   FULL OUTER JOIN
   -- In dieser View werden die e-journal Daten nicht verwendet, daher werden die ejournal Daten über den oberen Join aus der Receipt Line geholt. Über dieses Statement werden die TXJ und WAWI Umsätze selektiert. 
   (SELECT
   agg.client_id
   ,agg.dat_formdate
   ,agg.orig_store_nr
   ,agg.store_id
   ,agg.currency_iso_cd
   ,SUM(agg.cnt_customer_asis)        cnt_customer
   ,SUM(agg.val_retail_wawi_asis)     val_rtl_wawi
   ,SUM(agg.val_retail_net_wawi_asis) val_rtl_net_wawi
   ,SUM(agg.val_retail_txj_asis)      val_rtl_txj
   ,SUM(agg.val_retail_net_txj_asis)  val_rtl_net_txj

      FROM p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis AS agg

   GROUP BY
     agg.client_id
   , agg.dat_formdate
   , agg.orig_store_nr
   , agg.store_id
   , agg.currency_iso_cd
) wawi
   ON ejr1.client_id        = wawi.client_id
   AND ejr1.store_id        = wawi.store_id
   AND ejr1.dat_formdate    = wawi.dat_formdate
   AND ejr1.currency_iso_cd = wawi.currency_iso_cd

   ) ewa
   FULL OUTER JOIN

   -- Hole den Umsatz aus KPGES 

   (

   SELECT ind.client_id
   ,ind.org_unit_nr AS orig_store_nr
   ,store.store_id
   ,ind.dat_formdate
   ,curr.curr_cd_from AS currency_iso_cd
   ,SUM(CASE WHEN  ind.indicator_id = 158 THEN   ind.val_indicator/curr.exchange_rate ELSE NULL END) val_rtl_kpges
   ,SUM(CASE WHEN  ind.indicator_id = 157 THEN   ind.val_indicator/curr.exchange_rate ELSE NULL END) val_rtl_net_kpges
   FROM p_lew_mart_msi.v_indicator_day AS ind
   INNER JOIN p_lew_mart_msi.v_org_store_merge AS store
   ON store.client_id = ind.client_id
   AND  store.orig_store_nr = ind.org_unit_nr
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist curr
   ON curr.client_id = ind.client_id
   AND CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
   AND CURRENT_DATE BETWEEN curr.dwh_valid_from AND curr.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type curr_type
   ON curr_type.client_id = curr.client_id
   AND curr_type.x_rate_type_sid = curr.x_rate_type_sid
   AND curr_type.src_kurst = '@BEWE'



   WHERE ind.org_type_id       = 90      -- Filiale 
   AND   ind.indicator_type_id = 1       -- Laufendes Jahr
   AND   ind.indicator_id      IN (157,158)     --  157: Umsatz Netto in Landeswährung, 158: Umsatz Brutto in Landeswährung
   AND   store.aspect_id         = 1      -- Betriebsgesellschaft

   GROUP BY ind.client_id
       ,ind.org_unit_nr
       ,store.store_id
       ,ind.dat_formdate
       ,curr.curr_cd_from
) kpges
   ON  kpges.client_id = ewa.client_id
   AND kpges.store_id = ewa.client_id
   AND kpges.dat_formdate = ewa.dat_formdate
   AND kpges.currency_iso_cd = ewa.currency_iso_cd) fs
   FULL OUTER JOIN


-- Hole nur die Stores, die tatsächlich geöffnet waren. Anschließend wird Orig_Store_nr rangejoint, um einen Bezug zu Wawi herzustellen
-- Wenn in KPGES kein Information über die Öffnung eines Stores zu finden ist (val_indicator = NULL), dann nehme Information aus MD-Storelist --> !!BIL Layer!!
   (
       SELECT
         mds.*
   ,curr.curr_cd_from
   ,skey.orig_store_nr

              FROM p_lew_mart_msi.v_sys_md_storelist mds
   INNER JOIN p_lew_mart_msi.v_org_store_skey skey
   ON   mds.client_id = skey.client_id
   AND  mds.store_id = skey.store_id
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist curr
   ON curr.client_id = mds.client_id
   AND CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
   AND CURRENT_DATE BETWEEN curr.dwh_valid_from AND curr.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type curr_type
   ON curr_type.client_id = curr.client_id
   AND curr_type.x_rate_type_sid = curr.x_rate_type_sid
   AND curr_type.src_kurst = '@BEWE'

           QUALIFY ROW_NUMBER() OVER (PARTITION BY mds.client_id,mds.store_id,mds.dat_open,curr.curr_cd_from  ORDER BY orig_store_nr )=1

       ) mds
   ON   mds.dat_open         = fs.dat_formdate
   AND  mds.client_id        = fs.client_id
   AND  mds.orig_store_nr    = fs.orig_store_nr
   AND  mds.curr_cd_from  = fs.currency_iso_cd
/*
# 
# Only records which have 0s OR NULLS IN turnover FOR this store, client and date
# stores with a valid dat_open have to be selected and stores with only
# filled cnt_customer
# val_rtl_net column will be driving column for extrapolation
# 
*/
  WHERE (fs.val_rtl_net = 0 OR fs.val_rtl_net IS NULL)
  AND (( mds.dat_open IS NOT NULL ) OR ( mds.dat_open IS NULL AND fs.cnt_customer <> 0 ))
  AND COALESCE( mds.dat_open, fs.dat_formdate) < CURRENT_DATE

) sb
   INNER JOIN p_lew_mart_msi.v_cal_day_rel_extrapol e
   ON e.dat_calendar = sb.dat_open
   LEFT OUTER JOIN

   (
       SELECT
         client_id
   ,orig_store_nr
   ,dat_formdate
   ,currency_iso_cd
   ,store_id
   ,cy_month
   ,cnt_customer
   ,val_rtl
   ,val_rtl_net

              FROM p_lew_mart_msi.t_agg_store_turnover_ext

              WHERE dat_formdate < CURRENT_DATE

          ) f
   ON   e.dat_calendar_extrapol = f.dat_formdate
   AND  sb.client_id            = f.client_id
   AND  sb.orig_store_nr        = f.orig_store_nr
   AND  sb.curr_cd_from      = f.currency_iso_cd

   GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
)ext
   ON   basis.client_id   = ext.client_id
   AND  basis.dat_formdate   = ext.dat_formdate
   AND  basis.orig_store_nr  = ext.orig_store_nr
   AND     basis.store_id   = ext.store_id
   AND     basis.currency_iso_cd = ext.curr_cd_from
;