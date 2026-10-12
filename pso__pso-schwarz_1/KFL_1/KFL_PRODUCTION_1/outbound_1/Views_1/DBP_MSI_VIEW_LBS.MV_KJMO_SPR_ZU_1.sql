CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_kjmo_spr_zu_1 (kjmo, spr_id, kjmo_bez, kjmo_bez_lang, gjmo) AS
SELECT kjmo,
 spr_id,
 kjmo_bez,
 kjmo_bez_lang,
 gjmo
FROM kfl_production_dbp_view.v_kjmo_spr_zu_1;