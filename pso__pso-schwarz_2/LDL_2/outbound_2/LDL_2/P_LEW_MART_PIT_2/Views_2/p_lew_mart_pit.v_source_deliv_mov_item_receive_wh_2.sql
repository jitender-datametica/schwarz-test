/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_DELIV_MOV_ITEM_RECEIVE_WH_2
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_DELIV_MOV_ITEM_RECEIVE_WH_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli	Initial version
#  1.1  2021-09-29 Dirk Hering      Use example role added, data types added, column order, formatting
#  1.2  2021-10-01 Massimo Morelli  Resetting valid_from_dt, valid_to_dt, deleted_fg
#  1.3  2021-10-08 Dirk Hering      New target names: WAREHOUSE_SID 
#  1.4	2022-02-22 Andreas Kurz		Reformating and integrating Business Logic         
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_DELIV_MOV_ITEM_RECEIVE_WH_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_deliv_mov_item_receive_wh_2
OPTIONS(DESCRIPTION = `V_SOURCE_DELIV_MOV_ITEM_RECEIVE_WH_2`) AS SELECT CAST(iwr.client_id AS BIGNUMERIC) AS client_id,
 CAST(iwr.item_sid AS BIGNUMERIC) AS item_sid,
 DATE(iwr.dwh_cal_dt) AS dwh_cal_dt,
 CAST(iwr.loc_sid_wh AS BIGNUMERIC) AS warehouse_sid,
 CAST(iwr.location_item_receipt_id AS BIGNUMERIC) AS location_item_receipt_id,
 CAST(iwr.location_item_receipt_pos_id AS BIGNUMERIC) AS location_item_receipt_pos_id,
 CAST(iwr.orig_receipt_id_rcv AS STRING) AS orig_receipt_id_rcv,
 CAST(iwr.stock_location_nr AS BIGNUMERIC) AS stock_location_nr,
 iwr.curr_cd_from,
 CAST(COALESCE(cur.curr_cd, 'n/A') AS STRING) AS curr_cd,
 COALESCE(cur.curr_sid, - 2) AS curr_sid,
 CAST(iwr.receipt_type_id AS BIGNUMERIC) AS receipt_type_id,
 CAST(iwr.status_tg AS BIGNUMERIC) AS status_fg,
 CAST(iwr.receipt_pos_margin_rel_fg AS BIGNUMERIC) AS receipt_pos_margin_rel_fg,
 COALESCE(ROUND(SAFE_CAST(iwr.customer_nr AS BIGNUMERIC), 0), 0) AS customer_nr,
 IF(iwr.receipt_type_id IN (1, 2, 3) AND SAFE_CAST(iwr.status_tg as BIGNUMERIC) > 3 AND COALESCE(ROUND(SAFE_CAST(iwr.customer_nr
       AS BIGNUMERIC), 0), 0) = 0, 1, 0) AS rcv_qty_fg,
 IF(IF(iwr.receipt_type_id IN (1, 2, 3) AND SAFE_CAST(iwr.status_tg as BIGNUMERIC) > 3 AND COALESCE(ROUND(SAFE_CAST(iwr
         .customer_nr AS BIGNUMERIC), 0), 0) = 0, 1, 0) = 1, iwr.receive_piece_qty, NULL) AS rcv_qty,
 CAST(iwr.buying_val AS BIGNUMERIC) AS buying_val,
 PARSE_DATE('%F', '1900-01-01') AS valid_from_dt,
 PARSE_DATE('%F', '9999-12-31') AS valid_to_dt,
 0 AS deleted_fg,
 CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated_ts
FROM (SELECT *
  FROM ldl_p_lew_bil.t_mov_item_receive_wh_2
  WHERE receipt_pos_margin_rel_fg = 1
   OR receipt_type_id IN (1, 2, 3, 4, 5)) AS iwr
 INNER JOIN (SELECT *
  FROM ldl_p_lew_core.t_country_2
  WHERE country_sid > 0
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(country_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated
        DESC)) = 1) AS ctr ON iwr.client_id = ctr.country_sid
 INNER JOIN (SELECT client_id,
   curr_sid_from AS curr_sid,
   curr_cd_from AS curr_cd
  FROM ldl_p_lew_core.t_exchange_rate_known_hist_2
  WHERE deleted_fg = 0
   AND curr_sid_from = curr_sid_to
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(curr_sid_from AS STRING), curr_cd_from
      ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS cur ON iwr.client_id = cur.client_id AND iwr.curr_cd_from
     = cur.curr_cd AND ctr.country_sid = cur.client_id
 INNER JOIN (SELECT client_id
  FROM ldl_p_lew_mart_pit.t_dim_client_2
  WHERE pit_country_fg = 1
   AND deleted_fg = 0
   AND reject_fg = 0
   AND current_fg = 1
  GROUP BY client_id) AS cl ON iwr.client_id = cl.client_id;