CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_vt_gf (vt_gf_id, vt_gf_name, mandant_id) AS SELECT gf_id
 AS vt_gf_id,
 gf_name AS vt_gf_name,
 mandant_id
FROM kfl_production_dbp_view.v_gf
WHERE mandant_id <> 1
 AND ek_fg = 0
 AND gf_id > 0;