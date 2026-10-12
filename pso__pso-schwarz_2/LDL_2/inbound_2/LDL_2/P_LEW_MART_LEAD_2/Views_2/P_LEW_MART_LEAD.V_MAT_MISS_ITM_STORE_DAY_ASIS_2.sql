/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_MAT_MISS_ITM_STORE_DAY_ASIS_2
#----------------------------------------------------------------------------
# History:
#  1.0  09.12.2017    Kiran N                  Initial Version
#  1.1  09.03.2018    Aparna R                 Pointed calendar_2 table to core layer
#  1.2  28.06.2018    Davis,Mike               replace lew_core_ac.v_wawi_agg_store_day_item_ejr with lew_bil_ac.v_agg_pos_store_item_day_2
#  1.3  27.03.2019    Thole,Jens               replace stock-base to new bil-object
#  1.4  19.06.2019    Kiran N                  Added Comments
#                                              Patch 20190408_2028_Fehlartikel_system_updates
#                                              https://jira-lidl-public.pixsoftware.de/browse/LEAD05-3383
#                                              https://jira-lidl-public.pixsoftware.de/browse/IDMO-1695
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_MISS_ITM_STORE_DAY_ASIS_2 COMMENT = 'View'
      (
            client_id            COMMENT 'MIS Client ID'
,           loc_sid_store        COMMENT 'S-Key der Location_2, hier der Filiale'
,           item_sid             COMMENT 'S-Key fuer Item_2 Id'
,           wh_loc_sid           COMMENT 'S-Key fuer Gesellschaftsnummer'
,           dat_formdate         COMMENT 'Bezugsdatum'
,           cy_month             COMMENT 'Monat_2 des Geschaeftsjahres im Format "JJJJMM"'
,           cy_partial_week_id   COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
,           cy_week              COMMENT 'Geschaeftsjahr - Woche_2 Id - Format "JJJJMM"'
,           busyear              COMMENT 'Geschaeftsjahr'
,           miss_item_fg         COMMENT 'Flag fuer Fehlartikel Filiale'
      )
     AS 
      (
           SELECT      Stc.client_id                                                     AS client_id
,                      Stc.st_loc_sid                                                    AS loc_sid_store
,                      Stc.item_sid                                                      AS item_sid
,                      Org.loc_sid_wh                                                    AS wh_loc_sid
,                      Stc.dat_formdate                                                  AS dat_formdate
,                      Cal.cy_month                                                      AS cy_month
,                      Cal.cy_week_part                                                  AS cy_partial_week_id
,                      Cal.cy_week                                                       AS cy_week
,                      Cal.busyear                                                       AS busyear
,                      CASE
                         WHEN (Ejr.client_id IS NULL AND Deli.client_id IS NULL) THEN
                           1
                         ELSE
                           0
                       END                                                               AS miss_item_fg

           FROM         (
                              SELECT      Wssi.client_id                                         AS client_id
,                                         Wssi.loc_sid                                           AS st_loc_sid
,                                         Wssi.item_sid                                          AS item_sid
,                                         Wssi.dwh_cal_dt                                        AS dat_formdate
,                                          Wssi.stock_real_qty                                     AS qty_stc_real
                              FROM        P_LEW_BIL_AC.v_stock_location_item_2       AS Wssi
                              WHERE Wssi.stock_real_qty <=0
                        )                                                  AS Stc

                       INNER JOIN
                        P_LEW_CORE_AC.v_cal_calendarday_2                    AS Cal
                       ON
                        Cal.cal_dt = Stc.dat_formdate

                       INNER JOIN
                        P_LEW_BIL_AC.v_item_2                                AS Itm
                       ON
                         Stc.client_id = Itm.client_id
                        AND
                         Stc.item_sid = Itm.item_sid
                        AND
                         Stc.dat_formdate BETWEEN Itm.dwh_valid_from AND Itm.dwh_valid_to

                       INNER JOIN
                        P_LEW_CORE_AC.v_subitemgroup_hist_2                  AS SItm
                       ON
                         Itm.sub_item_grp_sid_asis = SItm.sub_item_grp_sid
                        AND
                         Stc.dat_formdate BETWEEN SItm.dwh_valid_from AND SItm.dwh_valid_to

/*                     no sales_2*/
                       LEFT OUTER JOIN
                        P_LEW_BIL_AC.v_agg_pos_store_item_day_2              AS Ejr
                       ON
                         Ejr.client_id       =    Stc.client_id
                        AND
                         Ejr.loc_sid_store      =    Stc.st_loc_sid
                        AND
                         Ejr.item_sid        =    Stc.item_sid
                        AND
                         Ejr.dwh_cal_dt    =    Stc.dat_formdate

/*                     no delivery or supply*/
                       LEFT OUTER JOIN
                        P_LEW_BIL_AC.v_agg_deliv_base_2                      AS Deli
                       ON
                         Stc.client_id       =    Deli.client_id
                        AND
                         Stc.st_loc_sid      =    Deli.loc_sid_store
                        AND
                         Stc.item_sid        =    Deli.item_sid
                        AND
                         Stc.dat_formdate    =    Deli.dat_formdate

                       LEFT OUTER JOIN
                        P_LEW_BIL_AC.v_org_store_merge_2                     AS Org
                       ON
                         Stc.client_id      = Org.client_id
                        AND
                         Stc.st_loc_sid    = Org.loc_sid_store


/*                     WGI (item_2 Groups) 1, 3, 4 , 5, 6 and 9*/
           WHERE        SItm.item_grp_int_cd IN (1,3,4,5,6,9)
                       AND
                        Org.aspect_id = 1


           GROUP BY    1,2,3,4,5,6,7,8,9,10
      )
;