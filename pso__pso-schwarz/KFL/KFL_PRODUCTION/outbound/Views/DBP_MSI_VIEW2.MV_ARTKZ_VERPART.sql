CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artkz_verpart (verpart_id, verpart_bez, mandant_id, spr_id) AS
SELECT verpart_id,
 verpart_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_verpart
WHERE mandant_id = 1;