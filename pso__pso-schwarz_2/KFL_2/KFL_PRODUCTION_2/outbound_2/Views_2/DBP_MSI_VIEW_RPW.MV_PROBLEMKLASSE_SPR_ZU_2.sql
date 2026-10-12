CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_problemklasse_spr_zu_2 (mandant_id, problemklasse_id, spr_id,
problemklasse_bez, problemklasse_bez_kurz, problemklasse_bez_lang, system_id) AS SELECT mandant_id,
 problemklasse_id,
 spr_id,
 problemklasse_bez,
 problemklasse_bez_kurz,
 problemklasse_bez_lang,
 7 AS system_id
FROM kfl_production_dbp_view.v_problemklasse_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;