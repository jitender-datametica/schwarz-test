CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_dataavail_store_expected_list_1 AS SELECT M.client_id,
 C.country_iso,
 wh.src_wh_id AS wh_id,
 lsp_1.wh_desc,
 wha.wh_type,
 lsp_1.orig_store_nr,
 lsp_1.store_desc,
 lsp_2.system_key,
 lsp_2.system_desc,
 lsp_2.interface_key,
 lsp_2.interface_desc,
  CASE
  WHEN lsp_2.interface_key IN (2, 3, 510, 515)
  THEN 1
  ELSE 0
  END AS is_mandatory,
 M.dat_open
FROM ldl_bcbi_fe_mstr_bcbi.t_sys_md_storelist_1 AS M
 INNER JOIN (SELECT DISTINCT src_wh_id,
   loc_sid_wh
  FROM ldl_bcbi_fe_mstr_bcbi.t_warehouse_1) AS wh ON M.loc_sid_wh = wh.loc_sid_wh
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_country_1 AS C ON M.client_id = C.client_id
 INNER JOIN (SELECT DISTINCT client_id,
   wh_id,
   wh_type,
   wh_active_fg,
   dat_rec_start,
   dat_rec_end
  FROM ldl_bcbi_fe_mstr_bcbi.t_dataavail_wh_expected_list_1) AS wha ON M.client_id = wha.client_id AND wh.src_wh_id = wha
     .wh_id AND wha.wh_active_fg AND M.dat_open BETWEEN wha.dat_rec_start AND wha.dat_rec_end
 INNER JOIN (SELECT DISTINCT client_id,
   st_loc_sid,
   orig_store_nr,
   wh_loc_sid,
   wh_desc,
   store_desc
  FROM ldl_bcbi_fe_mstr_bcbi.t_wawi_sys_load_status_present_1
  WHERE st_loc_sid <> 0
   AND dat_dayend > DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY)
   AND DATE(timestamp_load_bcbi) = DATE_ADD(dat_dayend, INTERVAL 1 DAY)
   AND mail_rows IS NOT NULL
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(st_loc_sid AS STRING), CAST(orig_store_nr AS STRING)
        , CAST(wh_loc_sid AS STRING) ORDER BY dat_dayend IS NULL DESC, dat_dayend DESC)) = 1) AS lsp_1 ON M.client_id =
    lsp_1.client_id AND M.loc_sid_store = lsp_1.st_loc_sid AND M.loc_sid_wh = lsp_1.wh_loc_sid
 INNER JOIN (SELECT DISTINCT client_id,
   st_loc_sid,
   wh_loc_sid,
   system_key,
   system_desc,
   interface_key,
   interface_desc
  FROM ldl_bcbi_fe_mstr_bcbi.t_wawi_sys_load_status_present_1
  WHERE st_loc_sid <> 0
   AND dat_dayend > DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY)
   AND DATE(timestamp_load_bcbi) = DATE_ADD(dat_dayend, INTERVAL 1 DAY)
   AND mail_rows IS NOT NULL) AS lsp_2 ON M.client_id = lsp_2.client_id AND M.loc_sid_store = lsp_2.st_loc_sid AND M.loc_sid_wh
    = lsp_2.wh_loc_sid
WHERE M.dat_open BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY));