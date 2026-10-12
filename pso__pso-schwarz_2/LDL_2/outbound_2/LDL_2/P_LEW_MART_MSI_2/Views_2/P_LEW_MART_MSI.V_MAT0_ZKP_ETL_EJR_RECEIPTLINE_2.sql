/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_RECEIPTLINE_2
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding.Michael           Initial
#  1.1  08.01.2018    Ueding.Michael           Change Datatype timestamp
#  1.2  16.01.2018    Ueding.Michael           Trim Orig Attribute
#  1.3  17.01.2018    Ueding.Michael           mis_weight_fg mit weight_item_fg
#  1.4  31.01.2018    Wieber,Harald            Release 2.3
#  1.5  13.02.2019    Thole,Jens               renaming discount_id zu discount_sid
#  1.6  14.03.2019    Meister,Ulrich           Umstellung DDL zur Verwendung in Rollback-fähigen Patches
#  1.7  24.08.2021    Wandtke,Andrzej          AP0091650_ZKP_BTEQ - Tech tests of BTEQ : use CAST(SUBSTRING(TO_VARCHAR(receipt_tmsp), 12, 8) AS TIME(0)) instead of Cast(SUBSTRING(TO_VARCHAR(receipt_tmsp, ''), 1, 8) AS TIME(0)) in field time_receipt_ejr
#  1.8  22.10.2021    Wandtke,Andrzej          AP0102590_zkp_edit_return - REP1-14731 - change in column return_reason_cd_ejr: set to 0 when empty
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_2 AS SELECT loc_sid AS store_id,
 client_id,
 register_id AS pos_terminal_id,
 dwh_cal_dt AS dat_formdate,
 CAST(TRIM(SUBSTR(CAST(receipt_tmsp AS STRING), 12, 8)) AS TIME) AS time_receipt_ejr,
 receipt_id AS orig_receipt_nr_ejr,
 receiptline_nr AS orig_receipt_serial_nr_ejr,
 timezone_id AS timezone_cd,
 dwh_cal_dt AS dat_dayend,
 cashier_id AS checker_id,
 transaction_type_cd AS transactiontype_id,
 ean_barcode AS barcode,
 NULL AS ejr_cd,
 item_sid AS item_id,
 main_item_grp_cd AS mainitemgroup_id,
 weight_item_fg,
 weight_item_fg AS mis_weight_fg,
 item_unit_price AS price_retail_ejr,
 item_unit_price_adjust AS price_retail_adjstd_ejr,
 NULL AS price_type_ejr,
 sales_piece_qty AS qty_piece_ejr,
 sales_weight_qty AS qty_weight_ejr,
 sales_val AS val_retail_ejr,
 discount_val AS val_discount_ejr,
 vat_pct_val AS pct_vat_ejr,
 vat_val AS val_vat_ejr,
 tax_class_cd AS type_vat_ejr,
 discount_sid,
 sales_orig_val AS val_retail_orig_ejr,
 discount_base_val AS val_discount_base_ejr,
 discount_weight_qty AS qty_discount_pos_ejr,
 discount_piece_qty AS qty_discount_hq_ejr,
 NULL AS etyp,
 NULL AS posart,
 NULL AS stornokz,
  CASE
  WHEN CAST(transaction_type_cd AS INTEGER) IN (141, 142)
  THEN COALESCE(return_reason_cd, '0')
  ELSE return_reason_cd
  END AS return_reason_cd_ejr,
 CAST(SUBSTR(CAST(item_scan_begin_tmsp AS STRING), 1, 19) AS DATETIME) AS timestamp_begin_ejr,
 CAST(SUBSTR(CAST(item_scan_end_tmsp AS STRING), 1, 19) AS DATETIME) AS timestamp_end_ejr,
 item_entry_method_cd AS item_entry_method_cd_ejr,
 price_entry_method_cd AS price_entry_method_cd_ejr,
 receiptline_voided AS parent_line_nr_ejr,
 receiptline_voided_by AS voided_by_line_nr_ejr,
 authority_cd AS authority_id,
 NULL AS accounting_disposition_cd_ejr,
 TRIM(CAST(orig_receipt_store_id AS STRING)) AS original_orig_store_nr_ejr,
 orig_receipt_dt AS original_dat_formdate_ejr,
 TRIM(CAST(orig_receipt_id AS STRING)) AS original_orig_receipt_nr_ejr,
 TRIM(CAST(orig_receipt_register_id AS STRING)) AS original_pos_terminal_id_ejr,
 NULL AS source_definition_cd_ejr,
 NULL AS dat_adv,
 dwh_load_id AS load_id
FROM ldl_p_lew_core_ac.v_pos_receiptline_2
WHERE turnover_relevant_fg = 1;