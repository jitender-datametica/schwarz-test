-- 10.07.2023 snik: SPEC0202038 WG to ART
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_art_wg_zu (mandant_id,
arthiertyp_id, art_id, wug_id, wg_id, dat_von, dat_bis) AS SELECT mandant_id,
 arthiertyp_id,
 art_id,
 wug_id,
 wg_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_art_wg_zu_per AS v01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';