CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_plan_wh_country_kpges (client_id, wh_id, aspect_id, indicator_id, byr,
cy_month, val_indicator, currency_iso_cd, curr_tot_id) AS SELECT IMON.client_id,
 IMON.org_unit_nr AS wh_id,
  CASE
  WHEN IMON.org_type_id = 50
  THEN 1
  ELSE 2
  END AS aspect_id,
 IMON.indicator_id,
 CM.busyear AS byr,
 ROUND(CAST(CONCAT(IMON.cy, CASE
     WHEN LENGTH(SUBSTR(CAST(IMON.month_id AS STRING), 1, 39)) = 1
     THEN LPAD(SUBSTR(CAST(IMON.month_id AS STRING), 1, 39), 2, '0')
     ELSE CAST(IMON.month_id AS STRING)
     END) AS NUMERIC), 0) AS cy_month,
  CASE
  WHEN IMON.indicator_id IN (105, 108, 112, 117, 120, 125, 126, 133, 135, 136, 146, 155, 156, 157, 158, 161, 162, 163,
    168, 169, 170, 172, 174, 177, 179, 203, 204, 209, 210, 212, 216, 225, 228, 229, 230, 238, 240, 242, 243, 244, 250,
    251, 252, 256, 257, 258, 259, 260, 261, 270, 271, 272, 273, 276, 280, 281, 282, 283, 284, 286, 288, 289, 151, 293,
    302, 304, 306, 308, 310, 312, 314)
  THEN IMON.val_indicator / CRY.rate_currency_exchange
  ELSE IMON.val_indicator
  END AS val_indicator,
 CRY.currency_iso_cd,
 CRY.curr_tot_id
FROM ldl_p_lew_core_ac.v_wawi_indicator_month AS IMON
 INNER JOIN ldl_p_lew_mart_lead.v_ref_currency AS CRY ON IMON.client_id = CRY.client_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_month AS CM ON IMON.cy = CM.cy AND IMON.month_id = CM.month_id
WHERE IMON.org_type_id IN (50, 60)
 AND IMON.indicator_type_id = 2
UNION DISTINCT
SELECT IMON.client_id,
  IMON.client_id * -1 AS wh_id,
 1 AS aspect_id,
 IMON.indicator_id,
 CM.busyear AS byr,
 ROUND(CAST(CONCAT(IMON.cy, CASE
     WHEN LENGTH(SUBSTR(CAST(IMON.month_id AS STRING), 1, 39)) = 1
     THEN LPAD(SUBSTR(CAST(IMON.month_id AS STRING), 1, 39), 2, '0')
     ELSE CAST(IMON.month_id AS STRING)
     END) AS NUMERIC), 0) AS cy_month,
  CASE
  WHEN IMON.indicator_id IN (105, 108, 112, 117, 120, 125, 126, 133, 135, 136, 146, 155, 156, 157, 158, 161, 162, 163,
    168, 169, 170, 172, 174, 177, 179, 203, 204, 209, 210, 212, 216, 225, 228, 229, 230, 238, 240, 242, 243, 244, 250,
    251, 252, 256, 257, 258, 259, 260, 261, 270, 271, 272, 273, 276, 280, 281, 282, 283, 284, 286, 288, 289, 151, 293,
    302, 304, 306, 308, 310, 312, 314)
  THEN IMON.val_indicator / CRY.rate_currency_exchange
  ELSE IMON.val_indicator
  END AS val_indicator,
 CRY.currency_iso_cd,
 CRY.curr_tot_id
FROM ldl_p_lew_core_ac.v_wawi_indicator_month AS IMON
 INNER JOIN ldl_p_lew_mart_lead.v_ref_currency AS CRY ON IMON.client_id = CRY.client_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_month AS CM ON IMON.cy = CM.cy AND IMON.month_id = CM.month_id
WHERE IMON.org_type_id IN (20)
 AND IMON.indicator_type_id = 2;