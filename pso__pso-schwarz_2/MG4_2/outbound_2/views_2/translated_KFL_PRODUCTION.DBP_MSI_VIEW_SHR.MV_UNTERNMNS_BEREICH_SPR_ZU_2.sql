CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_unternmns_bereich_spr_zu_2 (mandant_id, unternehmens_bereich_id
, spr_id, unternehmens_bereich_bez) AS SELECT *
FROM kfl_production_dbp_view.v_unternmns_bereich_spr_zu_2 AS v01
WHERE spr_id = 22;