CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_vorgangsklasse_spr_zu_1 (system_id, mandant_id,
vorgangsklasse_id, spr_id, vorgangsklasse_bez, vorgangsklasse_bez_kurz, vorgangsklasse_bez_lang) AS SELECT 7 AS
 system_id,
 mandant_id,
 vorgangsklasse_id,
 spr_id,
 vorgangsklasse_bez,
 vorgangsklasse_bez_kurz,
 vorgangsklasse_bez_lang
FROM kfl_production_dbp_view.v_vorgangsklasse_spr_zu_1
WHERE mandant_id = 1;