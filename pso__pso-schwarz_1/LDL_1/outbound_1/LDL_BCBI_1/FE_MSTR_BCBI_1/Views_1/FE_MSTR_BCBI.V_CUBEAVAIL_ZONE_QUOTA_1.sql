CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_cubeavail_zone_quota_1 (day, zone, year, bus_year, month, month_name,
month_id, week, week_name, week_id, amount_vta, amount_vvta, amount_nvta, amount_expected, quota_vta, quota_vvta) AS
SELECT day,
 zone,
 year,
 bus_year,
 month,
 month_name,
 month_id,
 week,
 week_name,
 week_name0,
 SUM(CASE
   WHEN zone_status = 'VTA'
   THEN 1
   ELSE 0
   END) AS amount_vta,
 SUM(CASE
   WHEN zone_status = 'VVTA'
   THEN 1
   ELSE 0
   END) AS amount_vvta,
 SUM(CASE
   WHEN zone_status = 'NVTA'
   THEN 1
   ELSE 0
   END) AS amount_nvta,
 COUNT(day) AS expected_fg,
  SUM(CASE
    WHEN zone_status = 'VTA'
    THEN 1
    ELSE 0
    END) / COUNT(day) AS quota_vta,
  SUM(CASE
    WHEN zone_status = 'VVTA'
    THEN 1
    ELSE 0
    END) / COUNT(day) AS quota_vvta
FROM ldl_bcbi_fe_mstr_bcbi.v_cubeavail_zone_detail_1
GROUP BY day,
 zone,
 year,
 bus_year,
 month,
 month_name,
 month_id,
 week,
 week_name,
 week_name0;
