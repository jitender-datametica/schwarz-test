CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_10_230_ptm_region_hist_1 (client_id, landkzl, whno, loc_sid_wh,
region_code, region_id, description, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 landkzl,
 whno,
 loc_sid_wh,
 region_code,
 region_id,
 description,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_10_230_ptm_region_hist_1;