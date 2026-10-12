-- 10.05.2022 twie: SPEC0145413 Lookup Artikel_1
 -- 16.08.2022 twie: SPEC0145413 kl_art_id aufnehmen

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_l_art_1 (art_id, mandant_id, kl_art_id) AS SELECT
 art_id,
 mandant_id,
 kl_art_id
FROM dbp_view.v_art_1;