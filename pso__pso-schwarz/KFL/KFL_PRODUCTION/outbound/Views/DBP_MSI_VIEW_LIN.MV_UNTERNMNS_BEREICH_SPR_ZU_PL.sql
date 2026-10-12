CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_unternmns_bereich_spr_zu_pl (mandant_id,
unternehmens_bereich_id, spr_id, unternehmens_bereich_bez) AS SELECT mandant_id,
 unternehmens_bereich_id,
 spr_id,
 unternehmens_bereich_bez
FROM kfl_production_dbp_view.v_unternmns_bereich_spr_zu
WHERE spr_id = 90;