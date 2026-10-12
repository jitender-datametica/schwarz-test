CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_artkz_leist (leist_id, leist_bez, mandant_id, spr_id,
system_id) AS SELECT leist_id,
 leist_bez,
 mandant_id,
 spr_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_artkz_leist
WHERE mandant_id = 1;