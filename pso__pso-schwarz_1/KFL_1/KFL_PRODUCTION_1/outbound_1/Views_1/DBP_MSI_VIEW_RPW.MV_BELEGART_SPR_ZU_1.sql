CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_belegart_spr_zu_1 (mandant_id, belegart_id, spr_id, belegart_bez
, system_id) AS SELECT mandant_id,
 belegart_id,
 spr_id,
 belegart_bez,
 system_id
FROM kfl_production_dbp_view.v_belegart_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;