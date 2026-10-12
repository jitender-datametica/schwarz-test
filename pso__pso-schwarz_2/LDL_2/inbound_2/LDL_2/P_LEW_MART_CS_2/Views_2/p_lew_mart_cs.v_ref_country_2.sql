/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_ref_country_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_ref_country_2 (
  int_id
 ,country_id
 ,country_iso_cd
 ,cluster_id
 ,sorting_order
 ,dashboard_relevant_fg
 ,country_desc_AT
 ,country_desc_BE
 ,country_desc_BG
 ,country_desc_CH
 ,country_desc_CY
 ,country_desc_CZ
 ,country_desc
 ,country_desc_DK
 ,country_desc_ES
 ,country_desc_FI
 ,country_desc_FR
 ,country_desc_GB
 ,country_desc_GR
 ,country_desc_HR
 ,country_desc_HU
 ,country_desc_IE
 ,country_desc_IT
 ,country_desc_LT
 ,country_desc_NI
 ,country_desc_NL
 ,country_desc_DE
 ,country_desc_PL
 ,country_desc_PT
 ,country_desc_RO
 ,country_desc_SE
 ,country_desc_SI
 ,country_desc_SK
 ,country_desc_CS
 ,country_desc_MT
 ,country_desc_US
 ,country_desc_RS
) AS
SELECT 
  int_id
 ,country_id
 ,country_iso_cd
 ,cluster_id
 ,sorting_order
 ,dashboard_relevant_fg
 ,country_desc_AT
 ,country_desc_BE
 ,country_desc_BG
 ,country_desc_CH
 ,country_desc_CY
 ,country_desc_CZ
 ,country_desc
 ,country_desc_DK
 ,country_desc_ES
 ,country_desc_FI
 ,country_desc_FR
 ,country_desc_GB
 ,country_desc_GR
 ,country_desc_HR
 ,country_desc_HU
 ,country_desc_IE
 ,country_desc_IT
 ,country_desc_LT
 ,country_desc_NI
 ,country_desc_NL
 ,country_desc_DE
 ,country_desc_PL
 ,country_desc_PT
 ,country_desc_RO
 ,country_desc_SE
 ,country_desc_SI
 ,country_desc_SK
 ,country_desc_CS
 ,country_desc_MT
 ,country_desc_US
 ,country_desc_RS
FROM p_lew_mart_msi.v_ref_country_2
;