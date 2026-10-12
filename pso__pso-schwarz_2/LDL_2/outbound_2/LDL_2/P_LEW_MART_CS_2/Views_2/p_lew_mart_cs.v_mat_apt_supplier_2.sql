/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_supplier_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.3  31.08.2021    Ulrich, Ross                 Change valid_from and Valid_until to MAX and MIN
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_supplier_2 (client_id, country_iso_cd, orig_supplier_nr, valid_from,
valid_until, sup_name, dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS SELECT SUP.client_id,
 SUP.country_iso_cd,
 SUP.orig_supplier_nr,
 MIN(SUP.valid_from) AS valid_from,
 MAX(SUP.valid_until) AS valid_until,
 SUP.sup_name,
 MIN(SUP.dwh_updated) AS dwh_updated,
 MAX(SUP.dwh_created) AS dwh_created,
 MAX(SUP.dwh_load_id) AS dwh_load_id,
 MAX(SUP.load_id) AS load_id,
 SUP.src_id
FROM ldl_p_lew_mart_cs.v_cs_item_supplier_2 AS SUP
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis_2 AS ASIS ON SUP.client_id = ASIS.client_id AND SUP.item_id = ASIS.item_sid
WHERE SUP.orig_supplier_nr > 0
 AND CURRENT_DATE BETWEEN SUP.valid_from AND SUP.valid_until
 AND (ASIS.itemstatus_cd > 3 AND ASIS.itemstatus_cd < 10)
 AND ASIS.buying_list_type_id > 0
GROUP BY SUP.client_id,
 SUP.orig_supplier_nr,
 SUP.sup_name,
 SUP.country_iso_cd,
 SUP.src_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(SUP.client_id AS STRING), CAST(SUP.orig_supplier_nr AS STRING) ORDER BY
      valid_from IS NULL, valid_from, valid_until IS NULL, valid_until, dwh_load_id IS NULL, dwh_load_id, load_id
      IS NULL, load_id, SUP.sup_name IS NULL, SUP.sup_name)) = 1;