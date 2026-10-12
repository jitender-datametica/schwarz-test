CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_kjmo_spr_zu_1 (kjmo, kjmo_bez, kjmo_bez_lang, gjmo) AS SELECT
 kjmo,
 kjmo_bez,
 kjmo_bez_lang,
 gjmo
FROM kfl_production_dbp_view.v_kjmo_spr_zu_1 AS V01
WHERE spr_id = 22;