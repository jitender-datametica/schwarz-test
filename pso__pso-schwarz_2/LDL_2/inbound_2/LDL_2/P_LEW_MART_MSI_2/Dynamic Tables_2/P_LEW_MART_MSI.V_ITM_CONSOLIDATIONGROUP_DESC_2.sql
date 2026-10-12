
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_CONSOLIDATIONGROUP_DESC_2 COMMENT = 'Multi language Item_2 Consolidation Group descriptions'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_2 mit V_WAREHOUSE_2 ersetzt
#  1.4  06.08.2020    Roy,Ritanjal             Introduce new country_2 LV
#  1.5  27.11.2020    Morris, Michael          Add Column(s) for  _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.6  30.03.2021    Morris, Michael          cons_item_desc_BE_fr changed to language_id = 2
#                                              20210329_2796_corr_2572
#                                              https://jira.schwarz/browse/REP4-8912
#  1.7  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
    client_id                COMMENT 'Landeskennzeichen'
  , wh_id                    COMMENT 'Gesellschafts-Nr.'
  , itm_consgrp_id           COMMENT 'BGES (1)/VGES (2)'
  , cons_orig_item_nr        COMMENT 'Konsolidierungsobergruppennummer'
  , cons_dat_valid_from_item COMMENT 'Gültig von Datum'
  , cons_fg                  COMMENT 'Consolidierungs-Gruppen Flag'
  , cons_item_desc_AT        COMMENT 'Consolidierungsgruppe Bezeichnung '
  , cons_item_desc_BE        COMMENT 'Consolidierungsgruppe Bezeichnung BE'
  , cons_item_desc_BE_FR     COMMENT 'Consolidierungsgruppe Bezeichnung BE_FR'
  , cons_item_desc_BG        COMMENT 'Consolidierungsgruppe Bezeichnung BG'
  , cons_item_desc_CH        COMMENT 'Consolidierungsgruppe Bezeichnung CH'
  , cons_item_desc_CY        COMMENT 'Consolidierungsgruppe Bezeichnung CY'
  , cons_item_desc_CZ        COMMENT 'Consolidierungsgruppe Bezeichnung CZ'
  , cons_item_desc           COMMENT 'Consolidierungsgruppe Bezeichnung'
  , cons_item_desc_DK        COMMENT 'Consolidierungsgruppe Bezeichnung DK'
  , cons_item_desc_EE        COMMENT 'Consolidierungsgruppe Bezeichnung EE'
  , cons_item_desc_ES        COMMENT 'Consolidierungsgruppe Bezeichnung ES'
  , cons_item_desc_FI        COMMENT 'Consolidierungsgruppe Bezeichnung FI'
  , cons_item_desc_FR        COMMENT 'Consolidierungsgruppe Bezeichnung FR'
  , cons_item_desc_GB        COMMENT 'Consolidierungsgruppe Bezeichnung GB'
  , cons_item_desc_GR        COMMENT 'Consolidierungsgruppe Bezeichnung GR'
  , cons_item_desc_HR        COMMENT 'Consolidierungsgruppe Bezeichnung HR'
  , cons_item_desc_HU        COMMENT 'Consolidierungsgruppe Bezeichnung HU'
  , cons_item_desc_IE        COMMENT 'Consolidierungsgruppe Bezeichnung IE'
  , cons_item_desc_IT        COMMENT 'Consolidierungsgruppe Bezeichnung IT'
  , cons_item_desc_LT        COMMENT 'Consolidierungsgruppe Bezeichnung LT'
  , cons_item_desc_LV        COMMENT 'Consolidierungsgruppe Bezeichnung LV'
  , cons_item_desc_NI        COMMENT 'Consolidierungsgruppe Bezeichnung NI'
  , cons_item_desc_NL        COMMENT 'Consolidierungsgruppe Bezeichnung NL'
  , cons_item_desc_DE        COMMENT 'Consolidierungsgruppe Bezeichnung DE'
  , cons_item_desc_PL        COMMENT 'Consolidierungsgruppe Bezeichnung PL'
  , cons_item_desc_PT        COMMENT 'Consolidierungsgruppe Bezeichnung PT'
  , cons_item_desc_RO        COMMENT 'Consolidierungsgruppe Bezeichnung RO'
  , cons_item_desc_SE        COMMENT 'Consolidierungsgruppe Bezeichnung SE'
  , cons_item_desc_SI        COMMENT 'Consolidierungsgruppe Bezeichnung SI'
  , cons_item_desc_SK        COMMENT 'Consolidierungsgruppe Bezeichnung SK'
  , cons_item_desc_CS        COMMENT 'Consolidierungsgruppe Bezeichnung CS'
  , cons_item_desc_MT        COMMENT 'Consolidierungsgruppe Bezeichnung MT'
  , cons_item_desc_US        COMMENT 'Consolidierungsgruppe Bezeichnung US'
  , cons_item_desc_RS        COMMENT 'Consolidierungsgruppe Bezeichnung RS_2'
 )

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT   x.client_id
       , wh.src_wh_id                                                                           AS wh_id       /* Gesellschaft */
       , x.itm_consgrp_id
       , x.cons_orig_item_nr
       , x.cons_dat_valid_from_item
       , x.cons_fg
       , MAX(CASE WHEN x.language_id = 1                  THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_AT
       , MAX(CASE WHEN x.language_id = 2                  THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_BE
       , MAX(CASE WHEN x.language_id = 12                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_BE_FR
       , MAX(CASE WHEN x.language_id = 3                  THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_BG
       , MAX(CASE WHEN x.language_id = 4                  THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_CH
       , MAX(CASE WHEN x.language_id = 5                  THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_CY
       , MAX(CASE WHEN x.language_id = 6                  THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_CZ
       , MAX(CASE WHEN x.language_id = 7 OR x.cons_fg = 1 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc
       , MAX(CASE WHEN x.language_id = 8                  THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_DK
       , MAX(CASE WHEN x.language_id = 9                  THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_EE
       , MAX(CASE WHEN x.language_id IN (10,31)           THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_ES
       , MAX(CASE WHEN x.language_id = 11                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_FI
       , MAX(CASE WHEN x.language_id = 12                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_FR
       , MAX(CASE WHEN x.language_id = 13                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_GB
       , MAX(CASE WHEN x.language_id IN (14, 5)           THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_GR
       , MAX(CASE WHEN x.language_id = 15                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_HR
       , MAX(CASE WHEN x.language_id = 16                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_HU
       , MAX(CASE WHEN x.language_id IN (17,21)           THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_IE
       , MAX(CASE WHEN x.language_id IN (18,32)           THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_IT
       , MAX(CASE WHEN x.language_id = 19                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_LT
       , MAX(CASE WHEN x.language_id = 20                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_LV
       , MAX(CASE WHEN x.language_id = 21                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_NI
       , MAX(CASE WHEN x.language_id = 22                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_NL
       , MAX(CASE WHEN x.language_id = 23                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_DE
       , MAX(CASE WHEN x.language_id = 24                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_PL
       , MAX(CASE WHEN x.language_id = 25                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_PT
       , MAX(CASE WHEN x.language_id = 26                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_RO
       , MAX(CASE WHEN x.language_id = 27                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_SE
       , MAX(CASE WHEN x.language_id = 28                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_SI
       , MAX(CASE WHEN x.language_id = 29                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_SK
       , MAX(CASE WHEN x.language_id = 31                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_CS
       , MAX(CASE WHEN x.language_id = 32                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_MT
       , MAX(CASE WHEN x.language_id = 33                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_US
       , MAX(CASE WHEN x.language_id = 34                 THEN x.cons_item_desc ELSE NULL END ) AS cons_item_desc_RS
  FROM (
        SELECT    i.client_id
                , i.wh_loc_sid
                , i.itm_consgrp_id
                , CASE WHEN i.itm_consgrp_id = -1 THEN a.orig_item_nr   ELSE -1                END AS cons_orig_item_nr
                , CASE WHEN i.itm_consgrp_id = -1 THEN a.dat_valid_from ELSE DATE '1900-01-01' END AS cons_dat_valid_from_item
                , CASE WHEN i.itm_consgrp_id = -1 THEN 0                ELSE 1                 END AS cons_fg
                , COALESCE(oid.language_id, i.client_id)                                           AS language_id
                , MAX(COALESCE(cgp.itm_consgrp_desc, oid.item_desc))                               AS cons_item_desc
          FROM (
                /* A union logic is used instead of a LEFT OUTER JOIN due to performance reasons. */
                SELECT   i1.client_id
                       , i1.wh_loc_sid
                       , i1.item_sid
                       , c1.itm_consgrp_id
                       , CAST(-1 AS INTEGER) AS cons_item_id
                  FROM P_LEW_CORE_AC.v_wawi_itm_item_wh_2 i1
                 INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_consolidation_2 AS c1
                    ON i1.client_id   = c1.client_id
                   AND i1.item_sid    =  c1.item_sid
                   AND i1.wh_loc_sid  =  c1.wh_loc_sid
                 WHERE CURRENT_DATE BETWEEN c1.dat_rec_start AND c1.dat_rec_end
                   AND CURRENT_DATE BETWEEN i1.dat_rec_start AND i1.dat_rec_end
                 UNION ALL
                SELECT   i2.client_id
                       , i2.wh_loc_sid
                       , i2.item_sid
                       , CAST(-1 AS INTEGER) AS itm_consgrp_id
                       , i2.item_sid AS cons_item_sid
                  FROM P_LEW_CORE_AC.v_wawi_itm_item_wh_2 AS i2
                 WHERE NOT EXISTS (
                                 SELECT 1
                                     FROM P_LEW_CORE_AC.v_wawi_itm_item_consolidation_2 AS c2
                                    WHERE i2.client_id = c2.client_id
                                      AND i2.item_sid  =  c2.item_sid
                                      AND i2.wh_loc_sid  =  c2.wh_loc_sid
                                      AND CURRENT_DATE BETWEEN c2.dat_rec_start AND c2.dat_rec_end
                                  )
                   AND CURRENT_DATE BETWEEN i2.dat_rec_start AND i2.dat_rec_end
               ) AS i
         INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act_2 AS a
            ON a.client_id = i.client_id
           AND a.item_sid  =  i.item_sid
      
          LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_consolidationgroup_2 AS cgp
            ON cgp.client_id      = i.client_id
           AND cgp.wh_loc_sid     =  i.wh_loc_sid
           AND cgp.itm_consgrp_id = i.itm_consgrp_id
           AND CURRENT_DATE BETWEEN cgp.dat_rec_start AND cgp.dat_rec_end
      
          LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_orig_item_desc_act_2 AS oid
            ON i.client_id      = oid.client_id
           AND a.orig_item_nr   = oid.orig_item_nr
           AND a.dat_valid_from = oid.dat_valid_from
           AND i.itm_consgrp_id = -1
      
         GROUP BY   i.client_id
                   ,i.wh_loc_sid
                   ,i.itm_consgrp_id
                   ,CASE WHEN i.itm_consgrp_id = -1 THEN a.orig_item_nr   ELSE -1 END
                   ,CASE WHEN i.itm_consgrp_id = -1 THEN a.dat_valid_from ELSE DATE '1900-01-01' END
                   ,CASE WHEN i.itm_consgrp_id = -1 THEN 0                ELSE 1 END
                   ,COALESCE(oid.language_id, i.client_id)
       ) AS x
/* Auflösung WH */
  INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
     ON wh.client_id     = x.client_id
    AND wh.loc_sid_wh    = x.wh_loc_sid
    AND wh.dwh_actual_fg = 1
GROUP BY   x.client_id
         , wh.src_wh_id
         , x.itm_consgrp_id
         , x.cons_orig_item_nr
         , x.cons_dat_valid_from_item
         , x.cons_fg
;
