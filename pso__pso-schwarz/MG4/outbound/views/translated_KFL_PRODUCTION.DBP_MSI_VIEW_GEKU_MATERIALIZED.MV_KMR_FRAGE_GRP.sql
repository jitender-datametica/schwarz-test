-- 20230831 twie: NSR3932851 neue audimex View für Frage gruppiert auf sort_nr. Dient als Elternattribut von KMR Frage

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_frage_grp (sort_nr) AS SELECT sort_nr
FROM kfl_production_dbp_view.v_kmr_frage
GROUP BY sort_nr;