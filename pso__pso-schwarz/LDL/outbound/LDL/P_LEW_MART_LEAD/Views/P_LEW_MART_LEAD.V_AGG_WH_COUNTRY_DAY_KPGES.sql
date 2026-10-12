CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_wh_country_day_kpges (client_id, wh_id, indicator_id, dat_formdate,
cy_week, cy_month, byr, val_indicator, currency_iso_cd, curr_tot_id) AS SELECT KPGES.client_id,
 KPGES.wh_id,
 KPGES.indicator_id,
 KPGES.dat_formdate,
 DCD.cy_week,
 DCD.cy_month,
 DCD.bus_year AS byr,
 KPGES.val_indicator,
 KPGES.currency_iso_cd,
 CUR.curr_tot_id
FROM ldl_p_lew_mart_msi.v_kpges_day_wh_merge AS KPGES
 INNER JOIN ldl_p_lew_bil_ac.v_dim_cal_day AS DCD ON KPGES.dat_formdate = DCD.cal_dt
 INNER JOIN ldl_p_lew_mart_lead.v_ref_currency AS CUR ON KPGES.client_id = CUR.client_id AND KPGES.currency_iso_cd = CUR
   .currency_iso_cd
UNION DISTINCT
SELECT KPGES.client_id,
  -1 * KPGES.client_id AS wh_id,
 KPGES.indicator_id,
 KPGES.dat_formdate,
 DCD.cy_week,
 DCD.cy_month,
 DCD.bus_year AS byr,
 KPGES.val_indicator,
 KPGES.currency_iso_cd,
 CUR.curr_tot_id
FROM ldl_p_lew_mart_msi.v_kpges_day_country AS KPGES
 INNER JOIN ldl_p_lew_bil_ac.v_dim_cal_day AS DCD ON KPGES.dat_formdate = DCD.cal_dt
 INNER JOIN ldl_p_lew_mart_lead.v_ref_currency AS CUR ON KPGES.client_id = CUR.client_id AND KPGES.currency_iso_cd = CUR
   .currency_iso_cd
WHERE KPGES.val_indicator <> 0;