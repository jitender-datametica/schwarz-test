/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_EAN_ITEM_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_ean_item_2 (client_id, ean_code, orig_item_nr, case_size, country_iso_cd,
valid_from, valid_until, src_id, dwh_updated, dwh_created, dwh_load_id, load_id) AS SELECT ean.client_id,
 ean.ean_code,
 I.orig_item_nr,
 I.case_size,
 ean.src_country_lidl_cd AS country_iso_cd,
 ean.valid_from,
  CASE
  WHEN ean.valid_until = PARSE_DATE('%d.%m.%Y', '31.12.9999')
  THEN DATE_SUB(ean.valid_until, INTERVAL 1 DAY)
  ELSE ean.valid_until
  END AS valid_until,
 ean.src_id,
 ean.dwh_updated,
 ean.dwh_created,
 ean.dwh_load_id,
 ean.load_id
FROM (SELECT client_id,
   item_sid,
   valid_from,
   valid_until,
   ean_code,
   src_country_lidl_cd,
   src_id,
   dwh_updated,
   dwh_created,
   dwh_load_id,
   load_id
  FROM ldl_p_lew_mart_cs.v_gen_ean_2 AS E
  GROUP BY client_id,
   item_sid,
   valid_from,
   valid_until,
   ean_code,
   src_country_lidl_cd,
   src_id,
   dwh_updated,
   dwh_created,
   dwh_load_id,
   load_id) AS ean_2
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis_2 AS I ON ean.client_id = I.client_id AND ean.item_sid = I.item_sid
WHERE CURRENT_DATE BETWEEN ean.valid_from AND ean.valid_until
 AND I.orig_item_nr > 0
GROUP BY ean.client_id,
 ean.ean_code,
 I.orig_item_nr,
 I.case_size,
 country_iso_cd,
 ean.valid_from,
 valid_until,
 ean.src_id,
 ean.dwh_updated,
 ean.dwh_created,
 ean.dwh_load_id,
 ean.load_id;