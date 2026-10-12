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
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_EAN_DESCR_1
(
client_id
, ean_code
, valid_from
, valid_until
, ean_description
, language_id
, language_iso_cd
, country_iso_cd
, last_refresh
)
AS
   SELECT
   ean.client_id                     AS client_id,
   ean.ean_code                    AS ean_code,
   ean.valid_from                  AS valid_from,
   CASE WHEN ean.valid_until = TO_DATE('31.12.9999', 'dd.mm.yyyy')
   THEN ean.valid_until - 1
   ELSE ean.valid_until
 END                             AS valid_until,
   COALESCE(MAX(ean.ean_description),'<<unknown>>')        AS ean_description,
   ean.language_id                 AS language_id,
   ean.language_iso_cd             AS language_iso_cd,
   ean.src_country_lidl_cd         AS country_iso_cd,
   CURRENT_TIMESTAMP               AS last_refresh
   FROM p_lew_mart_cs.v_gen_ean_1 ean_1

   WHERE CURRENT_DATE BETWEEN valid_from AND valid_until
   GROUP BY 1,2,3,4,6,7,8
;