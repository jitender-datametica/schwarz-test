CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_store_day_ber_ppyw_2 AS
SELECT A.client_id,
 A.loc_sid_store AS store_id,
 A.currency_iso_cd,
 B.dat_calendar AS dat_formdate,
 A.val_retail_asis AS val_retail_asis_ber,
 A.val_retail_net_asis AS val_retail_net_asis_ber,
 A.cnt_customer_asis AS cnt_customer_asis_ber
FROM ldl_p_lew_bil_ac.v_agg_str_day_ejr_txj_ww_asis_2 AS A
 INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday_2 AS B ON A.dat_formdate = B.ppy_dat_calendar
 INNER JOIN ldl_p_lew_mart_msi.v_org_all_store_reloc_2 AS C ON A.client_id = C.client_id AND A.loc_sid_store = C.store_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_2 AS D ON A.client_id = D.client_id AND A.loc_sid_store = D.st_loc_sid AND
    D.test_store_fg = 0 AND CURRENT_DATE >= D.dat_opening
WHERE B.dat_calendar BETWEEN D.dat_calc_start_ppy AND (IF(D.dat_calc_end_py = LAST_DAY(D.dat_calc_end_py), LAST_DAY(DATE_ADD(D
      .dat_calc_end_py, INTERVAL 12 MONTH)), DATE_ADD(D.dat_calc_end_py, INTERVAL 12 MONTH)))
 OR B.dat_calendar >= D.dat_calc_start_ppy AND C.move_fg = 1
 OR B.dat_calendar >= D.dat_calc_start_ppy AND D.dat_calc_end_py IS NULL;