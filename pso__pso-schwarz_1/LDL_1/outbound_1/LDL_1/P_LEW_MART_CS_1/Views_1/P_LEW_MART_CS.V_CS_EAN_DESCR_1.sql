/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_EAN_DESCR_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_ean_descr_1 (client_id, ean_code, valid_from, valid_until, ean_description,
language_id, language_iso_cd, country_iso_cd, last_refresh) AS SELECT client_id,
 ean_code,
 valid_from,
  CASE
  WHEN valid_until = PARSE_DATE('%d.%m.%Y', '31.12.9999')
  THEN DATE_SUB(valid_until, INTERVAL 1 DAY)
  ELSE valid_until
  END AS valid_until,
 COALESCE(MAX(ean_description), '<<unknown>>') AS ean_description,
 language_id,
 language_iso_cd,
 src_country_lidl_cd AS country_iso_cd,
 CURRENT_TIMESTAMP() AS last_refresh
FROM ldl_p_lew_mart_cs.v_gen_ean_1 AS EAN_1
WHERE CURRENT_DATE BETWEEN valid_from AND valid_until
GROUP BY client_id,
 ean_code,
 valid_from,
 EAN.valid_until,
 language_id,
 language_iso_cd,
 country_iso_cd;