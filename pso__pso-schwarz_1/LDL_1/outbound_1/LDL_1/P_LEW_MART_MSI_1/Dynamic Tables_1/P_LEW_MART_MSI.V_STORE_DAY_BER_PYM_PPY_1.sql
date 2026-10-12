CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_store_day_ber_pym_ppy_1 AS
SELECT AGG.client_id,
 CRY.currency_iso_cd,
 AGG.loc_sid AS store_id,
 A12.dat_calendar_amd AS dat_formdate,
  AGG.sales_gross_val / CRY.rate_currency_exchange AS val_retail_asis_ber,
  AGG.sales_net_val / CRY.rate_currency_exchange AS val_retail_net_asis_ber,
 AGG.cnt_customer AS cnt_customer_asis_ber
FROM ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_1 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_mart_msi.v_cal_month_ber_1 AS A12 ON AGG.dwh_cal_dt = A12.dat_calendar_pyd
 INNER JOIN ldl_p_lew_mart_msi.v_org_all_store_reloc_1 AS A13 ON AGG.client_id = A13.client_id AND AGG.loc_sid = A13.store_id
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_act_1 AS STORE ON A13.client_id = STORE.client_id AND A13.store_id = STORE
     .st_loc_sid AND STORE.test_store_fg = 0 AND CURRENT_DATE >= STORE.dat_opening
WHERE A12.dat_calendar_amd BETWEEN STORE.dat_calc_start_ppy AND (IF(STORE.dat_calc_end_py = LAST_DAY(STORE.dat_calc_end_py
      ), LAST_DAY(DATE_ADD(STORE.dat_calc_end_py, INTERVAL 12 MONTH)), DATE_ADD(STORE.dat_calc_end_py, INTERVAL 12 MONTH)
    ))
 OR A12.dat_calendar_amd >= STORE.dat_calc_start_ppy AND A13.move_fg = 1
 OR A12.dat_calendar_amd >= STORE.dat_calc_start_ppy AND STORE.dat_calc_end_py IS NULL;