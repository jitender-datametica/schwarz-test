-- 16.08.2022 twie: SPEC0145413 kl_art_id aufnehmen
 -- 10.05.2022 twie: SPEC0145413 Lookup Artikel_2

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_l_art_2 (art_id, mandant_id, kl_art_id) AS SELECT
 art_id,
 mandant_id,
 kl_art_id
FROM kfl_production_dbp_view.v_art_2;