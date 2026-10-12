CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_dataavail_wh_detail_today AS SELECT EX.client_id,
 COUNTRY.country_iso AS country_name_short,
 COUNTRY.country_name,
 EX.wh_id,
 EX.wh_desc,
 EX.wh_type,
 EX.system_key,
 EX.system_desc,
 EX.interface_key,
 EX.interface_desc,
 dates.cal_dt AS dat_dayend,
 CALWEEK.week_of_year AS week,
 CALWEEK.cy_week_short_name AS week_name,
 CALWEEK.cy_week AS week_id,
 dates.month_of_year AS month,
 dates.month_of_year_name AS month_name,
 dates.cy_month AS month_id,
 dates.cy AS year,
 dates.bus_year,
 CONCAT('<img src="../images/_custom/lidl/BCBI/Laenderflaggen/Flaggen_RGB_', COUNTRY.country_name,
  '.png" style="width:25px"/>') AS country_flag,
 CONCAT('<span>', '<img src="../images/_custom/lidl/BCBI/Laenderflaggen/Flaggen_RGB_', COUNTRY.country_name,
  '.png" style="width:25px;margin-right:15px;padding-top:5px"/>', COUNTRY.country_name, '</span>') AS country_name_flag
 ,
 lsp.mail_rows,
 IFNULL(lsp.trans_fg, 0) AS is_transformed,
  CASE
  WHEN EX.system_key IN (6, 16, 10, 11, 8, 9, 14, 20, 21, 18) AND dates.cal_dt BETWEEN EX.dat_rec_start AND EX.dat_rec_end
       AND lsp.mail_rows IS NULL AND NOT EX.is_optional
  THEN 1
  WHEN EX.system_key = 5 AND EX.interface_key = 203 AND lsp.mail_rows >= 0 AND dates.cal_dt BETWEEN EX.dat_rec_start AND
     EX.dat_rec_end AND NOT EX.is_optional
  THEN 0
  WHEN EX.system_key IN (3, 4, 5) AND dates.cal_dt BETWEEN EX.dat_rec_start AND EX.dat_rec_end AND COALESCE(lsp.mail_rows
      , 0) = 0 AND NOT EX.is_optional
  THEN 1
  ELSE 0
  END AS is_missing_mandatory,
  CASE
  WHEN EX.is_optional AND EX.system_key IN (6, 16, 10, 11, 8, 9, 14, 20, 21, 18) AND dates.cal_dt BETWEEN EX.dat_rec_start
     AND EX.dat_rec_end AND lsp.mail_rows IS NULL
  THEN 1
  WHEN EX.is_optional AND EX.system_key = 5 AND EX.interface_key = 203 AND lsp.mail_rows >= 0 AND dates.cal_dt BETWEEN
    EX.dat_rec_start AND EX.dat_rec_end
  THEN 0
  WHEN EX.is_optional AND EX.system_key IN (3, 4, 5) AND dates.cal_dt BETWEEN EX.dat_rec_start AND EX.dat_rec_end AND
    COALESCE(lsp.mail_rows, 0) = 0
  THEN 1
  ELSE 0
  END AS is_missing_optional,
   CASE
   WHEN EX.system_key IN (6, 16, 10, 11, 8, 9, 14, 20, 21, 18) AND dates.cal_dt BETWEEN EX.dat_rec_start AND EX.dat_rec_end
        AND lsp.mail_rows IS NULL AND NOT EX.is_optional
   THEN 1
   WHEN EX.system_key = 5 AND EX.interface_key = 203 AND lsp.mail_rows >= 0 AND dates.cal_dt BETWEEN EX.dat_rec_start
      AND EX.dat_rec_end AND NOT EX.is_optional
   THEN 0
   WHEN EX.system_key IN (3, 4, 5) AND dates.cal_dt BETWEEN EX.dat_rec_start AND EX.dat_rec_end AND COALESCE(lsp.mail_rows
       , 0) = 0 AND NOT EX.is_optional
   THEN 1
   ELSE 0
   END + CASE
   WHEN EX.is_optional AND EX.system_key IN (6, 16, 10, 11, 8, 9, 14, 20, 21, 18) AND dates.cal_dt BETWEEN EX.dat_rec_start
      AND EX.dat_rec_end AND lsp.mail_rows IS NULL
   THEN 1
   WHEN EX.is_optional AND EX.system_key = 5 AND EX.interface_key = 203 AND lsp.mail_rows >= 0 AND dates.cal_dt BETWEEN
     EX.dat_rec_start AND EX.dat_rec_end
   THEN 0
   WHEN EX.is_optional AND EX.system_key IN (3, 4, 5) AND dates.cal_dt BETWEEN EX.dat_rec_start AND EX.dat_rec_end AND
     COALESCE(lsp.mail_rows, 0) = 0
   THEN 1
   ELSE 0
   END AS is_missing,
 COALESCE(lsp_prev.is_missing, 0) AS is_prev_missing
