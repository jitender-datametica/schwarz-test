CREATE OR REPLACE VIEW kfl_production_dbp_view.v_problemklasse_spr_zu AS SELECT system_id,
 mandant_id,
 problemklasse_id,
 spr_id,
 problemklasse_bez,
 problemklasse_bez_kurz,
 problemklasse_bez_lang,
 td_update,
 td_insert
FROM kfl_production_dbp_data.problemklasse_spr_zu;