CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_disponent_wup_zu_1 (mandant_id, wup_id, nb_id, disponent_id,
disponent_name) AS SELECT mandant_id,
 wup_id,
 nb_id,
 disponent_id,
 disponent_name
FROM kfl_production_dbp_view.v_disponent_wup_zu_1
WHERE mandant_id = 1
 AND nb_id <> 99;