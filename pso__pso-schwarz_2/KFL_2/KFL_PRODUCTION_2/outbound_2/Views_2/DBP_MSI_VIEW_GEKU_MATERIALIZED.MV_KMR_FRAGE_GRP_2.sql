CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_kmr_frage_grp_2 (sort_nr) AS SELECT sort_nr
FROM kfl_production_dbp_view.v_kmr_frage_2
GROUP BY sort_nr;