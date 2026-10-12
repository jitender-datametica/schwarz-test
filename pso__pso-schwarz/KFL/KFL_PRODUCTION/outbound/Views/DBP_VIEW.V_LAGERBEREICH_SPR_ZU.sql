CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagerbereich_spr_zu AS SELECT spr_id,
 lagerbereich_id,
 lagernummer_id,
 wup_id,
 nb_id,
 mandant_id,
 lagertyp_id,
 lagersortiment_id,
 lagerbereich_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lagerbereich_spr_zu;