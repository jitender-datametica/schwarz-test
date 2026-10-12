/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_KPGES_MTH_WH_MERGE_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  01.12.2017    Webster,Stuart           Add Austria SAP data
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  19.03.2018    Webster,Stuart           Update to include change of logic in 20170911_1454_Erweiterung_Bewegungsdaten_Lagerinventur
#  1.5  22.05.2018    Davis,Mike               Tidy up joins and ignore item_1 criteria.
#  1.6  28.01.2019    Michael Beerweiler       20190122_1929_InvDiffFiliale_neuer_Extraktor_Views
#                                              Umstellung auf neuen Extraktor/neue Core-Tabelle
#  1.7  31.03.2019    Camerzan,Dumitru         Replaced LEW_CORE_AC.V_WAWI_INDICATOR_MONTH_1 with LEW_BIL_AC.V_KPI_MONTH_1
#  1.8  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item_1 types ZKM and ZVM from USA and Serbia
#  1.9  22.02.2021    Mittler Patrick          20210222_2758_wk_moni_fix_cry Include indicator_id 315,322,325
#  1.10 02.05.2022    Jaroslaw Syrokosz        LV: dummy_1 values for 2020 and 2021 until it started to operate INC430866, AP0127218
#       12.04.2024    Stephane Djiomou Tonga   Master Version was remigrated from Dev to Prod
#  1.12 01.07.2024    Marcin Malec             add logic for indicator 338, 339; average headcount for last only open 12 months; User Story 643630
#  1.13 22.05.2025    Marcin Malec             Division by zero hotfix
#  1.14 10.10.2025    Marcin Malec             add logic for indicator 340, 341; sum for last 12 months, calculated by month; User Story 767991
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_KPGES_MTH_WH_MERGE_1 COMMENT = ''
      (
           client_id            COMMENT ''
,          wh_id                COMMENT ''
,          aspect_id            COMMENT ''
,          indicator_id         COMMENT ''
,          cy_month             COMMENT ''
,          val_indicator        COMMENT ''
,          currency_iso_cd      COMMENT ''
,          dat_dayend           COMMENT ''
      )
     AS 
      (

           SELECT      unn.client_id             AS client_id
,                      unn.wh_id                 AS wh_id
,                      unn.aspect_id             AS aspect_id
,                      unn.indicator_id          AS indicator_id
,                      unn.cy_month              AS cy_month
,                      SUM(unn.val_indicator)    AS val_indicator
,                      unn.currency_iso_cd       AS currency_iso_cd
,                      MAX(unn.dat_dayend)       AS dat_dayend
           FROM        (
/*-----------------------------------------------------------------------
Block 1:
This query produces indicator values for all clients.
All indicators are processed both in EUR and the currency of the client_id country.
For all indicator_ids other than 117 there is no further processing.

Indicator_id = 117.
The query determines if the client_id was running in WAWI or SAP (eLwis) during the givem month
(established with: v_kpi_month.imth.cy * 100 + v_kpi_month.month_id) which the indicator value represents.

If the client_id has been migrated to eLwis then the values from KPGES are not processed further. If the
client_id has not been migrated then using the VAT factor (MwSt) calculated from the associated stock-take
values the indicator value is reduced by dividing the value by the calculated VAT. If the VAT factor cannot
be calculated due to no stock take data being available then the value is returned without further manipulation.

If the client_id = 1 and the indicator_id = 117 and the lies withing the time period where the client_id is
running on eLwis then the value from KPGES is ignored and the value returned is 0.

-------------------------------------------------------------------------
*/
                             SELECT      wh.client_id          AS client_id
                                       , wh.wh_id              AS wh_id
                                       , wh.aspect_id          AS aspect_id
                                       , wh.indicator_id       AS indicator_id
                                       , wh.cy_month           AS cy_month
                                       , CASE WHEN wh.indicator_id = '117' AND wh.indicator_type_id = 1 AND wh.mig_fg = 0 THEN
                                                    CASE WHEN alt_mwst.mwst IS NOT NULL
                                                              THEN wh.val_indicator / alt_mwst.mwst
                                                              ELSE wh.val_indicator
                                                     END
                                               WHEN wh.indicator_id = '117' AND wh.indicator_type_id = 1 AND wh.mig_fg = 1 AND wh.client_id = 1
                                                    THEN 0
                                              WHEN wh.indicator_id = 338 THEN (SELECT ROUND(SUM(val_indicator) / NULLIFZERO(COALESCE((CASE WHEN SUM(CASE WHEN val_indicator != 0 THEN 1 ELSE 0 END) != 0 THEN SUM(CASE WHEN val_indicator != 0 THEN 1 ELSE 0 END) ELSE 1 END), 1)), 2) 
                                                                         FROM P_LEW_BIL_AC.v_kpi_month_1 AS subqry 
                                                                         INNER JOIN P_LEW_CORE_AC.v_cal_month_1 submon
                                                                         ON subqry.cy * 100 + subqry.month_id = submon.cy_month
                                                                         AND submon.cy_month_seq BETWEEN mon.cy_month_seq - 11 AND mon.cy_month_seq
                                                                         WHERE wh.client_id = subqry.client_id 
                                                                         AND wh.wh_id = subqry.org_unit_nr
                                                                         AND subqry.indicator_id = 236 
                                                                         AND subqry.indicator_type_id   = 1
                                                                         AND subqry.org_type_id IN (50,60))
                                              WHEN wh.indicator_id = 339 THEN (SELECT ROUND(SUM(val_indicator) / NULLIFZERO(COALESCE((CASE WHEN SUM(CASE WHEN val_indicator != 0 THEN 1 ELSE 0 END) != 0 THEN SUM(CASE WHEN val_indicator != 0 THEN 1 ELSE 0 END) ELSE 1 END), 1)), 2) 
                                                                         FROM P_LEW_BIL_AC.v_kpi_month_1 AS subqry 
                                                                         INNER JOIN P_LEW_CORE_AC.v_cal_month_1 submon
                                                                         ON subqry.cy * 100 + subqry.month_id = submon.cy_month
                                                                         AND submon.cy_month_seq BETWEEN mon.cy_month_seq - 11 AND mon.cy_month_seq
                                                                         WHERE wh.client_id = subqry.client_id 
                                                                         AND wh.wh_id = subqry.org_unit_nr
                                                                         AND subqry.indicator_id = 237
                                                                         AND subqry.indicator_type_id   = 1
                                                                         AND subqry.org_type_id IN (50,60))
                                              WHEN wh.indicator_id = 340 THEN (SELECT ROUND(SUM(val_indicator), 2)
                                                                         FROM P_LEW_BIL_AC.v_kpi_month_1 AS subqry 
                                                                         INNER JOIN P_LEW_CORE_AC.v_cal_month_1 submon
                                                                         ON subqry.cy * 100 + subqry.month_id = submon.cy_month
                                                                         AND submon.cy_month_seq BETWEEN mon.cy_month_seq - 11 AND mon.cy_month_seq
                                                                         WHERE wh.client_id = subqry.client_id 
                                                                         AND wh.wh_id = subqry.org_unit_nr
                                                                         AND subqry.indicator_id = 191
                                                                         AND subqry.indicator_type_id   = 1
                                                                         AND subqry.org_type_id IN (50))
                                              WHEN wh.indicator_id = 341 THEN (SELECT ROUND(SUM(val_indicator), 2)
                                                                         FROM P_LEW_BIL_AC.v_kpi_month_1 AS subqry 
                                                                         INNER JOIN P_LEW_CORE_AC.v_cal_month_1 submon
                                                                         ON subqry.cy * 100 + subqry.month_id = submon.cy_month
                                                                         AND submon.cy_month_seq BETWEEN mon.cy_month_seq - 11 AND mon.cy_month_seq
                                                                         WHERE wh.client_id = subqry.client_id 
                                                                         AND wh.wh_id = subqry.org_unit_nr
                                                                         AND subqry.indicator_id = 239
                                                                         AND subqry.indicator_type_id   = 1
                                                                         AND subqry.org_type_id IN (50))
                                               ELSE           wh.val_indicator
                                          END                                                                  AS val_indicator
                                       , wh.currency_iso_cd                                                    AS currency_iso_cd
                                       , CASE WHEN wh.indicator_id = '117' AND wh.indicator_type_id = 1 AND wh.mig_fg = 1 AND wh.client_id = 1
                                                   THEN NULL
                                              ELSE      wh.dat_dayend
                                          END                                                                 AS dat_dayend
                             FROM         (
                                           SELECT   imth.client_id                                       AS client_id
                                                  , imth.org_unit_nr                                     AS wh_id
                                                  , CASE WHEN imth.org_type_id = 50 THEN 1 ELSE 2 END    AS aspect_id
                                                  , imth.indicator_id                                    AS indicator_id
                                                  , imth.cy                                              AS cy
                                                  , imth.cy * 100 + imth.month_id                        AS cy_month
                                                  , CASE
                                                         WHEN  imth.indicator_id IN (117,120,125,126,133,135,136,155,156,157,163,168
                                                                                        ,169,170,172,174,177,179,203,204,209,210,212,216,228,229,230,238,240,242,250
                                                                                        ,251,255,256,257,258,259,260,261,270,271,272,273,280,281,282,283,284,286)
                                                              THEN imth.val_indicator / cry.rate_currency_exchange
                                                         ELSE imth.val_indicator
                                                     END                                                 AS val_indicator
                                                  , cry.currency_iso_cd                                  AS currency_iso_cd
                                                  , imth.dat_dayend                                      AS dat_dayend
                                                  , CASE WHEN (imth.cy * 100) + imth.month_id BETWEEN TO_NUMBER(TO_CHAR(mig.migration_dat_valid_from, 'YYYYMM')) AND TO_NUMBER(TO_CHAR(mig.migration_dat_valid_to, 'YYYYMM'))
                                                              THEN 1                                     /* eLwis for this month */
                                                              ELSE 0                                     /* Wawi  for this month */
                                                     END                                                 AS mig_fg
                                                  , imth.indicator_type_id

                                           FROM          P_LEW_BIL_AC.v_kpi_month_1                                   AS imth

                                           INNER JOIN     (
                                                        SELECT
                                                        b.client_id
                                                        , curr_cd_from AS currency_iso_cd
                                                        , curr_cd_to AS to_currency_iso_cd
                                                        , exchange_rate AS rate_currency_exchange
                                                        FROM P_LEW_CORE_AC.v_exchange_rate_known_hist_1 AS b
                                                        INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type_1 AS c
                                                        ON c.client_id             = b.client_id
                                                        AND c.x_rate_type_sid     = b.x_rate_type_sid
                                                        AND c.src_kurst         = '@BEWE'
                                                        WHERE   CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
                                                        AND     CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
                                                        ) AS cry
                                                   ON    imth.client_id         =  cry.client_id


                                           INNER JOIN    P_LEW_CORE_AC.v_client_migration_per_1                       AS mig
                                                   ON    imth.client_id  = mig.client_id

                                           WHERE imth.indicator_type_id   = 1
                                             AND imth.org_type_id   IN (50,60)
                                           ) AS wh

                       LEFT OUTER JOIN (
                                         SELECT   ww.client_id
                                                , ww.wh_id
                                                , TO_CHAR(ww.inv_end_date,'YYYYMM')                      AS cy_month
                                                , SUM(ww.val_retail) / NULLIFZERO(SUM(ww.val_retail_net))           AS mwst
                                           FROM P_LEW_MART_MSI_AC.v_inv_wh_ejr_txj_ww_1                               AS ww
                                          GROUP BY ww.client_id, ww.wh_id , TO_CHAR(ww.inv_end_date,'YYYYMM')
                                       ) alt_mwst
                         ON alt_mwst.cy_month  = wh.cy_month
                        AND alt_mwst.client_id = wh.client_id
                        AND alt_mwst.wh_id     = wh.wh_id
                        
                        INNER JOIN P_LEW_CORE_AC.v_cal_month_1 AS mon
                        ON wh.cy_month = mon.cy_month
                        
                            UNION
/*-----------------------------------------------------------------------
Block 2:
This query produces indicator values for indicator_id = 117 and client_id = 1 for the time period where this client_id
was running on eLwis.

-------------------------------------------------------------------------
*/

                             SELECT      COALESCE (inv.client_id, rtn.client_id)                                                                AS client_id
,                                        COALESCE (inv.wh_id, rtn.wh_id)                                                                        AS wh_id
,                                        cal.id                                                                                                 AS aspect_id
,                                        117                                                                                                    AS indicator_id
,                                        TO_NUMBER(TO_CHAR(COALESCE(inv.dwh_cal_dt, rtn.dwh_cal_dt ) , 'YYYYMM'))                               AS cy_month
,                                        SUM(COALESCE(inv.inv_diff_net_val, 0) + COALESCE(rtn.sales_net_val,0)) / cry.rate_currency_exchange    AS val_indicator
,                                        cry.currency_iso_cd                                                                                    AS currency_iso_cd
,                                        MAX(COALESCE(inv.dwh_cal_dt, rtn.dwh_cal_dt ))                                                         AS dat_dayend

                             FROM         (
                                               SELECT      mov.client_id                                                         AS client_id
,                                                          mov.loc_sid                                                           AS loc_sid
,                                                          bges.src_wh_id                                                        AS wh_id
,                                                          mov.item_sid                                                          AS item_sid
,                                                          mov.dwh_cal_dt                                                        AS dwh_cal_dt
,                                                          SUM(mov.ship_qty)                                                     AS ship_qty
,                                                          SUM(mov.ship_qty * COALESCE(prc.cond_val_eff_calc, 0))                AS gross_val
,                                                          SUM(TO_NUMBER(mov.ship_qty * COALESCE(prc.cond_val_eff_calc, 0) * 100 /
                                                               (100 + COALESCE(prc.tax_rate_calc, 0)),18,2))                     AS sales_net_val

                                               FROM         P_LEW_CORE_AC.v_item_movement_record_pos_1                           AS mov

                                                           LEFT OUTER JOIN    P_LEW_BIL_AC.v_item_loc_sales_cond_denorm_1        AS prc
                                                                        ON     mov.client_id =prc.client_id
                                                                              AND
                                                                               mov.item_sid = prc.item_sid
                                                                              AND
                                                                               mov.loc_sid = prc.loc_sid
                                                                              AND
                                                                               mov.uom_sid_base = prc.uom_sid_cond
                                                                              AND
                                                                               mov.dwh_cal_dt BETWEEN  prc.dwh_valid_from AND prc.dwh_valid_to

                                                           INNER JOIN    P_LEW_CORE_AC.v_location_1                              AS bges
                                                                   ON     mov.loc_sid  = bges.loc_sid
                                                                         AND
                                                                          mov.client_id = bges.client_id
                                                                         AND
                                                                          bges.global_loc_type_cd = '9'
                                                                         AND
                                                                          bges.global_loc_id_length =7
                                                                         AND
                                                                          bges.wh_store_mark ='B'

/*                                                         Artikelstamm */
                                                           INNER JOIN    P_LEW_CORE_AC.v_item_hist_1                             AS itm
                                                                   ON     mov.client_id = itm.client_id
                                                                         AND
                                                                          mov.item_sid = itm.item_sid
                                                                         AND
                                                                          CURRENT_DATE BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to

/*                                                         Referenz ueber Fachschluessel weil noch nicht alle SID verfuegbar sind  */
                                                           LEFT OUTER JOIN    P_LEW_PROCESS_AC.v_item_type_ignore_1              AS ig
                                                                        ON     itm.client_id = ig.client_id
                                                                              AND
                                                                               itm.item_type_sid = ig.item_type_sid
                                                                              AND 
                                                                                (
                                                                                  (
                                                                                  ig.client_id IN (33, 34) 
                                                                                  AND ig.item_type_cd  NOT IN ('ZKM', 'ZVM')
                                                                                  )
                                                                                  OR ig.client_id NOT IN (33, 34)
                                                                                ) 
                                                                              AND
                                                                               ig.item_type_grp_cd IN ('BAGLEVY', 'INV')

                                               WHERE        mov.client_id = 1
                                                           AND
                                                            mov.move_type_cd IN  ('911', '912', '913', '914', '921', '922', '923', '924', '925', '926', '927', '928', '963', '964', '987', '988')
                                                           AND
                                                            ig.item_type_sid IS NULL    /*    Ungefilterte Artikelarten */

                                               GROUP BY    1,2,3,4,5
                                          )    AS rtn

                                         FULL OUTER JOIN

                                          (
                                               SELECT      inv.client_id                  AS client_id
,                                                          inv.loc_sid                    AS loc_sid
,                                                          bges.src_wh_id                 AS wh_id
,                                                          inv.item_sid                   AS item_sid
,                                                          inv.dwh_cal_dt                 AS dwh_cal_dt
,                                                          SUM(inv.inv_diff_qty)          AS inv_diff_qty
,                                                          SUM(inv.inv_diff_gross_val)    AS inv_diff_gross_val
,                                                          SUM(inv.inv_diff_net_val)      AS inv_diff_net_val

                                               FROM         P_LEW_CORE_AC.v_inv_diff_record_pos_1                          AS inv

                                                           INNER JOIN    P_LEW_CORE_AC.v_location_1                        AS bges
                                                                   ON     inv.loc_sid  = bges.loc_sid
                                                                         AND
                                                                          inv.client_id = bges.client_id
                                                                         AND
                                                                          bges.global_loc_type_cd = '9'
                                                                         AND
                                                                          bges.global_loc_id_length =7
                                                                         AND
                                                                          bges.wh_store_mark ='B'

/*                                                         Artikelstamm  */
                                                           INNER JOIN    P_LEW_CORE_AC.v_item_hist_1                       AS itm
                                                                   ON     inv.client_id = itm.client_id
                                                                         AND
                                                                          inv.item_sid = itm.item_sid
                                                                         AND
                                                                          CURRENT_DATE BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to

/*                                                         Referenz ueber Fachschluessel weil noch nicht alle SID verfuegbar sind */
                                                           LEFT OUTER JOIN    P_LEW_PROCESS_AC.v_item_type_ignore_1        AS ig
                                                                        ON     itm.client_id = ig.client_id
                                                                              AND
                                                                               itm.item_type_sid = ig.item_type_sid
                                                                              AND 
                                                                                (
                                                                                  (
                                                                                   ig.client_id IN (33, 34) 
                                                                                   AND ig.item_type_cd  NOT IN ('ZKM', 'ZVM')
                                                                                  )
                                                                                  OR ig.client_id NOT IN (33, 34)
                                                                                ) 
                                                                              AND
                                                                               ig.item_type_grp_cd IN ('BAGLEVY', 'INV')

                                               WHERE        inv.client_id = 1
                                                           AND  /* Ungefilterte Artikelarten */
                                                            ig.item_type_sid IS NULL
                                                           AND  /* Nur die Bewegungsarten, welche Inventuren betreffen oder NULL */
                                                            (inv.move_type_cd IN (701, 702, 703, 704, 707, 708, 711, 712, 717, 718) OR inv.move_type_cd IS NULL)
                                               GROUP BY    1,2,3,4,5
                                          )                                                                 AS inv
                                         ON     rtn.client_id = inv.client_id
                                                AND
                                                 rtn.loc_sid = inv.loc_sid
                                                AND
                                                 rtn.item_sid = inv.item_sid
                                                AND
                                                 rtn.dwh_cal_dt = inv.dwh_cal_dt

                                         CROSS JOIN    ( /*  generate 1, 2 for aspect_id */
                                                            SELECT      day_of_month AS id
                                                            FROM        P_LEW_MART_MSI.v_cal_calendarday_1
                                                            WHERE       day_of_month IN (1,2)
                                                            GROUP BY    1
                                                       )                                                    AS cal

                                         INNER JOIN    (
                                                        SELECT
                                                        b.client_id
                                                        , curr_cd_from AS currency_iso_cd
                                                        , curr_cd_to AS to_currency_iso_cd
                                                        , exchange_rate AS rate_currency_exchange
                                                        FROM P_LEW_CORE_AC.v_exchange_rate_known_hist_1 AS b
                                                        INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type_1 AS c
                                                        ON c.client_id             = b.client_id
                                                        AND c.x_rate_type_sid     = b.x_rate_type_sid
                                                        AND c.src_kurst         = '@BEWE'
                                                        WHERE   CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
                                                        AND     CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
                                                        ) AS cry
                                                 ON     COALESCE (inv.client_id, rtn.client_id) = cry.client_id


                                         INNER JOIN    P_LEW_CORE_AC.v_client_migration_per_1                  AS mig
                                                 ON     COALESCE (inv.client_id, rtn.client_id) = mig.client_id

                             WHERE       COALESCE(inv.dwh_cal_dt, rtn.dwh_cal_dt ) BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to  /*  SAP period  */

                             GROUP BY    1,2,3,4,5,7,cry.rate_currency_exchange
                       )    AS unn
           GROUP BY    1,2,3,4,5,7

        UNION ALL
/*-----------------------------------------------------------------------
    This query produces val_indicators just for indicator_id = 315 (Kolli) AND
    BGES (org_type_id = 50 -> acpect_id = 1) on montly-level.
    Zweck:
    - Datenschutz fuer Kolli (Indicator_id = 315) duerfen auf Tagesebene (P_LEW_BIL.v_kpi_day_1) in dieser VIEW
      nicht ausgegeben werden.
    - Kollis werden auf Wochen (P_LEW_MART_MSI.v_kpges_week_wh_merge_1)
      und Monatsebene mit aufgenommen ( P_LEW_MART_MSI.v_kpges_mth_wh_merge_1)
-----------------------------------------------------------------------*/
        SELECT
             imonth.client_id
             , imonth.org_unit_nr AS wh_id
             -- BGES = 50 -> aspect_id = 1; VGES = 60 -> aspect_id = 2
             -- fuer kolli nur aspect_id = 1 relevant, weil nur BGES beruecksichtigt wird
             , CASE WHEN imonth.org_type_id = 50
                    THEN 1
                    ELSE 2
                END AS aspect_id
             , imonth.indicator_id
             , imonth.cy_month
             , imonth.val_indicator
             , 'EUR' AS currency_iso_cd
             , imonth.dat_dayend
        FROM (
        SELECT
                iday.client_id
            -- 50 = BGES; 60 = VGES
              , iday.org_type_id
              , iday.org_unit_nr
              , iday.indicator_id
              , cal.cy_month
              , MAX( iday.dat_dayend ) AS dat_dayend
              , SUM(iday.val_indicator)AS val_indicator
            FROM   P_LEW_CORE_AC.v_wawi_indicator_day_1 AS iday
            INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 AS cal
                ON iday.dat_formdate = cal.cal_dt
             WHERE indicator_id IN (315)
             -- Nur BGES (aspect_id = 1)
             AND iday.org_type_id = 50
             GROUP BY 1,2,3,4,5
        UNION ALL
             SELECT
                iday.client_id
            -- 50 = BGES; 60 = VGES
              , iday.org_type_id
              , iday.org_unit_nr
              , iday.indicator_id
              , cal.cy_month
              , MAX( iday.dat_dayend ) AS dat_dayend
              , SUM(iday.val_indicator)AS val_indicator
            FROM   P_LEW_CORE_AC.v_wawi_indicator_day_1 AS iday
            INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 AS cal
                ON iday.dat_formdate = cal.cal_dt
             WHERE indicator_id IN (322, 325)
             -- Nur BGES (aspect_id = 1)
             AND iday.org_type_id IN (50,60)
             GROUP BY 1,2,3,4,5
         ) AS imonth

/*-----------------------------------------------------------------------
LV fix - dummy_1 values for 2020 and 2021 until it started to operate INC430866, AP0127218
-----------------------------------------------------------------------*/       
      UNION ALL
  
      SELECT
             LV_fix.client_id
             , LV_fix.org_unit_nr AS wh_id
             -- BGES = 50 -> aspect_id = 1; VGES = 60 -> aspect_id = 2
             -- fuer kolli nur aspect_id = 1 relevant, weil nur BGES beruecksichtigt wird
             , CASE WHEN LV_fix.org_type_id = 50
                    THEN 1
                    ELSE 2
                END AS aspect_id
             , LV_fix.indicator_id
             , LV_fix.cy_month
             , LV_fix.val_indicator
             , 'EUR' AS currency_iso_cd
             , LV_fix.dat_dayend
        FROM (
        SELECT
                km.client_id
              , km.org_type_id
              , km.org_unit_nr
              , km.indicator_id
              , cal.cy_month
              , MAX(LAST_DAY(cal.cal_dt)) AS dat_dayend
              , 0 AS val_indicator
            FROM   P_LEW_BIL_AC.v_kpi_month_1 AS km
            CROSS JOIN  P_LEW_CORE_AC.v_cal_calendarday_1 AS cal
            WHERE  (
                    (EXTRACT(YEAR FROM cal.cal_dt) = 2021 AND EXTRACT(Month FROM cal.cal_dt) BETWEEN 1 AND 9)
                    OR EXTRACT(YEAR FROM cal.cal_dt) = 2020
                    )
             AND km.client_id = 20
             AND km.org_type_id IN (50,60)
             
             GROUP BY 1,2,3,4,5

         ) AS LV_fix
      )
;