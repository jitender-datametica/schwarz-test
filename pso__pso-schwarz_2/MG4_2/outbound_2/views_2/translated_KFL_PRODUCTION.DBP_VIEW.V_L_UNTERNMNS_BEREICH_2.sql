CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_unternmns_bereich_2 (mandant_id, unternehmens_bereich_id) AS SELECT
 mandant_id,
 unternehmens_bereich_id
FROM kfl_production_dbp_data.l_unternmns_bereich_2;