CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagerbereich_2 AS SELECT lagerbereich_id,
 lagernummer_id,
 wup_id,
 nb_id,
 mandant_id,
 lagertyp_id,
 lagersortiment_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lagerbereich_2;