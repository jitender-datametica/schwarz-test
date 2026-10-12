/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEMSALE_HOURS_DELTA_1
#----------------------------------------------------------------------------
# History:
#  1.0  12.12.2023    Ulrich Ross               Add new date filter (performance issue), User Story 559434
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEMSALE_HOURS_DELTA_1
AS
   SELECT
   pos_data.clientid                   AS client_id
   ,pos_data.store                      AS store
   ,CAST(pos_data.item_1   AS INTEGER)    AS item_1
   ,pos_data.receiptdate                AS receiptdate
   ,CAST(MAX(pos_data.time_last_sold_)  AS TIME(0)) AS timelastsold
   ,CAST(SUM(CASE WHEN pos_data.from_ = 0  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_0
   ,CAST(SUM(CASE WHEN pos_data.from_ = 1  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_1
   ,CAST(SUM(CASE WHEN pos_data.from_ = 2  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_2
   ,CAST(SUM(CASE WHEN pos_data.from_ = 3  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_3
   ,CAST(SUM(CASE WHEN pos_data.from_ = 4  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_4
   ,CAST(SUM(CASE WHEN pos_data.from_ = 5  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_5
   ,CAST(SUM(CASE WHEN pos_data.from_ = 6  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_6
   ,CAST(SUM(CASE WHEN pos_data.from_ = 7  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_7
   ,CAST(SUM(CASE WHEN pos_data.from_ = 8  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_8
   ,CAST(SUM(CASE WHEN pos_data.from_ = 9  THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_9
   ,CAST(SUM(CASE WHEN pos_data.from_ = 10 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_10
   ,CAST(SUM(CASE WHEN pos_data.from_ = 11 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_11
   ,CAST(SUM(CASE WHEN pos_data.from_ = 12 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_12
   ,CAST(SUM(CASE WHEN pos_data.from_ = 13 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_13
   ,CAST(SUM(CASE WHEN pos_data.from_ = 14 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_14
   ,CAST(SUM(CASE WHEN pos_data.from_ = 15 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_15
   ,CAST(SUM(CASE WHEN pos_data.from_ = 16 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_16
   ,CAST(SUM(CASE WHEN pos_data.from_ = 17 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_17
   ,CAST(SUM(CASE WHEN pos_data.from_ = 18 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_18
   ,CAST(SUM(CASE WHEN pos_data.from_ = 19 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_19
   ,CAST(SUM(CASE WHEN pos_data.from_ = 20 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_20
   ,CAST(SUM(CASE WHEN pos_data.from_ = 21 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_21
   ,CAST(SUM(CASE WHEN pos_data.from_ = 22 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_22
   ,CAST(SUM(CASE WHEN pos_data.from_ = 23 THEN pos_data.sum_qty_piece_  ELSE 0 END) AS DECIMAL(18,4)) AS sum_qty_piece_unpacked_23
   ,CAST(SUM(CASE WHEN pos_data.from_ = 0  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_0
   ,CAST(SUM(CASE WHEN pos_data.from_ = 1  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_1
   ,CAST(SUM(CASE WHEN pos_data.from_ = 2  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_2
   ,CAST(SUM(CASE WHEN pos_data.from_ = 3  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_3
   ,CAST(SUM(CASE WHEN pos_data.from_ = 4  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_4
   ,CAST(SUM(CASE WHEN pos_data.from_ = 5  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_5
   ,CAST(SUM(CASE WHEN pos_data.from_ = 6  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_6
   ,CAST(SUM(CASE WHEN pos_data.from_ = 7  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_7
   ,CAST(SUM(CASE WHEN pos_data.from_ = 8  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_8
   ,CAST(SUM(CASE WHEN pos_data.from_ = 9  THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_9
   ,CAST(SUM(CASE WHEN pos_data.from_ = 10 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_10
   ,CAST(SUM(CASE WHEN pos_data.from_ = 11 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_11
   ,CAST(SUM(CASE WHEN pos_data.from_ = 12 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_12
   ,CAST(SUM(CASE WHEN pos_data.from_ = 13 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_13
   ,CAST(SUM(CASE WHEN pos_data.from_ = 14 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_14
   ,CAST(SUM(CASE WHEN pos_data.from_ = 15 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_15
   ,CAST(SUM(CASE WHEN pos_data.from_ = 16 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_16
   ,CAST(SUM(CASE WHEN pos_data.from_ = 17 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_17
   ,CAST(SUM(CASE WHEN pos_data.from_ = 18 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_18
   ,CAST(SUM(CASE WHEN pos_data.from_ = 19 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_19
   ,CAST(SUM(CASE WHEN pos_data.from_ = 20 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_20
   ,CAST(SUM(CASE WHEN pos_data.from_ = 21 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_21
   ,CAST(SUM(CASE WHEN pos_data.from_ = 22 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_22
   ,CAST(SUM(CASE WHEN pos_data.from_ = 23 THEN CASE WHEN ( pos_data.discount_value_ <> 0 ) THEN pos_data.sum_qty_piece_discount_ END ELSE 0 END) AS DECIMAL(18,4)) AS discount_pieces_unpacked_23
   ,CAST(NULL AS INTEGER) AS load_id
   FROM
   (
     SELECT
        pos.client_id AS clientid
   ,loc.src_orig_store_nr AS store
   ,item.src_orig_item_nr AS item_1
   ,pos.dwh_cal_dt AS receiptdate
   ,SUM(pos.sales_piece_qty) AS sum_qty_piece_
   ,EXTRACT(HOUR FROM pos.receipt_tmsp) AS from_
   ,SUM(pos.discount_weight_qty) AS sum_qty_piece_discount_
   ,SUM(pos.discount_val) AS discount_value_
   ,MAX(pos.receipt_tmsp) AS time_last_sold_
     FROM
     (
       SELECT
          pos.client_id
   ,pos.loc_sid
   ,pos.item_sid
   ,pos.dwh_cal_dt
   ,pos.receipt_id
   ,pos.receiptline_nr
   ,pos.receiptline_voided
   ,pos.sales_fg
   ,pos.receipt_tmsp
   ,pos.discount_val
   ,pos.sales_piece_qty
   ,pos.discount_weight_qty
       FROM p_lew_core_ac.v_pos_receiptline_1 pos
   INNER JOIN
   ( SELECT
             deltaview.client_id
   ,deltaview.loc_sid
   ,deltaview.dwh_cal_dt
              FROM p_lew_process_ac.v_wfm_export_core_delta_1 deltaview
   WHERE deltaview.process_name = 'export_wfm_itemsale_hours'
     AND deltaview.process_specification = 'delta'
     AND deltaview.core_table_name = 't_pos_receiptline_1'
     AND deltaview.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
     GROUP BY
         deltaview.client_id
        ,deltaview.loc_sid
        ,deltaview.dwh_cal_dt
) AS delta_agg /*Deltalogik*/
   ON pos.dwh_cal_dt = delta_agg.dwh_cal_dt
   AND pos.client_id  = delta_agg.client_id
   AND pos.loc_sid    = delta_agg.loc_sid

  WHERE pos.turnover_relevant_fg = 1
    AND (CAST(pos.transaction_type_cd AS INTEGER) BETWEEN 100 AND 109 OR pos.discount_weight_qty = 1)
    AND pos.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
) pos
   INNER JOIN p_lew_core_ac.v_item_map_key_1 imap
   ON imap.client_id = pos.client_id
   AND imap.item_sid = pos.item_sid
   INNER JOIN p_lew_bil_ac.v_item_1 item_1
   ON item.client_id = imap.client_id
   AND item.item_sid = imap.item_sid_map
   AND pos.dwh_cal_dt BETWEEN item.dwh_valid_from AND item.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_subitemgroup_1 suig
   ON suig.client_id = item.client_id
   AND suig.sub_item_grp_sid = item.sub_item_grp_sid_asis
   /* only Bake off, Brot/Backwaren/Kuchen frisch, Hot Convenience (special case for US: IDMO-698) */
   AND
    (
     CAST(suig.src_subitemgrp_cd AS INTEGER) IN (73,74,78)
     OR (suig.client_id = 33 AND CAST(suig.src_subitemgrp_cd AS INTEGER) IN (72, 73, 74, 78))
    )
   INNER JOIN p_lew_core_ac.v_location_1 loc
   ON loc.client_id = pos.client_id
   AND loc.loc_sid = pos.loc_sid

 GROUP BY
    pos.client_id
   ,loc.src_orig_store_nr
   ,item.src_orig_item_nr
   ,pos.dwh_cal_dt
   ,pos.receipt_id
   ,pos.receiptline_voided
   ,pos.receiptline_nr
   ,EXTRACT(HOUR FROM pos.receipt_tmsp)
   ,pos.sales_fg

 /*change TECH-941: new max aggregation for discount qty in order to get only one value of discount qty per item_1 when there is more than one row per item_1 */
 QUALIFY MAX(pos.receiptline_nr)
 OVER (PARTITION BY pos.client_id, loc.src_orig_store_nr, item.src_orig_item_nr
                    ,pos.dwh_cal_dt, pos.receipt_id, COALESCE(pos.receiptline_voided, pos.receiptline_nr)
                    ,EXTRACT(HOUR FROM pos.receipt_tmsp), pos.sales_fg ) = pos.receiptline_nr

) pos_data

GROUP BY
  pos_data.clientid
 ,pos_data.store
 ,pos_data.item_1
 ,pos_data.receiptdate
;