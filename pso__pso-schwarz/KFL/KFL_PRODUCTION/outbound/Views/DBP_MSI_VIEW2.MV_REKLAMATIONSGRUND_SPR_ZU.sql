CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_reklamationsgrund_spr_zu (reklamationsgrund_id,
reklamationsgrund_bez, mandant_id, spr_id) AS SELECT reklamationsgrund_id,
 reklamationsgrund_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_reklamationsgrund_spr_zu
WHERE spr_id = 22
 AND mandant_id = 1;