-- 2010KW07 : Review arthiertyp_2 1
 -- ZUORDNUNG : Artikel_2 (Fehlmengen)

-- 2012KW07 : Einschraenkung mandant_id=1 entfernt
 -- 2011KW50 : Anpassung arthiertyp_2 2

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_wg_zu_2 (mandant_id, arthiertyp_id, art_id, wug_id, wg_id,
dat_von, dat_bis) AS SELECT mandant_id,
 arthiertyp_id,
 art_id,
 wug_id,
 wg_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_art_wg_zu_per_2 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';