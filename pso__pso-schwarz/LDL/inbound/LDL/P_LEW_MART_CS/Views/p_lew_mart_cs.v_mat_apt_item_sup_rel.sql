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
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_item_sup_rel
(
  client_id
, country_iso_cd
, wh_id
, org_item_nr
, valid_from_item
, case_size
, dat_rec_start
, dat_rec_end
, orig_supplier_nr
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
, src_id
)
AS
  SELECT
  a.client_id
  , a.country_iso_cd
  , a.wh_id
  , a.orig_item_nr                  AS org_item_nr
  , a.valid_from                    AS valid_from_item
  , COALESCE(a.case_size, 1)        AS case_size
  , a.valid_from                    AS dat_rec_start
  , a.valid_until                   AS dat_rec_end
  , a.orig_supplier_nr
  , a.dwh_updated
  , a.dwh_created
  , a.dwh_load_id
  , a.load_id
  , a.src_id
  FROM p_lew_mart_cs.v_cs_item_supplier a
  INNER JOIN p_lew_mart_cs.v_gen_item_asis AS asis
    ON a.client_id = asis.client_id
    AND a.item_id = asis.item_sid  
  INNER JOIN p_lew_core_ac.v_location AS l
    ON a.client_id = l.client_id
    AND a.wh_id = l.src_orig_wh_nr
    AND l.wh_store_mark = 'B'
  INNER JOIN p_lew_core_ac.v_location_hist AS l_h
    ON l.loc_sid = l_h.loc_sid
    AND CURRENT_DATE BETWEEN l_h.dwh_valid_from AND l_h.dwh_valid_to
  WHERE asis.itemstatus_cd > 3
    AND asis.itemstatus_cd < 10
    AND asis.buying_list_type_id IS NOT NULL
    AND asis.buying_list_type_id > 0
    
 GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
   ;