FROM ldl_bcbi_fe_mstr_bcbi.t_dataavail_wh_expected_list AS EX
 INNER JOIN (SELECT cal_dt,
   month_of_year,
   month_of_year_name,
   cy_month,
   cy,
   bus_year,
   cy_week
  FROM ldl_bcbi_fe_mstr_bcbi.t_dim_cal_day
  WHERE cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 31 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))) AS dates ON
  dates.cal_dt BETWEEN EX.dat_rec_start AND EX.dat_rec_end
 LEFT JOIN (SELECT LSP.client_id,
   wh.wh_id,
   LSP.system_key,
   LSP.interface_key,
   LSP.dat_dayend,
   LSP.mail_rows,
   LSP.trans_fg,
   LSP.timestamp_load_bcbi
  FROM ldl_bcbi_fe_mstr_bcbi.t_wawi_sys_load_status_present AS LSP
   INNER JOIN (SELECT DISTINCT src_wh_id AS wh_id,
     loc_sid_wh,
     dwh_valid_from,
     dwh_valid_to
    FROM ldl_bcbi_fe_mstr_bcbi.t_warehouse) AS wh ON LSP.wh_loc_sid = wh.loc_sid_wh AND LSP.dat_dayend BETWEEN wh.dwh_valid_from
     AND wh.dwh_valid_to
  WHERE DATE(LSP.timestamp_load_bcbi) = CURRENT_DATE
   AND LSP.system_key NOT IN (2, 13)) AS lsp ON EX.client_id = lsp.client_id AND EX.wh_id = lsp.wh_id AND EX.system_key
     = lsp.system_key AND EX.interface_key = lsp.interface_key AND dates.cal_dt = lsp.dat_dayend
 LEFT JOIN (SELECT t9.client_id,
   t9.wh_id,
   t9.system_key,
   t9.interface_key,
   t9.timestamp_load_bcbi,
   DATE_ADD(MAX(t9.dat_dayend), INTERVAL 1 DAY) AS dat_dayend,
   MAX(t9.is_missing) AS is_missing
  FROM (SELECT LSP0.client_id,
     wh.wh_id,
     LSP0.system_key,
     LSP0.interface_key,
     LSP0.dat_dayend,
     LSP0.timestamp_load_bcbi,
     MAX(CASE
       WHEN EX0.system_key = 5 AND EX0.interface_key = 203 AND LSP0.mail_rows >= 0 AND LSP0.dat_dayend BETWEEN EX0.dat_rec_start
          AND EX0.dat_rec_end AND NOT EX0.is_optional
       THEN 0
       WHEN EX0.system_key IN (2, 13, 4, 6, 16, 10, 11, 8, 9, 14, 20, 21, 18) AND LSP0.dat_dayend BETWEEN EX0.dat_rec_start
            AND EX0.dat_rec_end AND LSP0.mail_rows IS NULL AND NOT EX0.is_optional OR EX0.system_key IN (3, 5) AND LSP0
            .dat_dayend BETWEEN EX0.dat_rec_start AND EX0.dat_rec_end AND COALESCE(LSP0.mail_rows, 0) = 0 AND NOT EX0.is_optional
         
       THEN 1
       ELSE 0
       END) AS is_missing
    FROM ldl_bcbi_fe_mstr_bcbi.t_wawi_sys_load_status_present AS LSP0
     INNER JOIN (SELECT DISTINCT src_wh_id AS wh_id,
       loc_sid_wh,
       dwh_valid_from,
       dwh_valid_to
      FROM ldl_bcbi_fe_mstr_bcbi.t_warehouse) AS wh ON LSP0.wh_loc_sid = wh.loc_sid_wh AND LSP0.dat_dayend BETWEEN wh.dwh_valid_from
       AND wh.dwh_valid_to
     INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_dataavail_wh_expected_list AS EX0 ON LSP0.client_id = EX0.client_id AND wh.wh_id
          = EX0.wh_id AND LSP0.system_key = EX0.system_key AND LSP0.interface_key = EX0.interface_key
    WHERE DATE(LSP0.timestamp_load_bcbi) = CURRENT_DATE
     AND LSP0.dat_dayend < DATE_SUB(DATE(LSP0.timestamp_load_bcbi), INTERVAL 1 DAY)
     AND LSP0.system_key NOT IN (2, 13)
    GROUP BY LSP0.client_id,
     wh.wh_id,
     LSP0.system_key,
     LSP0.interface_key,
     LSP0.dat_dayend,
     LSP0.timestamp_load_bcbi) AS t9
  GROUP BY t9.client_id,
   t9.wh_id,
   t9.system_key,
   t9.interface_key,
   t9.timestamp_load_bcbi) AS lsp_prev ON lsp.client_id = lsp_prev.client_id AND lsp.wh_id = lsp_prev.wh_id AND lsp.system_key
       = lsp_prev.system_key AND lsp.interface_key = lsp_prev.interface_key AND lsp.dat_dayend = lsp_prev.dat_dayend AND
   lsp.timestamp_load_bcbi = lsp_prev.timestamp_load_bcbi
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_week AS CALWEEK ON dates.cy_week = CALWEEK.cy_week
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_country AS COUNTRY ON EX.client_id = COUNTRY.client_id;