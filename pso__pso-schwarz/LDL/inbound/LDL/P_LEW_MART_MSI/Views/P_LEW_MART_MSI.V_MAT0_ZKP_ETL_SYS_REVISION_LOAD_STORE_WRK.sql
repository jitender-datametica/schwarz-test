CREATE OR REPLACE VIEW p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk
AS
SELECT
a.client_id,
wh.src_wh_id AS wh_id,
a.st_loc_sid AS store_id,
a.orig_store_nr,
a.dat_formdate_from,
a.dat_formdate_until,
a.load_in_progress_fg
FROM p_lew_mart_msi.t_msi_sys_revision_load_store_wrk a
-- Mapping wh_loc_sid zu wawi wh_id fuer folgenden Join auf MSI Objekt
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON a.client_id = wh.client_id
  AND a.wh_loc_sid = wh.loc_sid_wh
  AND wh.dwh_actual_fg = 1
;






