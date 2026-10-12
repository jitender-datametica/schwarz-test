-- 2024-01-24, dknop, remove v01.mandant_id = 1

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ek_gf_1 (gf_id, gf_name, mandant_id, ek_fg) AS
SELECT gf_id,
 gf_name,
 mandant_id,
 ek_fg
FROM kfl_production_dbp_view.v_gf_1 AS V01
WHERE -- v01.mandant_id = 1 AND
 ek_fg = 1;