CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_interface_dl
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
/* Gesellschaft */ SELECT A.client_id,
 WH.src_wh_id AS wh_id,
 A.dat_rec_end,
 A.dat_rec_start,
 A.interface_desc,
 A.interface_key,
 A.load_id,
 A.system_desc,
 A.system_key
FROM ldl_p_lew_core_ac.v_wawi_ref_wh_interface AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
WHERE WH.src_wh_id = 0;