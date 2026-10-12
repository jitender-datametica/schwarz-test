CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_dataavail_store_load_status_present_today AS SELECT MAIN.client_id,
 MAIN.country_name_short,
 MAIN.country_name,
 MAIN.wh_id,
 MAIN.wh_desc,
 MAIN.wh_type,
 MAIN.orig_store_nr,
 MAIN.store_desc,
 MAIN.system_key,
 MAIN.system_desc,
 MAIN.dat_dayend,
 MAIN.week,
 MAIN.week_name,
 MAIN.week_id,
 MAIN.month,
 MAIN.month_name,
 MAIN.month_id,
 MAIN.year,
 MAIN.country_flag,
 MAIN.country_name_flag,
 COUNT(DISTINCT MAIN.interface_key) AS expected_total,
 SUM(MAIN.is_missing_mandatory) AS missing_mandatory_total,
 SUM(MAIN.is_missing_optional) AS missing_optional_total,
  COUNT(DISTINCT MAIN.interface_key) - (SUM(MAIN.is_missing_mandatory) + SUM(MAIN.is_missing_optional)) AS
 received_total,
  CASE
  WHEN MAIN.system_key = 2 AND SUM(MAIN.is_missing_mandatory) >= 1 OR MAIN.system_key = 13 AND SUM(MAIN.is_missing_mandatory
      ) >= 1
  THEN 1
  ELSE 0
  END AS missed_fg,
  CASE
  WHEN CASE
    WHEN MAIN.system_key = 2 AND SUM(MAIN.is_missing_mandatory) >= 1 OR MAIN.system_key = 13 AND SUM(MAIN.is_missing_mandatory
        ) >= 1
    THEN 1
    ELSE 0
    END = 0
  THEN 'OK'
  ELSE 'Fehlt'
  END AS missed_fg_desc,
  CASE
  WHEN SUM(MAIN.is_missing_mandatory) > 0 AND COUNT(DISTINCT MAIN.interface_key) - (SUM(MAIN.is_missing_mandatory) + SUM(MAIN
        .is_missing_optional)) > 0
  THEN 1
  ELSE 0
  END AS incomplete_fg,
 MIN(FT.first_trans_date) AS first_trans_date
FROM ldl_bcbi_fe_mstr_bcbi.v_dataavail_store_detail_today AS MAIN
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.v_dataavail_store_first_transfer AS FT ON MAIN.client_id = FT.client_id AND MAIN.wh_id
       = FT.wh_id AND MAIN.orig_store_nr = FT.orig_store_nr AND MAIN.system_key = FT.system_key AND MAIN.dat_dayend = FT
    .dat_dayend AND MAIN.is_missing_mandatory > 0
GROUP BY MAIN.client_id,
 MAIN.country_name_short,
 MAIN.country_name,
 MAIN.wh_id,
 MAIN.wh_desc,
 MAIN.wh_type,
 MAIN.orig_store_nr,
 MAIN.store_desc,
 MAIN.system_key,
 MAIN.system_desc,
 MAIN.dat_dayend,
 MAIN.week,
 MAIN.week_name,
 MAIN.week_id,
 MAIN.month,
 MAIN.month_name,
 MAIN.month_id,
 MAIN.year,
 MAIN.country_flag,
 MAIN.country_name_flag;