CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_time_quota_1 AS SELECT client_id,
 country_iso,
 wh_id,
 loc_sid_wh,
 wh_desc,
 loc_sid_store,
 orig_store_nr,
 store_desc,
 dat_open,
 week,
 week_name,
 week_id,
 month,
 month_name,
 month_id,
 year,
 source_system,
 SUM(CASE
   WHEN missing_fg = 0
   THEN 1
   ELSE 0
   END) AS received_fg,
 COUNT(dat_open) AS expected_fg,
  COUNT(dat_open) - SUM(CASE
    WHEN missing_fg = 0
    THEN 1
    ELSE 0
    END) AS missed_fg,
  SUM(CASE
    WHEN missing_fg = 0
    THEN 1
    ELSE 0
    END) / COUNT(dat_open) AS quota
FROM ldl_bcbi_fe_mstr_bcbi.v_time_detail_1 AS DETAIL
GROUP BY client_id,
 country_iso,
 wh_id,
 loc_sid_wh,
 wh_desc,
 loc_sid_store,
 orig_store_nr,
 store_desc,
 dat_open,
 week,
 week_name,
 week_id,
 month,
 month_name,
 month_id,
 year,
 source_system
ORDER BY quota DESC NULLS FIRST;