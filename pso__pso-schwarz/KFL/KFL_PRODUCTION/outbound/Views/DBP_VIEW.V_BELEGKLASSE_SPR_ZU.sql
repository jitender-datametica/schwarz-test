CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belegklasse_spr_zu AS SELECT spr_id,
 mandant_id,
 belegklasse_id,
 system_id,
 belegklasse_bez,
 belegklasse_bez_kurz,
 belegklasse_bez_lang,
 td_update,
 td_insert
FROM kfl_production_dbp_data.belegklasse_spr_zu;