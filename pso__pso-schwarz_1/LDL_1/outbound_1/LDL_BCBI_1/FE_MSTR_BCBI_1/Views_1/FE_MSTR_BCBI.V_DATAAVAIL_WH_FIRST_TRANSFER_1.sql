CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_dataavail_wh_first_transfer_1 AS SELECT t4.client_id,
 t4.wh_id,
 t4.system_key,
 t4.dat_dayend,
 MIN(DATE(t4.timestamp_load_bcbi)) AS first_trans_date
FROM (SELECT LSP.client_id,
   wh.wh_id,
   LSP.system_key,
   LSP.dat_dayend,
   LSP.timestamp_load_bcbi,
   SUM(CASE
     WHEN EX.system_key IN (4, 6, 16, 10, 11, 8, 9, 14, 20, 21, 18) AND LSP.mail_rows IS NULL
     THEN 1
     WHEN EX.system_key = 5 AND EX.interface_key = 203 AND LSP.mail_rows >= 0
     THEN 0
     WHEN EX.system_key IN (3, 5) AND COALESCE(LSP.mail_rows, 0) = 0
     THEN 1
     ELSE 0
     END) AS missing_total
  FROM ldl_bcbi_fe_mstr_bcbi.t_wawi_sys_load_status_present_1 AS LSP
   INNER JOIN (SELECT DISTINCT src_wh_id AS wh_id,
     loc_sid_wh,
     dwh_valid_from,
     dwh_valid_to
    FROM ldl_bcbi_fe_mstr_bcbi.t_warehouse_1) AS wh ON LSP.wh_loc_sid = wh.loc_sid_wh AND LSP.dat_dayend BETWEEN wh.dwh_valid_from
     AND wh.dwh_valid_to
   INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_dataavail_wh_expected_list_1 AS EX ON LSP.client_id = EX.client_id AND wh.wh_id = EX
        .wh_id AND LSP.system_key = EX.system_key AND LSP.interface_key = EX.interface_key AND LSP.dat_dayend BETWEEN EX
     .dat_rec_start AND EX.dat_rec_end
  WHERE LSP.dat_dayend < DATE(LSP.timestamp_load_bcbi)
   AND LSP.dat_dayend >= DATE '2022-04-23'
   AND LSP.system_key NOT IN (2, 13)
   AND NOT EX.is_optional
  GROUP BY LSP.client_id,
   wh.wh_id,
   LSP.system_key,
   LSP.dat_dayend,
   LSP.timestamp_load_bcbi
  HAVING missing_total = 0) AS t4
GROUP BY t4.client_id,
 t4.wh_id,
 t4.system_key,
 t4.dat_dayend;