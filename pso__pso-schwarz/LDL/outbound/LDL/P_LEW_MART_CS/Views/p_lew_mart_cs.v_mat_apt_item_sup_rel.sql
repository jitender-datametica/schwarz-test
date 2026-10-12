/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_item_sup_rel
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  22.09.2021    Ulrich, Ross                 Remove filter sales_wh_fg = 1 (nur Vertriebsgesellschaften) Was missing on CLOUD
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_item_sup_rel (client_id, country_iso_cd, wh_id, org_item_nr,
valid_from_item, case_size, dat_rec_start, dat_rec_end, orig_supplier_nr, dwh_updated, dwh_created, dwh_load_id, load_id
, src_id) AS SELECT A.client_id,
 A.country_iso_cd,
 A.wh_id,
 A.orig_item_nr AS org_item_nr,
 A.valid_from AS valid_from_item,
 COALESCE(A.case_size, 1) AS case_size,
 A.valid_from AS dat_rec_start,
 A.valid_until AS dat_rec_end,
 A.orig_supplier_nr,
 A.dwh_updated,
 A.dwh_created,
 A.dwh_load_id,
 A.load_id,
 A.src_id
FROM ldl_p_lew_mart_cs.v_cs_item_supplier AS A
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis AS ASIS ON A.client_id = ASIS.client_id AND A.item_id = ASIS.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_location AS L ON A.client_id = L.client_id AND A.wh_id = L.src_orig_wh_nr AND L.wh_store_mark
    = 'B'
 INNER JOIN ldl_p_lew_core_ac.v_location_hist AS L_H ON L.loc_sid = L_H.loc_sid AND CURRENT_DATE BETWEEN L_H.dwh_valid_from
   AND L_H.dwh_valid_to
WHERE ASIS.itemstatus_cd > 3
 AND ASIS.itemstatus_cd < 10
 AND ASIS.buying_list_type_id > 0
GROUP BY A.client_id,
 A.country_iso_cd,
 A.wh_id,
 org_item_nr,
 valid_from_item,
 case_size,
 dat_rec_start,
 dat_rec_end,
 A.orig_supplier_nr,
 A.dwh_updated,
 A.dwh_created,
 A.dwh_load_id,
 A.load_id,
 A.src_id;