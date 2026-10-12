/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_cs_item_supplier
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.9  30.06.2021    Ross,Ulrich              Change orig_supplier_nr to data sup.sup_sid
#  2.0  30.06.2021    Ross,Ulrich              Change view v_supplier to v_supplier_hist
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item_supplier (client_id, src_supplier_id, orig_supplier_nr, sup_name,
wh_id, item_id, orig_item_nr, case_size, country_iso_cd, valid_from, valid_until, man_valid_from, man_valid_until,
dwh_updated, dwh_created, dwh_load_id, load_id, src_id, last_refresh) AS SELECT basis.client_id,
 NULL AS src_supplier_id,
 SUP.sup_sid AS orig_supplier_nr,
 SUP.name_1 AS sup_name,
 basis.wh_id,
 basis.item_sid AS item_id,
 I.orig_item_nr,
 I.case_size,
 I.src_country_lidl_cd AS country_iso_cd,
 basis.valid_from,
 basis.valid_until,
 basis.man_valid_from,
 basis.man_valid_until,
 basis.dwh_updated,
 basis.dwh_created,
 basis.dwh_load_id,
 basis.load_id,
 basis.src_id,
 CURRENT_TIME AS last_refresh
FROM (SELECT client_id,
   sup_sid,
   item_sid,
   wh_id,
   valid_from,
   valid_until,
   man_valid_from,
   man_valid_until,
   dwh_updated,
   dwh_created,
   dwh_load_id,
   load_id,
   src_id
  FROM (SELECT A.client_id,
      A.sup_sid,
      A.item_sid,
      COALESCE(C.src_wh_id, C.loc_sid) AS wh_id,
       CASE
       WHEN B.dwh_valid_from > A.dwh_valid_from
       THEN B.dwh_valid_from
       ELSE A.dwh_valid_from
       END AS valid_from,
       CASE
       WHEN B.dwh_valid_to < A.dwh_valid_to
       THEN B.dwh_valid_to
       ELSE A.dwh_valid_to
       END AS valid_until,
      COALESCE(A.deliverable_from_dt, DATE '1900-01-01') AS man_valid_from,
      A.deliverable_to_dt AS man_valid_until,
      A.dwh_updated,
      A.dwh_created,
      A.dwh_load_id,
      CAST(- 1 AS BIGNUMERIC) AS load_id,
      2 AS src_id
     FROM ldl_p_lew_core_ac.v_pinfo_header_hist AS A
      INNER JOIN ldl_p_lew_core_ac.v_pinfo_detail_hist AS B ON A.client_id = B.client_id AND A.pinfo_sid = B.pinfo_sid
       AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
      INNER JOIN ldl_p_lew_core_ac.v_location AS C ON B.client_id = C.client_id AND B.loc_sid = C.loc_sid AND C.wh_store_mark
         = 'B'
     WHERE A.sup_sid IS NOT NULL
      AND CURRENT_DATE BETWEEN CASE
        WHEN B.dwh_valid_from > A.dwh_valid_from
        THEN B.dwh_valid_from
        ELSE A.dwh_valid_from
        END AND CASE
        WHEN B.dwh_valid_to < A.dwh_valid_to
        THEN B.dwh_valid_to
        ELSE A.dwh_valid_to
        END
      AND (A.deleted_fg = 0 OR B.deleted_fg = 0)
     UNION DISTINCT
     SELECT A.client_id,
      A.sup_sid,
      A.item_sid,
      COALESCE(B.src_wh_id, B.loc_sid) AS wh_id,
      A.dat_rec_start AS valid_from,
      A.dat_rec_end AS valid_until,
      A.dat_valid_from AS man_valid_from,
      A.dat_valid_until AS man_valid_until,
      CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_updated,
      CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_created,
      CAST(- 1 AS BIGNUMERIC) AS dwh_load_id,
      A.load_id,
      1 AS src_id
     FROM ldl_p_lew_core_ac.v_wawi_itm_sup_wh_data AS A
      INNER JOIN ldl_p_lew_core_ac.v_location AS B ON A.client_id = B.client_id AND A.wh_loc_sid = B.loc_sid
      LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_currency AS C ON A.client_id = C.client_id AND A.currency_nr = C.currency_nr
        
     WHERE CURRENT_DATE BETWEEN A.dat_rec_start AND A.dat_rec_end
      AND A.delete_fg = 0) AS raw
  QUALIFY (RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(sup_sid AS STRING), CAST(item_sid AS STRING), CAST(wh_id AS STRING)
        ORDER BY src_id IS NULL, src_id)) = 1) AS basis
 INNER JOIN ldl_p_lew_core_ac.v_supplier_hist AS SUP ON basis.client_id = SUP.client_id AND basis.sup_sid = SUP.sup_sid
  AND CURRENT_DATE BETWEEN SUP.dwh_valid_from AND SUP.dwh_valid_to
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis AS I ON basis.client_id = I.client_id AND basis.item_sid = I.item_sid
GROUP BY basis.client_id,
 src_supplier_id,
 orig_supplier_nr,
 sup_name,
 basis.wh_id,
 item_id,
 I.orig_item_nr,
 I.case_size,
 country_iso_cd,
 basis.valid_from,
 basis.valid_until,
 basis.man_valid_from,
 basis.man_valid_until,
 basis.dwh_updated,
 basis.dwh_created,
 basis.dwh_load_id,
 basis.load_id,
 basis.src_id;