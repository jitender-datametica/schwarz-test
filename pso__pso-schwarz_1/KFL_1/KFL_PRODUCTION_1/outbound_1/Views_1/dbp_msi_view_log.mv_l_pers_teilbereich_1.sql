CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_pers_teilbereich_1 (pers_teilbereich_id, mandant_id, nb_id,
wup_id) AS SELECT DISTINCT pers_teilbereich_id,
 mandant_id,
 nb_id,
 wup_id
FROM kfl_production_dbp_view.v_l_lagernummer_1 AS V01;