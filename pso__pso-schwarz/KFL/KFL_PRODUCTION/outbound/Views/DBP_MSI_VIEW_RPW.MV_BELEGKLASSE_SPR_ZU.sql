CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_belegklasse_spr_zu (mandant_id, belegklasse_id, spr_id,
belegklasse_bez, belegklasse_bez_kurz, belegklasse_bez_lang, system_id) AS SELECT mandant_id,
 belegklasse_id,
 spr_id,
 belegklasse_bez,
 belegklasse_bez_kurz,
 belegklasse_bez_lang,
 7 AS system_id
FROM kfl_production_dbp_view.v_belegklasse_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;