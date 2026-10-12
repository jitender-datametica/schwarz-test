CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_l_kategorie_2 (kmr_kategorie_id, kmr_bereich_id,
kmr_cockpit_fg, kat_sw) AS SELECT kmr_kategorie_id,
 kmr_bereich_id,
 kmr_cockpit_fg,
 kat_sw
FROM kfl_production_dbp_view.v_kmr_l_kategorie_2;