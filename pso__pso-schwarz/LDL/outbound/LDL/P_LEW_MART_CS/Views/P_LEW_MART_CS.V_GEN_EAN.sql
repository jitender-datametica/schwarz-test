/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_EAN
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_ean (client_id, item_sid, valid_from, valid_until, ean_code,
ean_description, language_id, language_iso_cd, src_country_lidl_cd, src_id, dwh_updated, dwh_created, dwh_load_id,
load_id) AS SELECT a.client_id,
 a.item_sid,
 a.valid_from,
 a.valid_until,
 a.ean_code,
 a.ean_description,
 a.language_id,
 a.language_iso_cd,
 T.src_country_lidl_cd,
 a.src_id,
 a.dwh_updated,
 a.dwh_created,
 a.dwh_load_id,
 a.load_id
FROM (SELECT E.client_id,
    E.item_sid,
    CURRENT_DATE AS valid_from,
    DATE '9999-12-30' AS valid_until,
    E.gtin AS ean_code,
    d.item_descr AS ean_description,
    COALESCE(d.language_id, - 1) AS language_id,
    d.language_iso_cd,
    2 AS src_id,
    E.dwh_updated,
    E.dwh_created,
    E.dwh_load_id,
    CAST(- 1 AS BIGNUMERIC) AS load_id
   FROM ldl_p_lew_core_ac.v_item_gtin AS E
    INNER JOIN ldl_p_lew_process_ac.v_sap_migration_client AS SAPM ON E.client_id = SAPM.client_id AND SAPM.migrated_fg
      = 1
    LEFT JOIN (SELECT B.client_id,
      B.item_sid,
      B.item_descr,
      COALESCE(C.language_id, - 1) AS language_id,
      COALESCE(C.language_iso_cd, '#' || 'NA' || '#') AS language_iso_cd
     FROM ldl_p_lew_core_ac.v_item_descr AS B
      INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras AS C ON B.lang_cd = C.sap_lang_cd AND (C.sap_lang_cd = '@' OR B.client_id
           = C.language_id)) AS d ON E.client_id = d.client_id AND E.item_sid = d.item_sid
   GROUP BY E.client_id,
    E.item_sid,
    valid_from,
    valid_until,
    ean_code,
    ean_description,
    language_id,
    d.language_iso_cd,
    src_id,
    E.dwh_updated,
    E.dwh_created,
    E.dwh_load_id,
    load_id
   UNION DISTINCT
   SELECT WAWI.client_id,
    WAWI.item_sid,
    WAWI.dat_rec_start AS valid_from,
    WAWI.dat_rec_end AS valid_until,
    WAWI.ean AS ean_code,
    WAWI.ean_item_desc AS ean_description,
    COALESCE(WAWI.language_id, - 1) AS language_id,
    C.language_iso_cd,
    1 AS src_id,
    CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_updated,
    CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_created,
    - 1 AS dwh_load_id,
    WAWI.load_id
   FROM ldl_p_lew_core_ac.v_wawi_itm_ean AS WAWI
    INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras AS C ON WAWI.language_id = C.language_id
   WHERE WAWI.dat_rec_start <= CURRENT_DATE) AS a
 INNER JOIN ldl_p_lew_core_ac.v_client AS C0 ON a.client_id = C0.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country AS T ON C0.country_sid = T.country_sid;