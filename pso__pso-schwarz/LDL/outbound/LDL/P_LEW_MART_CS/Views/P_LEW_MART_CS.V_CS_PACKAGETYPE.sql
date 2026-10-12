/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_cs_packagetype
#----------------------------------------------------------------------------
# History:
#  1.0  18.06.2021    Ulrich Ross                  Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_packagetype (client_id, packagetype_skey, language_id, valid_from,
valid_until, descr, last_refresh, src_id, load_id) AS SELECT A.client_id,
 A.src_zz_pack_type AS packagetype_skey,
 COALESCE(C.language_id, - 1) AS language_id,
 CURRENT_DATE AS valid_from,
 DATE '9999-12-31' AS valid_until,
 B.pack_type_descr AS descr,
 A.dwh_updated AS last_refresh,
 2 AS src_id,
 CAST(NULL AS BIGNUMERIC) AS load_id
FROM ldl_p_lew_core_ac.v_packaging_type AS A
 INNER JOIN ldl_p_lew_core_ac.v_packaging_type_descr AS B ON A.client_id = B.client_id AND A.pack_type_sid = B.pack_type_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras AS C ON B.lang_cd = C.sap_lang_cd AND (C.sap_lang_cd = '@' OR B.client_id
      = C.language_id)
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS E ON A.client_id = E.client_id AND E.active_fg = 1
WHERE A.src_zz_pack_type = '-'
UNION DISTINCT
SELECT A.client_id,
 A.packagetype_desc_int_short AS packagetype_skey,
 COALESCE(A.language_id, - 1) AS language_id,
 DATE '1900-01-01' AS valid_from,
 DATE '9999-12-31' AS valid_until,
 A.packagetype_desc AS descr,
 CAST(NULL AS DATETIME) AS last_refresh,
 1 AS src_id,
 A.load_id
FROM ldl_p_lew_core_ac.v_wawi_ref_packagetype AS A
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS E ON A.client_id = E.client_id AND E.active_fg = 0;