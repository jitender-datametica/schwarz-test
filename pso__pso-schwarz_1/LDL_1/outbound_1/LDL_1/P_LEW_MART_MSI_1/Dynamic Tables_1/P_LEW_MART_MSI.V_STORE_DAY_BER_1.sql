CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_store_day_ber_1 AS
SELECT A.client_id,
 A.loc_sid AS store_id,
 CRY.currency_iso_cd,
 A.dwh_cal_dt AS dat_formdate,
  A.sales_gross_val / CRY.rate_currency_exchange AS val_retail_asis_ber,
  A.sales_net_val / CRY.rate_currency_exchange AS val_retail_net_asis_ber,
 A.cnt_customer AS cnt_customer_asis_ber
FROM ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_1 AS A
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON A.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_act_1 AS B ON A.client_id = B.client_id AND A.loc_sid = B.st_loc_sid AND B
    .test_store_fg = 0 AND CURRENT_DATE >= B.dat_opening
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_reloc_act_1 AS C ON A.client_id = C.client_id AND A.loc_sid = C.st_loc_sid
   
WHERE A.dwh_cal_dt BETWEEN B.dat_calc_start_py AND B.dat_calc_end_py
 OR A.dwh_cal_dt >= B.dat_calc_start_py AND C.move_fg = 1
 OR A.dwh_cal_dt >= B.dat_calc_start_py AND B.dat_calc_end_py IS NULL;