CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_problemgruppe (system_id, mandant_id, problemgruppe_id) AS SELECT
 system_id,
 mandant_id,
 problemgruppe_id
FROM kfl_production_dbp_data.l_problemgruppe;