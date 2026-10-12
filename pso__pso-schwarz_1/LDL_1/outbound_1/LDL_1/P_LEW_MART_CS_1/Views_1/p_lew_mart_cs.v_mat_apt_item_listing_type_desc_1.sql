/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_item_listing_type_desc_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_item_listing_type_desc_1 (client_id, country_iso_cd, itemlistingtype_cd
, language_iso_cd, itemlistingtype_descr, dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS SELECT client_id,
 src_country_lidl_cd AS country_iso_cd,
 buying_list_type_id AS itemlistingtype_cd,
 language_iso_cd,
 buying_list_type_desc AS itemlistingtype_descr,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id
FROM ldl_p_lew_mart_cs.v_gen_item_hist_1 AS A
WHERE itemstatus_cd > 3
 AND itemstatus_cd < 10
 AND buying_list_type_id > 0
 AND buying_list_type_desc IS NOT NULL
GROUP BY client_id,
 country_iso_cd,
 itemlistingtype_cd,
 language_iso_cd,
 itemlistingtype_descr,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(itemlistingtype_cd AS STRING) ORDER BY
      dwh_load_id IS NULL, dwh_load_id, itemlistingtype_descr IS NULL, itemlistingtype_descr)) = 1;