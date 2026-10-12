CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ITM_SUBITEMGROUP_DESC_2
AS
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi_v_mat_itm_subitemgroup_desc
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.1  28.11.2017    Proch, Marika            Nutzung des neuen BIL-Layers
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.0  14.02.2018    Ueding,Michael           Initial: Logik aus v_itm_subitmgroup_desc
#                                              Stiftungssprache MIN anstatt MAX
#  1.3  06.08.2020    Roy,Ritanjal             Introduce new country_2 LV
#  1.4  06.08.2021    Bachmann, Torsten        REP3-9088 INC3348712 - UWG Bonkennzahlen describtion
#                                              Change logic for display subitemgroup description
#  1.5  17.12.2021    Morris, Michael          Add Estonia EE
#----------------------------------------------------------------------------
#
*/
SELECT   CAST(TO_NUMBER(src_subitemgrp_cd) AS INTEGER) subitemgroup_id  /* Datentypangleichung */
       , MAX(CASE WHEN client_id = 1  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_AT
       , MAX(CASE WHEN client_id = 2  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_BE
       , MAX(CASE WHEN client_id = 3  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_BG
       , MAX(CASE WHEN client_id = 4  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_CH
       , MAX(CASE WHEN client_id = 5  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_CY
       , MAX(CASE WHEN client_id = 6  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_CZ
       , MIN( subitemgroup_desc_lidl )                                                AS  subitemgroup_desc
       , MAX(CASE WHEN client_id = 8  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_DK
       , MAX(CASE WHEN client_id = 9  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_EE
       , MAX(CASE WHEN client_id = 10 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_ES
       , MAX(CASE WHEN client_id = 11 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_FI
       , MAX(CASE WHEN client_id = 12 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_FR
       , MAX(CASE WHEN client_id = 13 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_GB
       , MAX(CASE WHEN client_id = 14 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_GR
       , MAX(CASE WHEN client_id = 15 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_HR
       , MAX(CASE WHEN client_id = 16 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_HU
       , MAX(CASE WHEN client_id = 17 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_IE
       , MAX(CASE WHEN client_id = 18 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_IT
       , MAX(CASE WHEN client_id = 19 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_LT
       , MAX(CASE WHEN client_id = 21 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_NI
       , MAX(CASE WHEN client_id = 22 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_NL
       , MAX(CASE WHEN client_id = 20 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_LV
       , MAX(CASE WHEN client_id = 23 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_DE
       , MAX(CASE WHEN client_id = 24 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_PL
       , MAX(CASE WHEN client_id = 25 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_PT
       , MAX(CASE WHEN client_id = 26 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_RO
       , MAX(CASE WHEN client_id = 27 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_SE
       , MAX(CASE WHEN client_id = 28 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_SI
       , MAX(CASE WHEN client_id = 29 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_SK
       , MAX(CASE WHEN client_id = 31 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_CS
       , MAX(CASE WHEN client_id = 32 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_MT
       , MAX(CASE WHEN client_id = 33 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_US
       , MAX(CASE WHEN client_id = 34 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_desc_RS
       , MAX(CASE WHEN client_id = 1  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_AT
       , MAX(CASE WHEN client_id = 2  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_BE
       , MAX(CASE WHEN client_id = 3  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_BG
       , MAX(CASE WHEN client_id = 4  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_CH
       , MAX(CASE WHEN client_id = 5  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_CY
       , MAX(CASE WHEN client_id = 6  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_CZ
       , MIN( subitemgroup_desc_lidl )                                                AS subitemgroup_short_desc
       , MAX(CASE WHEN client_id = 8  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_DK
       , MAX(CASE WHEN client_id = 9  THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_EE
       , MAX(CASE WHEN client_id = 10 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_ES
       , MAX(CASE WHEN client_id = 11 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_FI
       , MAX(CASE WHEN client_id = 12 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_FR
       , MAX(CASE WHEN client_id = 13 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_GB
       , MAX(CASE WHEN client_id = 14 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_GR
       , MAX(CASE WHEN client_id = 15 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_HR
       , MAX(CASE WHEN client_id = 16 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_HU
       , MAX(CASE WHEN client_id = 17 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_IE
       , MAX(CASE WHEN client_id = 18 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_IT
       , MAX(CASE WHEN client_id = 19 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_LT
       , MAX(CASE WHEN client_id = 21 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_NI
       , MAX(CASE WHEN client_id = 20 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_LV
       , MAX(CASE WHEN client_id = 22 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_NL
       , MAX(CASE WHEN client_id = 23 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_DE
       , MAX(CASE WHEN client_id = 24 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_PL
       , MAX(CASE WHEN client_id = 25 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_PT
       , MAX(CASE WHEN client_id = 26 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_RO
       , MAX(CASE WHEN client_id = 27 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_SE
       , MAX(CASE WHEN client_id = 28 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_SI
       , MAX(CASE WHEN client_id = 29 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_SK
       , MAX(CASE WHEN client_id = 31 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_CS
       , MAX(CASE WHEN client_id = 32 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_MT
       , MAX(CASE WHEN client_id = 33 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_US
       , MAX(CASE WHEN client_id = 34 THEN  subitemgroup_desc_default ELSE NULL END ) AS subitemgroup_short_desc_RS
  FROM (
        SELECT   client_id
               , src_subitemgrp_cd
               , subitemgroup_desc_default
               , FIRST_VALUE(subitemgroup_desc_lidl IGNORE NULLS) OVER (PARTITION BY src_subitemgrp_cd ORDER BY CASE WHEN subitemgroup_desc_lidl LIKE TRIM(src_subitemgrp_cd) || '%' THEN 1 ELSE 2 END, subitemgroup_desc_lidl) AS subitemgroup_desc_lidl
          FROM P_LEW_BIL_AC.v_subitemgroup_2
       ) AS tmp
 GROUP BY 1
;