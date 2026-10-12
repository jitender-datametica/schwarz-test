CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_store_day_ber_pym AS
SELECT A11.client_id,
 A11.loc_sid_store AS store_id,
 A11.currency_iso_cd,
 A12.dat_calendar_amd AS dat_formdate,
 A11.val_retail_asis AS val_retail_asis_ber,
 A11.val_retail_net_asis AS val_retail_net_asis_ber,
 A11.cnt_customer_asis AS cnt_customer_asis_ber
FROM ldl_p_lew_bil_ac.v_agg_str_day_ejr_txj_ww_asis AS A11
 INNER JOIN ldl_p_lew_mart_msi.v_cal_month_ber AS A12 ON A11.dat_formdate = A12.dat_calendar_pyd
 INNER JOIN ldl_p_lew_mart_msi.v_org_all_store_reloc AS A13 ON A11.client_id = A13.client_id AND A11.loc_sid_store = A13
   .store_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store AS A14 ON A13.client_id = A14.client_id AND A13.store_id = A14.st_loc_sid
      AND A14.test_store_fg = 0 AND CURRENT_DATE >= A14.dat_opening
WHERE A12.dat_calendar_amd >= A14.dat_calc_start_py AND A13.move_fg = 1
 OR A12.dat_calendar_amd BETWEEN A14.dat_calc_start_py AND A14.dat_calc_end_py
 OR A12.dat_calendar_amd >= A14.dat_calc_start_py AND A14.dat_calc_end_py IS NULL;