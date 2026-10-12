CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_store_day_ber_test AS SELECT A11.client_id,
 A11.store_id,
 A11.currency_iso_cd,
 A11.dat_formdate,
 A11.val_retail_asis AS val_retail_asis_ber,
 A11.val_retail_net_asis AS val_retail_net_asis_ber,
 A11.cnt_customer_asis AS cnt_customer_asis_ber
FROM ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis AS A11
 INNER JOIN ldl_p_lew_mart_msi.v_org_store AS A12 ON A11.client_id = A12.client_id AND A11.store_id = A12.store_id
 INNER JOIN ldl_p_lew_mart_msi.v_org_all_store_reloc AS A13 ON A11.client_id = A13.client_id AND A11.store_id = A13.store_id
   
WHERE A11.dat_formdate BETWEEN A12.dat_calc_start_py AND A12.dat_calc_end_py
 OR A11.dat_formdate >= A12.dat_calc_start_py AND A13.move_fg = 1
 OR A11.dat_formdate >= A12.dat_calc_start_py AND A12.dat_calc_end_py IS NULL;