CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_tarifgebiet_spr_zu (mandant_id, tarifgebiet_id, spr_id,
tarifgebiet_bez) AS SELECT *
FROM kfl_production_dbp_view.v_tarifgebiet_spr_zu AS v01
WHERE spr_id = 22;