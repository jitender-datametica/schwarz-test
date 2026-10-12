/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_EAN_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_EAN_2
(
client_id
, item_sid
, valid_from
, valid_until
, ean_code
, ean_description
, language_id
, language_iso_cd
, src_country_lidl_cd
, src_id
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
)
AS
   SELECT
   a.client_id,
   a.item_sid,
   a.valid_from,
   a.valid_until,
   a.ean_code,
   a.ean_description,
   a.language_id,
   a.language_iso_cd,
   t.src_country_lidl_cd,
   a.src_id,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id,
   a.load_id
   FROM (SELECT
   e.client_id                     AS client_id,
   e.item_sid                    AS item_sid,
   CURRENT_DATE                  AS valid_from,
   DATE '9999-12-30'             AS valid_until,
   e.gtin                        AS ean_code,
   d.item_descr                  AS ean_description,
   COALESCE(d.language_id,-1)    AS language_id,
   d.language_iso_cd             AS language_iso_cd,
   2                             AS src_id,
   e.dwh_updated                 AS dwh_updated,
   e.dwh_created                 AS dwh_created,
   e.dwh_load_id                 AS dwh_load_id,
   CAST(-1 AS INTEGER)           AS load_id
   FROM p_lew_core_ac.v_item_gtin_2 e
   INNER JOIN p_lew_process_ac.v_sap_migration_client_2 AS sapm
   ON e.client_id = sapm.client_id
   AND sapm.migrated_fg = 1
   LEFT OUTER JOIN
   (SELECT
   b.client_id                           AS client_id,
   b.item_sid                          AS item_sid,
   b.item_descr                        AS item_descr,
   COALESCE(c.language_id, -1)         AS language_id,
   COALESCE(c.language_iso_cd, '#'||'NA'||'#') AS language_iso_cd
   FROM p_lew_core_ac.v_item_descr_2 AS b
   INNER JOIN p_lew_core_ac.v_map_lang_spras_2  AS c
   ON c.sap_lang_cd = b.lang_cd
   AND (c.sap_lang_cd = '@' OR c.language_id = b.client_id)
) AS d
   ON e.client_id = d.client_id
   AND e.item_sid = d.item_sid

   GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13

   UNION
   SELECT
   wawi.client_id                      AS client_id,
   wawi.item_sid                     AS item_sid,
   wawi.dat_rec_start                AS valid_from,
   wawi.dat_rec_end                  AS valid_until,
   wawi.ean_2                          AS ean_code,
   wawi.ean_item_desc                AS ean_description,
   COALESCE(wawi.language_id, -1)    AS language_id,
   c.language_iso_cd                 AS language_iso_cd,
   1                                 AS src_id,
   TIMESTAMP '1900-01-01 00:00:00'           AS dwh_updated,
   TIMESTAMP '1900-01-01 00:00:00'           AS dwh_created,
   -1                                     AS dwh_load_id,
   wawi.load_id          AS load_id
   FROM p_lew_core_ac.v_wawi_itm_ean_2 wawi
   INNER JOIN p_lew_core_ac.v_map_lang_spras_2  AS c
   ON c.language_id = wawi.language_id

   WHERE wawi.dat_rec_start <= CURRENT_DATE

) a
   INNER JOIN p_lew_core_ac.v_client_2 c
   ON a.client_id = c.client_id
   INNER JOIN p_lew_core_ac.v_country_2 t
   ON c.country_sid = t.country_sid
;