CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_tax_extract AS SELECT TAX.store_id,
 TAX.client_id,
 TAX.pos_terminal_id,
 TAX.dat_formdate,
 TAX.time_receipt_ejr,
 TAX.orig_receipt_nr_ejr,
 TAX.orig_receipt_serial_nr_ejr,
 TAX.timezone_cd,
 TAX.dat_dayend,
 TAX.checker_id,
 TAX.transactiontype_id,
 TAX.val_vat_base_ejr,
 TAX.val_vat_ejr,
 TAX.pct_vat_ejr,
 TAX.load_id
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_tax AS TAX
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS SST ON TAX.client_id = SST.client_id AND
    TAX.store_id = SST.store_id AND TAX.dat_formdate BETWEEN SST.dat_formdate_from AND SST.dat_formdate_until
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY ON TAX.dat_formdate = REVDAY.dat_calendar;