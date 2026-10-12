CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_frage_grp (sort_nr) AS SELECT sort_nr
FROM kfl_production_dbp_view.v_kmr_frage
GROUP BY sort_nr;