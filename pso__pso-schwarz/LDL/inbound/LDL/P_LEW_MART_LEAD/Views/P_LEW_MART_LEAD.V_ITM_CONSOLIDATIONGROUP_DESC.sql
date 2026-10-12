CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ITM_CONSOLIDATIONGROUP_DESC COMMENT='Item consolidation description view'
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS.
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY mit V_WAREHOUSE ersetzt
#  1.4  06.08.2020    Roy,Ritanjal             Introduce new country LV
#  1.5  27.11.2020    Morris, Michael          Add Column(s) for  _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.6  30.03.2021    Morris, Michael          cons_item_desc_BE_fr changed to language_id = 2
#                                              20210329_2796_corr_2572
#                                              https://jira.schwarz/browse/REP4-8912
#  1.7  12.04.2021    Morris, Michael          Copied from lew_mart_msi. BGES/VGES functionality added
#                                              20210318_2789_itm_store_cons
#                                              https://jira.schwarz/browse/INTMIG-779
#                                              SF: https://jira.schwarz/browse/INTMIG-1399
#----------------------------------------------------------------------------
*/
(
  client_id                COMMENT 'International client ID'
, wh_id                    COMMENT 'Company ID'
, aspect_id                COMMENT 'Aspect BGES or VGES'
, itm_consgrp_id           COMMENT 'Item consolidation group ID'
, cons_orig_item_nr        COMMENT 'Original consolidation item nr.'
, cons_dat_valid_from_item COMMENT 'Record valid from date'
, cons_fg                  COMMENT 'Consolidation Flag'
, cons_item_desc_AT        COMMENT 'Consolidation item description'
, cons_item_desc_BE        COMMENT 'Consolidation item description'
, cons_item_desc_BE_FR     COMMENT 'Consolidation item description'
, cons_item_desc_BG        COMMENT 'Consolidation item description'
, cons_item_desc_CH        COMMENT 'Consolidation item description'
, cons_item_desc_CY        COMMENT 'Consolidation item description'
, cons_item_desc_CZ        COMMENT 'Consolidation item description'
, cons_item_desc           COMMENT 'Consolidation item description'
, cons_item_desc_DK        COMMENT 'Consolidation item description'
, cons_item_desc_EE        COMMENT 'Consolidation item description'
, cons_item_desc_ES        COMMENT 'Consolidation item description'
, cons_item_desc_FI        COMMENT 'Consolidation item description'
, cons_item_desc_FR        COMMENT 'Consolidation item description'
, cons_item_desc_GB        COMMENT 'Consolidation item description'
, cons_item_desc_GR        COMMENT 'Consolidation item description'
, cons_item_desc_HR        COMMENT 'Consolidation item description'
, cons_item_desc_HU        COMMENT 'Consolidation item description'
, cons_item_desc_IE        COMMENT 'Consolidation item description'
, cons_item_desc_IT        COMMENT 'Consolidation item description'
, cons_item_desc_LT        COMMENT 'Consolidation item description'
, cons_item_desc_LV        COMMENT 'Consolidation item description'
, cons_item_desc_NI        COMMENT 'Consolidation item description'
, cons_item_desc_NL        COMMENT 'Consolidation item description'
, cons_item_desc_DE        COMMENT 'Consolidation item description'
, cons_item_desc_PL        COMMENT 'Consolidation item description'
, cons_item_desc_PT        COMMENT 'Consolidation item description'
, cons_item_desc_RO        COMMENT 'Consolidation item description'
, cons_item_desc_SE        COMMENT 'Consolidation item description'
, cons_item_desc_SI        COMMENT 'Consolidation item description'
, cons_item_desc_SK        COMMENT 'Consolidation item description'
, cons_item_desc_CS        COMMENT 'Consolidation item description'
, cons_item_desc_MT        COMMENT 'Consolidation item description'
, cons_item_desc_US        COMMENT 'Consolidation item description'
, cons_item_desc_RS        COMMENT 'Consolidation item description'
)
AS
SELECT   x.client_id
       , wh.src_wh_id AS wh_id                        /* Gesellschaft */
       , twh.aspect_id
       , x.itm_consgrp_id
       , x.cons_orig_item_nr
       , x.cons_dat_valid_from_item
       , x.cons_fg
       , MAX(CASE WHEN x.language_id = 1        THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_AT
       , MAX(CASE WHEN x.language_id = 2        THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_BE
       , MAX(CASE WHEN x.language_id = 2        THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_BE_FR
       , MAX(CASE WHEN x.language_id = 3        THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_BG
       , MAX(CASE WHEN x.language_id = 4        THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_CH
       , MAX(CASE WHEN x.language_id = 5        THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_CY
       , MAX(CASE WHEN x.language_id = 6        THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_CZ
       /* Because the consolidation description is only available in local language use the description also for language_id = 7.  */
       , MAX(CASE WHEN x.language_id = 7 OR x.cons_fg = 1 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc
       , MAX(CASE WHEN x.language_id = 8        THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_DK
       , MAX(CASE WHEN x.language_id = 9        THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_EE
       , MAX(CASE WHEN x.language_id IN (10,31) THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_ES
       , MAX(CASE WHEN x.language_id = 11       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_FI
       , MAX(CASE WHEN x.language_id = 12       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_FR
       , MAX(CASE WHEN x.language_id = 13       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_GB
       , MAX(CASE WHEN x.language_id IN (14, 5) THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_GR
       , MAX(CASE WHEN x.language_id = 15       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_HR
       , MAX(CASE WHEN x.language_id = 16       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_HU
       , MAX(CASE WHEN x.language_id IN (17,21) THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_IE
       , MAX(CASE WHEN x.language_id IN (18,32) THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_IT
       , MAX(CASE WHEN x.language_id = 19       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_LT
       , MAX(CASE WHEN x.language_id = 20       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_LV
       , MAX(CASE WHEN x.language_id = 21       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_NI
       , MAX(CASE WHEN x.language_id = 22       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_NL
       , MAX(CASE WHEN x.language_id = 23       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_DE
       , MAX(CASE WHEN x.language_id = 24       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_PL
       , MAX(CASE WHEN x.language_id = 25       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_PT
       , MAX(CASE WHEN x.language_id = 26       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_RO
       , MAX(CASE WHEN x.language_id = 27       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_SE
       , MAX(CASE WHEN x.language_id = 28       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_SI
       , MAX(CASE WHEN x.language_id = 29       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_SK
       , MAX(CASE WHEN x.language_id = 31       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_CS
       , MAX(CASE WHEN x.language_id = 32       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_MT
       , MAX(CASE WHEN x.language_id = 33       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_US
       , MAX(CASE WHEN x.language_id = 34       THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_RS
  FROM (
        SELECT   i.client_id
               , i.wh_loc_sid
               , i.itm_consgrp_id
               , CASE WHEN i.itm_consgrp_id = -1 THEN a.orig_item_nr ELSE -1 END                  AS cons_orig_item_nr
               , CASE WHEN i.itm_consgrp_id = -1 THEN a.dat_valid_from ELSE DATE '1900-01-01' END AS cons_dat_valid_from_item
               , CASE WHEN i.itm_consgrp_id = -1 THEN 0 ELSE 1 END                                AS cons_fg
               , COALESCE(oid.language_id, i.client_id)                                           AS language_id
               , MAX(COALESCE(cgp.itm_consgrp_desc, oid.item_desc))                               AS cons_item_desc
          FROM (
  /* A union logic is used instead of a LEFT OUTER JOIN due to performance reasons */
  
                SELECT   i1.client_id
                       , i1.wh_loc_sid
                       , i1.item_sid
                       , c1.itm_consgrp_id
                       , CAST(-1 AS INTEGER) AS cons_item_id
                  FROM P_LEW_CORE_AC.v_wawi_itm_item_wh                  AS i1
  			  
                 INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_consolidation AS c1
                    ON i1.client_id   = c1.client_id
                   AND i1.item_sid    =  c1.item_sid
                   AND i1.wh_loc_sid  =  c1.wh_loc_sid
  			  
                 WHERE CURRENT_DATE BETWEEN c1.dat_rec_start AND c1.dat_rec_end
                 AND   CURRENT_DATE BETWEEN i1.dat_rec_start AND i1.dat_rec_end
                 UNION ALL
                 SELECT   i2.client_id
                        , i2.wh_loc_sid
                        , i2.item_sid
                        , CAST(-1 AS INTEGER) AS itm_consgrp_id
                        , i2.item_sid         AS cons_item_sid
                  FROM P_LEW_CORE_AC.v_wawi_itm_item_wh                 AS i2
                 WHERE NOT EXISTS (
                                  SELECT 1
                                    FROM P_LEW_CORE_AC.v_wawi_itm_item_consolidation AS c2
                                   WHERE i2.client_id   = c2.client_id
                                     AND i2.item_sid    =  c2.item_sid
                                     AND i2.wh_loc_sid  =  c2.wh_loc_sid
                                     AND CURRENT_DATE BETWEEN c2.dat_rec_start AND c2.dat_rec_end
                                  )
                  AND   CURRENT_DATE BETWEEN i2.dat_rec_start AND i2.dat_rec_end
                ) i
          INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act                AS a
             ON a.client_id = i.client_id
            AND a.item_sid  = i.item_sid
  	  
          LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_consolidationgroup AS cgp
            ON cgp.client_id      = i.client_id
           AND cgp.wh_loc_sid     = i.wh_loc_sid
           AND cgp.itm_consgrp_id = i.itm_consgrp_id
           AND CURRENT_DATE BETWEEN cgp.dat_rec_start AND cgp.dat_rec_end
  	  
          LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_orig_item_desc_act AS oid
            ON i.client_id      = oid.client_id
           AND a.orig_item_nr   = oid.orig_item_nr
           AND a.dat_valid_from = oid.dat_valid_from
           AND i.itm_consgrp_id = -1
  	  
          GROUP BY   i.client_id
                   , i.wh_loc_sid
                   , i.itm_consgrp_id
                   , CASE WHEN i.itm_consgrp_id = -1 THEN a.orig_item_nr ELSE -1 END
                   , CASE WHEN i.itm_consgrp_id = -1 THEN a.dat_valid_from ELSE DATE '1900-01-01' END
                   , CASE WHEN i.itm_consgrp_id = -1 THEN 0 ELSE 1 END
                   , COALESCE(oid.language_id, i.client_id)
       ) AS x
 INNER JOIN (
             SELECT DISTINCT   k.client_id
                             , k.loc_sid_wh              AS k_loc_sid_wh
                             , tr.aspect_id
                             , tr.loc_sid_wh             AS tr_loc_sid_wh
             FROM P_LEW_MART_LEAD_AC.v_org_store_merge   AS k
             INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge AS tr
                ON k.client_id   = tr.client_id
               AND k.store_id    = tr.store_id
               AND tr.aspect_id IN (1, 2)
             WHERE k.test_store_fg       = 0
              AND k.aspect_id            = 1
              AND k.wh_id               IS NOT NULL AND k.wh_id > 0
              AND tr.wh_id              IS NOT NULL
              AND k.orig_store_nr       <> k.wh_id
              AND k.dat_closing         IS NULL
              AND k.dat_closing_ovis    IS NULL
              AND k.mis_store_active_fg  = 1
            ) AS twh
    ON x.client_id  = twh.client_id
   AND x.wh_loc_sid = twh.k_loc_sid_wh
/*  Auflösung WH */
 INNER JOIN P_LEW_BIL_AC.v_warehouse AS wh
    ON wh.client_id     = x.client_id
   AND wh.loc_sid_wh    = twh.tr_loc_sid_wh
   AND wh.dwh_actual_fg = 1

 GROUP BY   x.client_id
          , wh.src_wh_id
          , twh.aspect_id
          , x.itm_consgrp_id
          , x.cons_orig_item_nr
          , x.cons_dat_valid_from_item
          , x.cons_fg
;
