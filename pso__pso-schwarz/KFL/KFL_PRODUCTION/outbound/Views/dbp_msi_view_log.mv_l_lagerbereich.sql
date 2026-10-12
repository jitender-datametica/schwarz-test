CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagerbereich (lagerbereich_id, lagernummer_id, lagertyp_id,
mandant_id, nb_id, wup_id) AS SELECT lagerbereich_id,
 lagernummer_id,
 lagertyp_id,
 mandant_id,
 nb_id,
 wup_id
FROM kfl_production_dbp_view.v_l_lagerbereich;