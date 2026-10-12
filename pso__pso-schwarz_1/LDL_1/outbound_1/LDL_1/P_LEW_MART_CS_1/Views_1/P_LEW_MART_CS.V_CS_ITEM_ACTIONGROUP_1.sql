/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_ACTIONGROUP_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item_actiongroup_1 (client_id, country_iso_cd, item_actiongroup_id,
item_sub_actiongroup_id, orig_item_nr, case_size, valid_from, valid_until, last_refresh) AS SELECT client_id,
 src_country_lidl_cd AS country_iso_cd,
 item_actiongroup_id,
 item_sub_actiongroup_id,
 orig_item_nr,
 case_size,
 valid_from,
 valid_until,
 CURRENT_TIMESTAMP() AS last_refresh
FROM ldl_p_lew_mart_cs.v_gen_item_asis_1 AS I
WHERE item_actiongroup_id IS NOT NULL
 AND item_sub_actiongroup_id IS NOT NULL
GROUP BY client_id,
 country_iso_cd,
 item_actiongroup_id,
 item_sub_actiongroup_id,
 orig_item_nr,
 case_size,
 valid_from,
 valid_until;