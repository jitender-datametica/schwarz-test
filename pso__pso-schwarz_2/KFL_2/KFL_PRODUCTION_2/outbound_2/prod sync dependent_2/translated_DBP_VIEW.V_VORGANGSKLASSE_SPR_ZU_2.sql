CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vorgangsklasse_spr_zu_2 (system_id, mandant_id, vorgangsklasse_id, spr_id
, vorgangsklasse_bez, vorgangsklasse_bez_kurz, vorgangsklasse_bez_lang) AS SELECT system_id,
 mandant_id,
 vorgangsklasse_id,
 spr_id,
 vorgangsklasse_bez,
 vorgangsklasse_bez_kurz,
 vorgangsklasse_bez_lang
FROM kfl_production_dbp_data.vorgangsklasse_spr_zu_2;