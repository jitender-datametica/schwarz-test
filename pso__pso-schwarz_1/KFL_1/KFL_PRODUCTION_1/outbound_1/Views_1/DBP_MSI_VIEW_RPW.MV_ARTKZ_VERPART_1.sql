CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_artkz_verpart_1 (verpart_id, verpart_bez, mandant_id, spr_id,
system_id) AS SELECT verpart_id,
 verpart_bez,
 mandant_id,
 spr_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_artkz_verpart_1
WHERE mandant_id = 1;