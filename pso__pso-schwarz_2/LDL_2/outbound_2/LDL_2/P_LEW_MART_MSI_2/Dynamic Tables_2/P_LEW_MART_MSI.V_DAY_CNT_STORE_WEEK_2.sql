CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_day_cnt_store_week_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT A.cy_week,
 A.dat_calendar,
 B.client_id,
 C.wh_id,
 B.store_id,
  CASE
  WHEN A.dat_calendar <= B.dat_closing_ovis OR B.dat_closing_ovis IS NULL
  THEN 1
  ELSE 0
  END AS day_cnt
FROM ldl_p_lew_mart_msi.v_cal_calendarday_2 AS A
 INNER JOIN ldl_p_lew_mart_msi.v_org_store_2 AS B ON A.dat_calendar >= B.dat_opening_ovis
 INNER JOIN ldl_p_lew_mart_msi.v_org_store_skey_2 AS C ON B.client_id = C.client_id AND B.store_id = C.store_id
WHERE B.orig_store_nr <> C.wh_id
 AND A.cy_day_sequence <= 0;