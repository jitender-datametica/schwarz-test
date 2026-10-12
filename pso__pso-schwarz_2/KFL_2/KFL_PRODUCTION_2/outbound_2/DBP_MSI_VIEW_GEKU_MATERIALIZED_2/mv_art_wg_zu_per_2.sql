-- 22.06.2022 twie: SPEC0145413 Verbindung Artikel_2 - Warengruppe

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_art_wg_zu_per_2 (art_id, mandant_id, arthiertyp_id
, wug_id, wg_id, dat_von, dat_bis) AS SELECT art_id,
 mandant_id,
 arthiertyp_id,
 wug_id,
 wg_id,
 dat_von,
 dat_bis
FROM dbp_view.v_art_wg_zu_per_2 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';