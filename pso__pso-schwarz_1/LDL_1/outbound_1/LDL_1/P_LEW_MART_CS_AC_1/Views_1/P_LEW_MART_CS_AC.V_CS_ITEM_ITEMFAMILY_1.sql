/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_ITEM_ITEMFAMILY_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/




/* #DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_cs_item_itemfamily_1 (client_id, orig_item_nr, case_size,
item_familygroup_id, itemfamily_cd, language_iso_cd, country_iso_cd, valid_from, valid_until, last_refresh) AS SELECT
 client_id,
 orig_item_nr,
 case_size,
 item_familygroup_id,
 itemfamily_cd,
 language_iso_cd,
 country_iso_cd,
 valid_from,
 valid_until,
 last_refresh
FROM ldl_p_lew_mart_cs.v_cs_item_itemfamily_1;


