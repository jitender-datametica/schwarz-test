CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_artkz_aldi (aldi_id, aldi_bez, mandant_id, spr_id, system_id)
AS SELECT aldi_id,
 aldi_bez,
 mandant_id,
 spr_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_artkz_aldi
WHERE mandant_id = 1;