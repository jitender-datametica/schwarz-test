CREATE OR REPLACE VIEW ldl_p_lew_process.v_wawi_tobelist_p2wk_2 (country_iso_cd, country_id, wh_id, client_id, loc_sid_wh
, interface_desc, interface_key, system_key, ejr, test_flag) AS (SELECT RC.country_iso_cd,
  RC.country_id,
  L.src_wh_id AS wh_id,
  OSS.client_id,
  OSS.wh_loc_sid AS loc_sid_wh,
  NULL AS interface_desc,
  NULL AS interface_key,
  NULL AS system_key,
  1 AS ejr,
  0 AS test_flag
 FROM ldl_p_lew_core_ac.v_wawi_org_store_skey_2 AS OSS
  INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS RCC ON OSS.client_id = RCC.client_id
  INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS RC ON RCC.country_id = RC.country_id
  INNER JOIN ldl_p_lew_core_ac.v_location_2 AS L ON OSS.client_id = L.client_id AND OSS.wh_loc_sid = L.loc_sid
 WHERE CURRENT_DATE BETWEEN OSS.dat_rec_start AND OSS.dat_rec_end
  AND OSS.orig_store_nr <> L.src_wh_id
  AND (RC.country_iso_cd, L.src_wh_id) IN (SELECT (country_iso_cd, CAST(wh_id AS BIGNUMERIC))
    FROM ldl_p_lew_process_ac.v_wawi_sys_dc_trans_dayend_int_2
    WHERE dat_dayend > DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY))
 GROUP BY RC.country_iso_cd,
  RC.country_id,
  wh_id,
  OSS.client_id,
  loc_sid_wh,
  interface_desc,
  interface_key,
  system_key,
  ejr,
  test_flag
 UNION DISTINCT
 SELECT RC.country_iso_cd,
  RC.country_id,
  L.src_wh_id AS wh_id,
  OW.client_id,
  OW.wh_loc_sid AS loc_sid_wh,
  NULL AS interface_desc,
  NULL AS interface_key,
  NULL AS system_key,
  0 AS ejr,
  0 AS test_flag
 FROM ldl_p_lew_core_ac.v_wawi_org_wh_2 AS OW
  INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS RCC ON OW.client_id = RCC.client_id
  INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS RC ON RCC.country_id = RC.country_id
  INNER JOIN ldl_p_lew_core_ac.v_location_2 AS L ON OW.client_id = L.client_id AND OW.wh_loc_sid = L.loc_sid
 WHERE CURRENT_DATE BETWEEN OW.dat_rec_start AND OW.dat_rec_end
  AND OW.wawi_data_fg = 1
  AND L.src_wh_id <> 0
  AND (RC.country_iso_cd, L.src_wh_id) IN (SELECT (country_iso_cd, CAST(wh_id AS BIGNUMERIC))
    FROM ldl_p_lew_process_ac.v_wawi_sys_dc_trans_dayend_int_2
    WHERE dat_dayend > DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY))
  AND (OW.client_id, L.src_wh_id) NOT IN (SELECT (OSS.client_id, L0.src_wh_id)
    FROM ldl_p_lew_core_ac.v_wawi_org_store_skey_2 AS OSS
     INNER JOIN ldl_p_lew_core_ac.v_location_2 AS L0 ON OSS.client_id = L0.client_id AND OSS.wh_loc_sid = L0.loc_sid
    WHERE CURRENT_DATE BETWEEN OSS.dat_rec_start AND OSS.dat_rec_end
     AND OSS.orig_store_nr <> L0.src_wh_id)
 GROUP BY RC.country_iso_cd,
  RC.country_id,
  wh_id,
  OW.client_id,
  loc_sid_wh,
  interface_desc,
  interface_key,
  system_key,
  ejr,
  test_flag)
UNION DISTINCT
SELECT RC.country_iso_cd,
 RC.country_id,
 L.src_wh_id AS wh_id,
 OSS.client_id,
 OSS.wh_loc_sid AS loc_sid_wh,
 NULL AS interface_desc,
 NULL AS interface_key,
 NULL AS system_key,
 0 AS ejr,
 0 AS test_flag
FROM ldl_p_lew_core_ac.v_wawi_org_store_skey_2 AS OSS
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS RCC ON OSS.client_id = RCC.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS RC ON RCC.country_id = RC.country_id
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS L ON OSS.client_id = L.client_id AND OSS.wh_loc_sid = L.loc_sid
WHERE CURRENT_DATE BETWEEN OSS.dat_rec_start AND OSS.dat_rec_end
 AND L.src_wh_id = 0
GROUP BY RC.country_iso_cd,
 RC.country_id,
 wh_id,
 OSS.client_id,
 loc_sid_wh,
 interface_desc,
 interface_key,
 system_key,
 ejr,
 test_flag;