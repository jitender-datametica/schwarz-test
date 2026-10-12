CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_artkz_posten_2 (posten_id, posten_bez, mandant_id, spr_id) AS
SELECT posten_id,
 posten_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_posten_2
WHERE posten_id IN ('PN', '')
 AND mandant_id = 1
 AND spr_id = 22;