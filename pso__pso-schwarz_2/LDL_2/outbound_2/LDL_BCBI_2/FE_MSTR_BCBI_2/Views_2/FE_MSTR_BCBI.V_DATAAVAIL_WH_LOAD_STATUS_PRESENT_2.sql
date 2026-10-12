CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_dataavail_wh_load_status_present_2 AS SELECT MAIN.client_id,
 MAIN.country_name_short,
 MAIN.country_name,
 MAIN.wh_id,
 MAIN.wh_desc,
 MAIN.wh_type,
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
 MAIN.bus_year,
 MAIN.country_flag,
 MAIN.country_name_flag,
 MAX(hq_master.is_hq_ma_missing) AS is_hq_master_missing,
 MAX(MAIN.is_prev_missing) AS is_prev_days_missing,
 COUNT(DISTINCT MAIN.interface_key) AS expected_total,
 COUNT(DISTINCT CASE
   WHEN NOT MAIN.is_optional
   THEN MAIN.interface_key
   ELSE NULL
   END) AS expected_mandatory_total,
 COUNT(DISTINCT CASE
   WHEN MAIN.is_optional
   THEN MAIN.interface_key
   ELSE NULL
   END) AS expected_optional_total,
  CASE
  WHEN MAIN.system_key IN (3, 5)
  THEN CAST(COUNT(DISTINCT CASE
     WHEN NOT MAIN.is_optional
     THEN MAIN.interface_key
     ELSE NULL
     END) AS INTEGER)
  ELSE 1
  END AS expected_min,
 SUM(MAIN.is_missing) AS missing_total,
 SUM(MAIN.is_missing_mandatory) AS missing_mandatory_total,
 SUM(MAIN.is_missing_optional) AS missing_optional_total,
  COUNT(DISTINCT MAIN.interface_key) - SUM(MAIN.is_missing) AS received_total,
  COUNT(DISTINCT CASE
    WHEN NOT MAIN.is_optional
    THEN MAIN.interface_key
    ELSE NULL
    END) - SUM(MAIN.is_missing_mandatory) AS received_mandatory_total,
  COUNT(DISTINCT CASE
    WHEN MAIN.is_optional
    THEN MAIN.interface_key
    ELSE NULL
    END) - SUM(MAIN.is_missing_optional) AS received_optional_total,
  CASE
  WHEN MAIN.system_key = 3 AND SUM(MAIN.is_missing_mandatory) >= 1 AND MAX(MAIN.is_prev_missing) = 0
  THEN 1
  WHEN MAIN.system_key = 3 AND MAX(MAIN.is_prev_missing) = 1
  THEN 2
  WHEN MAIN.system_key = 4 AND SUM(MAIN.is_missing_mandatory) >= 1
  THEN 1
  WHEN MAIN.system_key = 4 AND MAX(hq_master.is_hq_ma_missing) = 1
  THEN 3
  WHEN MAIN.system_key = 5 AND SUM(MAIN.is_missing_mandatory) >= 1
  THEN 1
  WHEN MAIN.system_key = 5 AND MAX(hq_master.is_hq_ma_missing) = 1
  THEN 3
  WHEN MAIN.system_key = 5 AND MAX(MAIN.is_prev_missing) = 1
  THEN 2
  WHEN MAIN.system_key IN (6, 16, 10, 11, 8, 9, 14, 18, 20, 21) AND COUNT(DISTINCT MAIN.interface_key) - SUM(MAIN.is_missing
      ) = 0
  THEN 1
  ELSE 0
  END AS missed_fg,
  CASE
  WHEN CASE
    WHEN MAIN.system_key = 3 AND SUM(MAIN.is_missing_mandatory) >= 1 AND MAX(MAIN.is_prev_missing) = 0
    THEN 1
    WHEN MAIN.system_key = 3 AND MAX(MAIN.is_prev_missing) = 1
    THEN 2
    WHEN MAIN.system_key = 4 AND SUM(MAIN.is_missing_mandatory) >= 1
    THEN 1
    WHEN MAIN.system_key = 4 AND MAX(hq_master.is_hq_ma_missing) = 1
    THEN 3
    WHEN MAIN.system_key = 5 AND SUM(MAIN.is_missing_mandatory) >= 1
    THEN 1
    WHEN MAIN.system_key = 5 AND MAX(hq_master.is_hq_ma_missing) = 1
    THEN 3
    WHEN MAIN.system_key = 5 AND MAX(MAIN.is_prev_missing) = 1
    THEN 2
    WHEN MAIN.system_key IN (6, 16, 10, 11, 8, 9, 14, 18, 20, 21) AND COUNT(DISTINCT MAIN.interface_key) - SUM(MAIN.is_missing
        ) = 0
    THEN 1
    ELSE 0
    END = 1
  THEN 'Fehlt'
  WHEN CASE
    WHEN MAIN.system_key = 3 AND SUM(MAIN.is_missing_mandatory) >= 1 AND MAX(MAIN.is_prev_missing) = 0
    THEN 1
    WHEN MAIN.system_key = 3 AND MAX(MAIN.is_prev_missing) = 1
    THEN 2
    WHEN MAIN.system_key = 4 AND SUM(MAIN.is_missing_mandatory) >= 1
    THEN 1
    WHEN MAIN.system_key = 4 AND MAX(hq_master.is_hq_ma_missing) = 1
    THEN 3
    WHEN MAIN.system_key = 5 AND SUM(MAIN.is_missing_mandatory) >= 1
    THEN 1
    WHEN MAIN.system_key = 5 AND MAX(hq_master.is_hq_ma_missing) = 1
    THEN 3
    WHEN MAIN.system_key = 5 AND MAX(MAIN.is_prev_missing) = 1
    THEN 2
    WHEN MAIN.system_key IN (6, 16, 10, 11, 8, 9, 14, 18, 20, 21) AND COUNT(DISTINCT MAIN.interface_key) - SUM(MAIN.is_missing
        ) = 0
    THEN 1
    ELSE 0
    END = 2
  THEN 'LaLüLo'
  WHEN CASE
    WHEN MAIN.system_key = 3 AND SUM(MAIN.is_missing_mandatory) >= 1 AND MAX(MAIN.is_prev_missing) = 0
    THEN 1
    WHEN MAIN.system_key = 3 AND MAX(MAIN.is_prev_missing) = 1
    THEN 2
    WHEN MAIN.system_key = 4 AND SUM(MAIN.is_missing_mandatory) >= 1
    THEN 1
    WHEN MAIN.system_key = 4 AND MAX(hq_master.is_hq_ma_missing) = 1
    THEN 3
    WHEN MAIN.system_key = 5 AND SUM(MAIN.is_missing_mandatory) >= 1
    THEN 1
    WHEN MAIN.system_key = 5 AND MAX(hq_master.is_hq_ma_missing) = 1
    THEN 3
    WHEN MAIN.system_key = 5 AND MAX(MAIN.is_prev_missing) = 1
    THEN 2
    WHEN MAIN.system_key IN (6, 16, 10, 11, 8, 9, 14, 18, 20, 21) AND COUNT(DISTINCT MAIN.interface_key) - SUM(MAIN.is_missing
        ) = 0
    THEN 1
    ELSE 0
    END = 3
  THEN 'HQ Master fehlt'
  ELSE 'OK'
  END AS missed_fg_desc,
  CASE
  WHEN SUM(MAIN.is_missing_mandatory) > 0 AND COUNT(DISTINCT MAIN.interface_key) - SUM(MAIN.is_missing) > 0
  THEN 1
  ELSE 0
  END AS incomplete_fg,
 MIN(FT.first_trans_date) AS first_trans_date
FROM ldl_bcbi_fe_mstr_bcbi.v_dataavail_wh_detail_2 AS MAIN
 LEFT JOIN (SELECT client_id,
   dat_dayend,
   MAX(is_missing_mandatory) AS is_hq_ma_missing
  FROM ldl_bcbi_fe_mstr_bcbi.v_dataavail_wh_detail_2
  WHERE system_key = 3
  GROUP BY client_id,
   dat_dayend) AS hq_master ON MAIN.client_id = hq_master.client_id AND MAIN.dat_dayend = hq_master.dat_dayend
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.v_dataavail_wh_first_transfer_2 AS FT ON MAIN.client_id = FT.client_id AND MAIN.wh_id =
      FT.wh_id AND MAIN.system_key = FT.system_key AND MAIN.dat_dayend = FT.dat_dayend AND MAIN.is_missing_mandatory > 0
   
WHERE MAIN.system_key NOT IN (2, 13)
GROUP BY MAIN.client_id,
 MAIN.country_name_short,
 MAIN.country_name,
 MAIN.wh_id,
 MAIN.wh_desc,
 MAIN.wh_type,
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
 MAIN.bus_year,
 MAIN.country_flag,
 MAIN.country_name_flag;