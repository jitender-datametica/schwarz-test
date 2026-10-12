/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_ITEMFAMILY_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item_itemfamily_2 (client_id, orig_item_nr, case_size, item_familygroup_id,
itemfamily_cd, language_iso_cd, country_iso_cd, valid_from, valid_until, dwh_updated, dwh_created, dwh_load_id, load_id
, src_id, last_refresh) AS SELECT I.client_id,
 I.orig_item_nr,
 I.case_size,
 I.item_familygroup_id,
 i_fam.itemfamily_cd,
 i_fam.language_iso_cd,
 I.src_country_lidl_cd AS country_iso_cd,
 I.valid_from,
 I.valid_until,
 I.dwh_updated,
 I.dwh_created,
 I.dwh_load_id,
 CAST(- 1 AS BIGNUMERIC) AS load_id,
 2 AS src_id,
 CURRENT_TIMESTAMP() AS last_refresh
FROM ldl_p_lew_mart_cs.v_gen_item_asis_2 AS I
 INNER JOIN (SELECT client_id,
   item_familygroup_id,
   itemfamily_cd,
   language_iso_cd
  FROM ldl_p_lew_mart_cs.v_gen_item_family_2
  WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
  GROUP BY client_id,
   item_familygroup_id,
   itemfamily_cd,
   language_iso_cd) AS i_fam ON I.client_id = i_fam.client_id AND I.item_familygroup_id = i_fam.item_familygroup_id
WHERE I.orig_item_nr > 0
GROUP BY I.client_id,
 I.orig_item_nr,
 I.case_size,
 I.item_familygroup_id,
 i_fam.itemfamily_cd,
 i_fam.language_iso_cd,
 country_iso_cd,
 I.valid_from,
 I.valid_until,
 I.dwh_updated,
 I.dwh_created,
 I.dwh_load_id,
 load_id,
 src_id,
 last_refresh;