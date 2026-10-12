CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_cal_month_cum_new_1 (client_id
OPTIONS(description='Identification of country_1'), ian OPTIONS(description='International Article Number'), busyear
OPTIONS(description='Business year - dependent on country_1 and product'), cal_month OPTIONS(description='calendar_1 month'),
month_byr_cum OPTIONS(description='cumulative month of current business year'), month_prev_byr_cum
OPTIONS(description='cumulative month of previous business year'), month_pprev_byr_cum
OPTIONS(description='cumulative month of previous previous year'))
OPTIONS(DESCRIPTION = `NEW CUMULATIVE MONTH VIEW TO COVER DIFFERENT BUSINESS YEAR LOGIC BASED ON COUNTRY_1 AND PRODUCT`)
AS SELECT t2.client_id,
 t2.ian,
 t2.busyear,
 t2.cal_month,
 t2.month_byr_cum,
 t2.month_prev_byr_cum,
 t2.month_pprev_byr_cum
FROM (SELECT COU.client_id,
   A.ian,
   A.busyear,
   A.cy_month AS cal_month,
   B.cy_month AS month_byr_cum,
    B.cy_month - 100 AS month_prev_byr_cum,
    B.cy_month - 200 AS month_pprev_byr_cum,
   A.cy_month
  FROM ldl_scm_core_rel.v_busyear_month_week_1 AS A
   INNER JOIN ldl_scm_core_rel.v_busyear_month_week_1 AS B ON A.busyear = B.busyear AND A.cy_month >= B.cy_month
   INNER JOIN ldl_scm_core_rel.t_client_1 AS COU ON A.land_1 = COU.country_cd
  GROUP BY COU.client_id,
   A.ian,
   A.busyear,
   A.cy_month,
   month_byr_cum,
   month_prev_byr_cum,
   month_pprev_byr_cum
  ORDER BY COU.client_id NULLS LAST,
   A.ian NULLS LAST,
   cal_month NULLS LAST,
   month_byr_cum NULLS LAST) AS t2;