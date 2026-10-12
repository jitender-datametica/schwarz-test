CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_price_info_extract AS SELECT PRC.store_id,
 PRC.client_id,
 PRC.pos_terminal_id,
 PRC.dat_formdate,
 PRC.time_receipt_ejr,
 PRC.orig_receipt_nr_ejr,
 PRC.timezone_cd,
 PRC.dat_dayend,
 PRC.checker_id,
 PRC.transactiontype_id,
 PRC.timestamp_begin_ejr,
 PRC.timestamp_end_ejr,
 PRC.authority_id,
 PRC.item_id,
 PRC.price_retail_ejr,
 PRC.mainitemgroup_id,
 PRC.item_takeover_fg,
 PRC.load_id
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_price_info AS PRC
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS SST ON PRC.client_id = SST.client_id AND
    PRC.store_id = SST.store_id AND PRC.dat_formdate BETWEEN SST.dat_formdate_from AND SST.dat_formdate_until
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS REVDAY ON PRC.dat_formdate = REVDAY.dat_calendar;