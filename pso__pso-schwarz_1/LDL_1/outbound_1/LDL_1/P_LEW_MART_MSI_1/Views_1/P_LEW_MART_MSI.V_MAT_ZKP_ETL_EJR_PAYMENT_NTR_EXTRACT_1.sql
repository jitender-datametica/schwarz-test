CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_payment_ntr_extract_1 AS SELECT PAYNTR.store_id,
 PAYNTR.client_id,
 PAYNTR.pos_terminal_id,
 PAYNTR.dat_formdate,
 PAYNTR.time_receipt_ejr,
 PAYNTR.orig_receipt_nr_ejr,
 PAYNTR.orig_receipt_serial_nr_ejr,
 PAYNTR.timezone_cd,
 PAYNTR.dat_dayend,
 PAYNTR.checker_id,
 PAYNTR.transactiontype_id,
 PAYNTR.cnt_payment_ejr,
 PAYNTR.val_retail_payment_ejr,
 PAYNTR.tendertype_cd_ejr,
 PAYNTR.load_id
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_ntr_1 AS PAYNTR
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS SST ON PAYNTR.client_id = SST.client_id AND
    PAYNTR.store_id = SST.store_id AND PAYNTR.dat_formdate BETWEEN SST.dat_formdate_from AND SST.dat_formdate_until
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 AS REVDAY ON PAYNTR.dat_formdate = REVDAY.dat_calendar;