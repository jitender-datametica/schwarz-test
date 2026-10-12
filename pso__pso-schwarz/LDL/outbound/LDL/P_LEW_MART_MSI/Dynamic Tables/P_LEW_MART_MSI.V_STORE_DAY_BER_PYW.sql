CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_store_day_ber_pyw AS
SELECT A.client_id,
 A.loc_sid AS store_id,
 CRY.currency_iso_cd,
 B.dat_calendar AS dat_formdate,
  A.sales_gross_val / CRY.rate_currency_exchange AS val_retail_asis_ber,
  A.sales_net_val / CRY.rate_currency_exchange AS val_retail_net_asis_ber,
 A.cnt_customer AS cnt_customer_asis_ber
FROM ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day AS A
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON A.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS B ON A.dwh_cal_dt = B.prev_cy_dat_calendar_samewday
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_reloc_act AS REL ON A.client_id = REL.client_id AND A.loc_sid = REL.st_loc_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_act AS OSA ON A.client_id = OSA.client_id AND A.loc_sid = OSA.st_loc_sid
   AND OSA.test_store_fg = 0 AND CURRENT_DATE >= OSA.dat_opening
WHERE B.dat_calendar >= OSA.dat_calc_start_py AND REL.move_fg = 1
 OR B.dat_calendar BETWEEN OSA.dat_calc_start_py AND OSA.dat_calc_end_py
 OR B.dat_calendar >= OSA.dat_calc_start_py AND OSA.dat_calc_end_py IS NULL;
