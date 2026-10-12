CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS
-- Mapping wh_loc_sid zu wawi wh_id fuer folgenden CROSS JOIN auf MSI Objekt
 SELECT A.client_id,
 WH.src_wh_id AS wh_id,
 A.st_loc_sid AS store_id,
 A.orig_store_nr,
 A.dat_formdate_from,
 A.dat_formdate_until,
 A.load_in_progress_fg
FROM ldl_p_lew_mart_msi.t_msi_sys_revision_load_store_wrk_1 AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON A.client_id = WH.client_id AND A.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1;