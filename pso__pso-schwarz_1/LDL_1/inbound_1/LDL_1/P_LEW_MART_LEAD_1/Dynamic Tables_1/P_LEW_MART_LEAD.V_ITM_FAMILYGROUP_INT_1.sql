CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_ITM_FAMILYGROUP_INT_1 COMMENT = 'View used for itemfamilygroup international information'
/*
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0   26-04-2019   Aleksander Bialek  Patch_Number: 2044
#                                       INITIAL VERSION
#                                       This is workaround version for Saeule Tool
#                                       In near future there will be something new
#                                       in Bil-layer
# 1.1   03.01.2022   Morris, Michae     Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  subitemgroup_id     COMMENT 'Identifier for subitemgroup'
, src_familygrp_cd    COMMENT 'Full Identifier of subitemgroup_id abd family_cd'
, family_cd           COMMENT 'Item_1 family code'
, item_family_desc    COMMENT 'International family description'
, item_family_desc_AT COMMENT 'Individual country_1 description'
, item_family_desc_BE COMMENT 'Individual country_1 description'
, item_family_desc_BG COMMENT 'Individual country_1 description'
, item_family_desc_CH COMMENT 'Individual country_1 description'
, item_family_desc_CY COMMENT 'Individual country_1 description'
, item_family_desc_CZ COMMENT 'Individual country_1 description'
, item_family_desc_DK COMMENT 'Individual country_1 description'
, item_family_desc_EE COMMENT 'Individual country_1 description'
, item_family_desc_ES COMMENT 'Individual country_1 description'
, item_family_desc_FI COMMENT 'Individual country_1 description'
, item_family_desc_FR COMMENT 'Individual country_1 description'
, item_family_desc_GB COMMENT 'Individual country_1 description'
, item_family_desc_GR COMMENT 'Individual country_1 description'
, item_family_desc_HR COMMENT 'Individual country_1 description'
, item_family_desc_HU COMMENT 'Individual country_1 description'
, item_family_desc_IE COMMENT 'Individual country_1 description'
, item_family_desc_IT COMMENT 'Individual country_1 description'
, item_family_desc_LT COMMENT 'Individual country_1 description'
, item_family_desc_LV COMMENT 'Individual country_1 description'
, item_family_desc_NI COMMENT 'Individual country_1 description'
, item_family_desc_NL COMMENT 'Individual country_1 description'
, item_family_desc_DE COMMENT 'Individual country_1 description'
, item_family_desc_PL COMMENT 'Individual country_1 description'
, item_family_desc_PT COMMENT 'Individual country_1 description'
, item_family_desc_RO COMMENT 'Individual country_1 description'
, item_family_desc_SE COMMENT 'Individual country_1 description'
, item_family_desc_SI COMMENT 'Individual country_1 description'
, item_family_desc_SK COMMENT 'Individual country_1 description'
, item_family_desc_CS COMMENT 'Individual country_1 description'
, item_family_desc_MT COMMENT 'Individual country_1 description'
, item_family_desc_US COMMENT 'Individual country_1 description'
, item_family_desc_RS COMMENT 'Individual country_1 description'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
SELECT   ifgh.sub_item_grp_cd                                                           AS subitemgroup_id
       , ifg.src_familygrp_cd                                                           AS src_familygrp_cd
       , SUBSTR(ifg.src_familygrp_cd, POSITION('.',ifg.src_familygrp_cd) +1)            AS family_cd
       , MAX(CASE WHEN ifgd.client_id = 23 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc
       , MAX(CASE WHEN ifgd.client_id =  1 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_AT
       , MAX(CASE WHEN ifgd.client_id =  2 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_BE
       , MAX(CASE WHEN ifgd.client_id =  3 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_BG
       , MAX(CASE WHEN ifgd.client_id =  4 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_CH
       , MAX(CASE WHEN ifgd.client_id =  5 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_CY
       , MAX(CASE WHEN ifgd.client_id =  6 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_CZ
       , MAX(CASE WHEN ifgd.client_id =  8 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_DK
       , MAX(CASE WHEN ifgd.client_id =  9 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_EE
       , MAX(CASE WHEN ifgd.client_id = 10 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_ES
       , MAX(CASE WHEN ifgd.client_id = 11 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_FI
       , MAX(CASE WHEN ifgd.client_id = 12 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_FR
       , MAX(CASE WHEN ifgd.client_id = 13 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_GB
       , MAX(CASE WHEN ifgd.client_id = 14 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_GR
       , MAX(CASE WHEN ifgd.client_id = 15 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_HR
       , MAX(CASE WHEN ifgd.client_id = 16 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_HU
       , MAX(CASE WHEN ifgd.client_id = 17 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_IE
       , MAX(CASE WHEN ifgd.client_id = 18 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_IT
       , MAX(CASE WHEN ifgd.client_id = 19 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_LT
       , MAX(CASE WHEN ifgd.client_id = 20 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_LV
       , MAX(CASE WHEN ifgd.client_id = 21 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_NI
       , MAX(CASE WHEN ifgd.client_id = 22 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_NL
       , MAX(CASE WHEN ifgd.client_id = 23 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_DE
       , MAX(CASE WHEN ifgd.client_id = 24 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_PL
       , MAX(CASE WHEN ifgd.client_id = 25 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_PT
       , MAX(CASE WHEN ifgd.client_id = 26 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_RO
       , MAX(CASE WHEN ifgd.client_id = 27 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_SE
       , MAX(CASE WHEN ifgd.client_id = 28 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_SI
       , MAX(CASE WHEN ifgd.client_id = 29 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_SK
       , MAX(CASE WHEN ifgd.client_id = 31 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_CS
       , MAX(CASE WHEN ifgd.client_id = 32 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_MT
       , MAX(CASE WHEN ifgd.client_id = 33 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_US
       , MAX(CASE WHEN ifgd.client_id = 34 THEN ifgd.item_fam_grp_descr ELSE NULL END ) AS item_family_desc_RS
  FROM P_LEW_CORE_AC.v_item_familygroup_hist_1       AS ifgh
 INNER JOIN P_LEW_CORE_AC.v_item_familygroup_descr_1 AS ifgd
    ON ifgh.item_fam_grp_sid = ifgd.item_fam_grp_sid
 INNER JOIN P_LEW_CORE_AC.v_item_familygroup_1       AS ifg
    ON ifgd.item_fam_grp_sid = ifg.item_fam_grp_sid
 WHERE CURRENT_DATE BETWEEN ifgh.dwh_valid_from AND ifgh.dwh_valid_to
   /* international language level */
   AND ifgd.lang_cd = '@'
 GROUP BY   subitemgroup_id
          , ifg.src_familygrp_cd
          , family_cd
;
