/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_cs_packagetype_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.06.2021    Ulrich Ross                  Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_cs.v_cs_packagetype_1
(
client_id
,packagetype_skey
,language_id
,valid_from
,valid_until
,descr
,last_refresh
,src_id
,load_id
)
AS
SELECT 
erg.client_id
, erg.packagetype_skey
, erg.language_id
, erg.valid_from
, erg.valid_until
, erg.descr
, erg.last_refresh
, erg.src_id
, erg.load_id
FROM
  (
  --ELWIS packagetype
  SELECT
    a.client_id
   ,a.src_zz_pack_type AS packagetype_skey
   ,COALESCE(c.language_id,-1) AS language_id
   ,CURRENT_DATE AS valid_from
   ,DATE'9999-12-31' AS valid_until
   ,b.pack_type_descr AS descr
   ,a.dwh_updated   AS last_refresh
   ,2 AS src_id
   ,CAST(NULL AS INTEGER) AS load_id
  FROM p_lew_core_ac.v_packaging_type_1 a
  INNER JOIN p_lew_core_ac.v_packaging_type_descr_1 b
  ON b.client_id = a.client_id
  AND b.pack_type_sid = a.pack_type_sid
  INNER JOIN p_lew_core_ac.v_map_lang_spras_1 c
  ON c.sap_lang_cd = b.lang_cd
  AND (c.sap_lang_cd = '@' or c.language_id = b.client_id)
  INNER JOIN p_lew_core_ac.v_client_migration_per_1 e
  ON e.client_id = a.client_id
  AND e.active_fg = 1
  WHERE (TRY_CAST(a.src_zz_pack_type AS INTEGER) IS NULL OR a.src_zz_pack_type = '-')

  UNION

  --WAWI packagetype
  SELECT
    a.client_id
   ,a.packagetype_desc_int_short AS packagetype_skey
   ,COALESCE(a.language_id,-1) AS language_id
   ,DATE'1900-01-01' AS valid_from
   ,DATE'9999-12-31' AS valid_until
   ,a.packagetype_desc AS descr
   ,CAST(NULL AS TIMESTAMP)   AS last_refresh
   ,1 AS src_id
   ,a.load_id
  FROM p_lew_core_ac.v_wawi_ref_packagetype_1 a
  INNER JOIN p_lew_core_ac.v_client_migration_per_1 e
  ON e.client_id = a.client_id
  AND e.active_fg = 0
  ) AS erg
;
