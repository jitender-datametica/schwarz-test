CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_unternmns_bereich_spr_zu_pl_1 (mandant_id,
unternehmens_bereich_id, spr_id, unternehmens_bereich_bez) AS SELECT mandant_id,
 unternehmens_bereich_id,
 spr_id,
 unternehmens_bereich_bez
FROM kfl_production_dbp_view.v_unternmns_bereich_spr_zu_1 AS V01
WHERE spr_id = 90;