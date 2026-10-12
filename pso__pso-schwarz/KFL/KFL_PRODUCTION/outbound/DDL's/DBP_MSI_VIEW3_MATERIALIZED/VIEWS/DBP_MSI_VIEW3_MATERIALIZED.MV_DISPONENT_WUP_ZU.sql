CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_disponent_wup_zu (mandant_id, wup_id, nb_id,
disponent_id, disponent_name) AS SELECT mandant_id,
 wup_id,
 nb_id,
 disponent_id,
 disponent_name
FROM kfl_production_dbp_view.v_disponent_wup_zu;