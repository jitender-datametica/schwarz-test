/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_cs_itemfamily_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Guenes, Oguzhan              Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_itemfamily_2 (client_id, item_familygroup_id, itemfamily_cd, language_iso_cd
, country_iso_cd, valid_from, valid_until, desc_long, dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS SELECT
 client_id,
 item_familygroup_id,
 itemfamily_cd,
 language_iso_cd,
 src_country_lidl_cd AS country_iso_cd,
 dat_rec_start AS valid_from,
 dat_rec_end AS valid_until,
  CASE
  WHEN src_id = 2
  THEN LTRIM(SUBSTR(desc_long, INSTR(' ', desc_long)))
  ELSE desc_long
  END AS desc_long,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id
FROM ldl_p_lew_mart_cs.v_gen_item_family_2 AS I
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end;