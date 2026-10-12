CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_pers_teilbereich_lagernummer (pers_teilbereich_id,
mandant_id, nb_id, wup_id, lagernummer_id) AS SELECT DISTINCT pers_teilbereich_id,
 mandant_id,
 nb_id,
 wup_id,
 lagernummer_id
FROM kfl_production_dbp_view.v_l_lagernummer AS V01
UNION DISTINCT
SELECT pers_teilbereich_id,
 mandant_id,
 ROUND(CAST('-111' AS BIGNUMERIC), 0) AS nb_id,
 wup_id,
 '-1'
FROM kfl_production_dbp_view.v_l_lagernummer AS V01;