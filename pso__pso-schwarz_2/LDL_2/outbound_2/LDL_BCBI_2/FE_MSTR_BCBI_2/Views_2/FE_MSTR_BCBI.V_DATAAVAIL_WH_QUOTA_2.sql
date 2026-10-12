CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_dataavail_wh_quota_2 AS SELECT MAIN.dat_dayend,
 MAIN.year,
 MAIN.bus_year,
 MAIN.month,
 MAIN.month_name,
 MAIN.month_id,
 MAIN.week,
 MAIN.week_name,
 MAIN.week_id,
 MAIN.client_id,
 MAIN.country_name_short,
 MAIN.country_name,
 MAIN.country_flag,
 MAIN.wh_id,
 MAIN.wh_desc,
 MAIN.wh_type,
 MAIN.system_key,
 MAIN.system_desc,
 SUM(CASE
   WHEN MAIN.missed_fg = 0
   THEN 1
   ELSE 0
   END) AS received_fg,
 SUM(CASE
   WHEN TODAY.missed_fg = 0
   THEN 1
   ELSE 0
   END) AS received_fg_today,
 COUNT(MAIN.dat_dayend) AS expected_fg,
  COUNT(MAIN.dat_dayend) - SUM(CASE
    WHEN MAIN.missed_fg = 0
    THEN 1
    ELSE 0
    END) AS missed_fg,
  COUNT(MAIN.dat_dayend) - SUM(CASE
    WHEN TODAY.missed_fg = 0
    THEN 1
    ELSE 0
    END) AS missed_fg_today,
  SUM(CASE
    WHEN MAIN.missed_fg = 0
    THEN 1
    ELSE 0
    END) / COUNT(MAIN.dat_dayend) AS quota,
  SUM(CASE
    WHEN TODAY.missed_fg = 0
    THEN 1
    ELSE 0
    END) / COUNT(MAIN.dat_dayend) AS quota_today
FROM ldl_bcbi_fe_mstr_bcbi.v_dataavail_wh_load_status_present_2 AS MAIN
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.v_dataavail_wh_load_status_present_today_2 AS TODAY ON MAIN.client_id = TODAY.client_id
    AND MAIN.wh_id = TODAY.wh_id AND MAIN.system_key = TODAY.system_key AND MAIN.dat_dayend = TODAY.dat_dayend
GROUP BY MAIN.dat_dayend,
 MAIN.year,
 MAIN.bus_year,
 MAIN.month,
 MAIN.month_name,
 MAIN.month_id,
 MAIN.week,
 MAIN.week_name,
 MAIN.week_id,
 MAIN.client_id,
 MAIN.country_name_short,
 MAIN.country_name,
 MAIN.country_flag,
 MAIN.wh_id,
 MAIN.wh_desc,
 MAIN.wh_type,
 MAIN.system_key,
 MAIN.system_desc;