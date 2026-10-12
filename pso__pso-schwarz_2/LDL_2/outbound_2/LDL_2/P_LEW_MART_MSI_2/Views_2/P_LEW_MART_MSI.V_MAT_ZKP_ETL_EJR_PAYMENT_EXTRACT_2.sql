CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_payment_extract_2 AS SELECT PAYM.store_id,
 PAYM.client_id,
 PAYM.pos_terminal_id,
 PAYM.dat_formdate,
 PAYM.time_receipt_ejr,
 PAYM.orig_receipt_nr_ejr,
 PAYM.orig_receipt_serial_nr_ejr,
 PAYM.timezone_cd,
 PAYM.dat_dayend,
 PAYM.checker_id,
 PAYM.transactiontype_id,
 PAYM.cnt_payment_ejr,
 PAYM.val_retail_payment_ejr,
 PAYM.tendertype_cd_ejr,
 PAYM.load_id
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_2 AS PAYM
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 AS SST ON PAYM.client_id = SST.client_id AND
    PAYM.store_id = SST.store_id AND PAYM.dat_formdate BETWEEN SST.dat_formdate_from AND SST.dat_formdate_until
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS REVDAY ON PAYM.dat_formdate = REVDAY.dat_calendar
  -- The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).

  
WHERE PAYM.dat_formdate >= (SELECT MIN(dat_calendar)
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS D_MIN)
 AND PAYM.dat_formdate <= (SELECT MAX(dat_calendar)
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 AS D_MAX);