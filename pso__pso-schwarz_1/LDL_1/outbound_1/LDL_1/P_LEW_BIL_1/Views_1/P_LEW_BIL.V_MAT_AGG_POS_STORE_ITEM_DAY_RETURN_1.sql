CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_pos_store_item_day_return_1 AS SELECT client_id,
 loc_sid AS loc_sid_store,
 item_sid,
 dwh_cal_dt,
 SUM(CASE
   WHEN transaction_type_cd BETWEEN '140' AND '149'
   THEN CASE
    WHEN weight_item_fg <> 1
    THEN IFNULL(sales_piece_qty, 0)
    ELSE IFNULL(sales_weight_qty, 0)
    END
   WHEN transaction_type_cd BETWEEN '440' AND '449'
   THEN IFNULL(discount_weight_qty, 0)
   WHEN transaction_type_cd BETWEEN '640' AND '649'
   THEN IFNULL(discount_piece_qty, 0)
   ELSE 0
   END) AS return_qty,
 return_reason_cd,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM ldl_p_lew_core_ac.v_pos_receiptline_1 AS RTN
WHERE transaction_type_cd IN ('140', '141', '142', '143', '144', '145', '146', '147', '148', '149', '440', '441', '442'
   , '443', '444', '445', '446', '447', '448', '449', '640', '641', '642', '643', '644', '645', '646', '647', '648',
   '649')
 AND dwh_cal_dt >= DATE '1111-01-01'
 AND client_id <= 42
GROUP BY client_id,
 loc_sid_store,
 item_sid,
 dwh_cal_dt,
 return_reason_cd;