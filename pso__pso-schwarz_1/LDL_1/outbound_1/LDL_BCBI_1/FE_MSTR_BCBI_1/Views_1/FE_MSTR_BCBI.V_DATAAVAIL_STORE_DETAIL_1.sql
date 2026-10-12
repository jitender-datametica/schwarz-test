CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_dataavail_store_detail_1 AS SELECT EX.client_id,
 COUNTRY.country_iso AS country_name_short,
 COUNTRY.country_name,
 EX.wh_id,
 EX.wh_desc,
 EX.wh_type,
 EX.orig_store_nr,
 EX.store_desc,
 EX.system_key,
 EX.system_desc,
 EX.interface_key,
 EX.interface_desc,
 EX.dat_open AS dat_dayend,
 CALWEEK.week_of_year AS week,
 CALWEEK.cy_week_short_name AS week_name,
 CALWEEK.cy_week AS week_id,
 CALDAY.month_of_year AS month,
 CALDAY.month_of_year_name AS month_name,
 CALDAY.cy_month AS month_id,
 CALDAY.cy AS year,
 CONCAT('<img src="../images/_custom/lidl/BCBI/Laenderflaggen/Flaggen_RGB_', COUNTRY.country_name,
  '.png" style="width:25px"/>') AS country_flag,
 CONCAT('<span>', '<img src="../images/_custom/lidl/BCBI/Laenderflaggen/Flaggen_RGB_', COUNTRY.country_name,
  '.png" style="width:25px;margin-right:15px;padding-top:5px"/>', COUNTRY.country_name, '</span>') AS country_name_flag
 ,
 EX.is_mandatory,
 lsp.mail_rows,
 IFNULL(lsp.trans_fg, 0) AS is_transformed,
  CASE
  WHEN EX.is_mandatory = 1 AND lsp.mail_rows IS NULL
  THEN 1
  ELSE 0
  END AS is_missing_mandatory,
  CASE
  WHEN EX.is_mandatory = 0 AND lsp.mail_rows IS NULL
  THEN 1
  ELSE 0
  END AS is_missing_optional
FROM ldl_bcbi_fe_mstr_bcbi.v_dataavail_store_expected_list_1 AS EX
 LEFT JOIN (SELECT LSP.client_id,
   wh.wh_id,
   LSP.orig_store_nr,
   LSP.store_desc,
   LSP.system_key,
   LSP.interface_key,
   LSP.dat_dayend,
   LSP.mail_rows,
   LSP.trans_fg
  FROM ldl_bcbi_fe_mstr_bcbi.t_wawi_sys_load_status_present_1 AS LSP
   INNER JOIN (SELECT DISTINCT src_wh_id AS wh_id,
     loc_sid_wh,
     dwh_valid_from,
     dwh_valid_to
    FROM ldl_bcbi_fe_mstr_bcbi.t_warehouse_1) AS wh ON LSP.wh_loc_sid = wh.loc_sid_wh AND LSP.dat_dayend BETWEEN wh.dwh_valid_from
     AND wh.dwh_valid_to
  WHERE LSP.system_key IN (2, 13)
   AND LSP.dat_dayend = DATE_SUB(DATE(LSP.timestamp_load_bcbi), INTERVAL 1 DAY)) AS lsp ON EX.client_id = lsp.client_id
      AND EX.wh_id = lsp.wh_id AND EX.orig_store_nr = lsp.orig_store_nr AND EX.system_key = lsp.system_key AND EX.interface_key
     = lsp.interface_key AND EX.dat_open = lsp.dat_dayend
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_day_1 AS CALDAY ON EX.dat_open = CALDAY.cal_dt
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_week_1 AS CALWEEK ON CALDAY.cy_week = CALWEEK.cy_week
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_country_1 AS COUNTRY_1 ON EX.client_id = COUNTRY.client_id;