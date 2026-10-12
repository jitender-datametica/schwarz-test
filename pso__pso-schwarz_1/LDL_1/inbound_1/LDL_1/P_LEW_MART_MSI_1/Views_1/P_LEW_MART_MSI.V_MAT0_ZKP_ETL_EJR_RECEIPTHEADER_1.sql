/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_RECEIPTHEADER_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding.Michael           Initial
#  1.1  11.01.2018    Ueding Michael           Timestamp von (6) auf (3) geaendert.
#  1.2  17.01.2018    Ueding Michael           Vorbelegung resumed_trans_store_id_ejr
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  31.01.2018    Wieber,Harald            Release 2.3
#  1.5  24.08.2021    Wandtke,Andrzej          AP0091650_ZKP_BTEQ - Tech tests of BTEQ : use CAST(SUBSTRING(TO_VARCHAR(receipt_tmsp), 12, 8) AS TIME(0)) in field time_receipt_ejr
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptheader_1
AS
SELECT
loc_sid AS store_id,
client_id,
register_id AS pos_terminal_id,
dwh_cal_dt AS dat_formdate,
CAST(SUBSTRING(TO_VARCHAR(receipt_tmsp), 12, 8) AS TIME(0)) AS time_receipt_ejr,
receipt_id AS orig_receipt_nr_ejr,
NULL AS orig_receipt_serial_nr_ejr  -- Nicht in DWH 2.0 uebernommen worden. 
,
timezone_id AS timezone_cd,
dwh_cal_dt AS dat_dayend,
cashier_id AS checker_id,
transaction_type_cd AS transactiontype_id,
NULL AS header_collection -- Nicht in DWH 2.0 uebernommen worden.
,
cnt_receiptlines_total AS cnt_receiptline_ejr,
cnt_receiptlines_sales AS cnt_selling_position_ejr,
cnt_receiptlines_discounts AS cnt_discount_ejr,
cnt_receiptlines_deposits AS cnt_deposit_ejr,
cnt_receiptlines_returns AS cnt_return_ejr,
cnt_receiptlines_voids AS cnt_void_ejr,
cnt_distinct_eans AS cnt_ean_ejr,
cnt_distinct_items AS cnt_item_ejr,
cnt_distinct_weight_items AS cnt_item_weight_ejr,
cnt_distinct_item_grp_ints AS cnt_mainitemgroup_ejr,
cnt_piece_qty AS qty_piece_ejr,
total_gross_val AS val_retail_ejr,
sales_gross_val AS val_retail_pos_ejr,
sales_net_val AS val_retail_net_pos_ejr,
deposit_gross_val AS val_deposit_ejr,
deposit_net_val AS val_deposit_net_ejr,
discount_gross_val AS val_discount_ejr,
discount_net_val AS val_discount_net_ejr,
CASE WHEN resumed_receipt_id IS NULL
        THEN NULL
        ELSE loc_sid
   END AS resumed_trans_store_id_ejr,
resumed_receipt_register_id AS resumed_trans_terminal_id_ejr,
resumed_receipt_dt AS resumed_trans_date_ejr,
resumed_receipt_id AS resumed_trans_receipt_nr_ejr,
dur_item_scan AS dur_service_time_ejr,
dur_payment AS dur_pay_change_time_ejr,
total_net_val AS val_retail_net_ejr,
Cast(SUBSTRING(Cast(transaction_begin_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP(3)) AS timestamp_begin_ejr,
Cast(SUBSTRING(Cast(transaction_end_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP(3)) AS timestamp_end_ejr,
authority_cd AS authority_id,
customer_cd AS customer_nr,
dwh_load_id AS load_id
FROM p_lew_core_ac.v_pos_receiptheader_1 h

WHERE turnover_relevant_fg = 1 

;