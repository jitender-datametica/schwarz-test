CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_beschw_antw AS SELECT beschwerde_antwort_id,
 geku_massnahme_uid,
 berechtigt_fg,
 avg_fg
FROM kfl_production_dbp_view.v_geku_beschw_antw;