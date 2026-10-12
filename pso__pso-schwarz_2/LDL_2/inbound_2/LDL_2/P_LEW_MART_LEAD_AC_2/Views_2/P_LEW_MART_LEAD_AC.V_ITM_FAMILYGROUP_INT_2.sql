CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ITM_FAMILYGROUP_INT_2 COMMENT = 'View used for itemfamilygroup international information'
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
#  1.1  10.08.2020   Roy,Ritanjal       Introduce new country_2 Latviya
#  1.2  04.01.2022   Michael Morris     Added Estonia EE
#-----------------------------------------------------------------------------
*/
(
  subitemgroup_id      COMMENT 'Identifier for subitemgroup'
, src_familygrp_cd     COMMENT 'Full Identifier of subitemgroup_id abd family_cd'
, family_cd            COMMENT 'Item_2 family code'
, item_family_desc     COMMENT 'International family description'
, item_family_desc_AT  COMMENT 'Individual country_2 description'
, item_family_desc_BE  COMMENT 'Individual country_2 description'
, item_family_desc_BG  COMMENT 'Individual country_2 description'
, item_family_desc_CH  COMMENT 'Individual country_2 description'
, item_family_desc_CY  COMMENT 'Individual country_2 description'
, item_family_desc_CZ  COMMENT 'Individual country_2 description'
, item_family_desc_DK  COMMENT 'Individual country_2 description'
, item_family_desc_EE  COMMENT 'Individual country_2 description'
, item_family_desc_ES  COMMENT 'Individual country_2 description'
, item_family_desc_FI  COMMENT 'Individual country_2 description'
, item_family_desc_FR  COMMENT 'Individual country_2 description'
, item_family_desc_GB  COMMENT 'Individual country_2 description'
, item_family_desc_GR  COMMENT 'Individual country_2 description'
, item_family_desc_HR  COMMENT 'Individual country_2 description'
, item_family_desc_HU  COMMENT 'Individual country_2 description'
, item_family_desc_IE  COMMENT 'Individual country_2 description'
, item_family_desc_IT  COMMENT 'Individual country_2 description'
, item_family_desc_LT  COMMENT 'Individual country_2 description'
, item_family_desc_LV  COMMENT 'Individual country_2 description'
, item_family_desc_NI  COMMENT 'Individual country_2 description'
, item_family_desc_NL  COMMENT 'Individual country_2 description'
, item_family_desc_DE  COMMENT 'Individual country_2 description'
, item_family_desc_PL  COMMENT 'Individual country_2 description'
, item_family_desc_PT  COMMENT 'Individual country_2 description'
, item_family_desc_RO  COMMENT 'Individual country_2 description'
, item_family_desc_SE  COMMENT 'Individual country_2 description'
, item_family_desc_SI  COMMENT 'Individual country_2 description'
, item_family_desc_SK  COMMENT 'Individual country_2 description'
, item_family_desc_CS  COMMENT 'Individual country_2 description'
, item_family_desc_MT  COMMENT 'Individual country_2 description'
, item_family_desc_US  COMMENT 'Individual country_2 description'
, item_family_desc_RS  COMMENT 'Individual country_2 description'
)
AS
SELECT   subitemgroup_id
       , src_familygrp_cd
       , family_cd
       , item_family_desc
       , item_family_desc_AT
       , item_family_desc_BE
       , item_family_desc_BG
       , item_family_desc_CH
       , item_family_desc_CY
       , item_family_desc_CZ
       , item_family_desc_DK
       , item_family_desc_EE
       , item_family_desc_ES
       , item_family_desc_FI
       , item_family_desc_FR
       , item_family_desc_GB
       , item_family_desc_GR
       , item_family_desc_HR
       , item_family_desc_HU
       , item_family_desc_IE
       , item_family_desc_IT
       , item_family_desc_LT
       , item_family_desc_LV
       , item_family_desc_NI
       , item_family_desc_NL
       , item_family_desc_DE
       , item_family_desc_PL
       , item_family_desc_PT
       , item_family_desc_RO
       , item_family_desc_SE
       , item_family_desc_SI
       , item_family_desc_SK
       , item_family_desc_CS
       , item_family_desc_MT
       , item_family_desc_US
       , item_family_desc_RS
  FROM P_LEW_MART_LEAD.v_itm_familygroup_int_2
;