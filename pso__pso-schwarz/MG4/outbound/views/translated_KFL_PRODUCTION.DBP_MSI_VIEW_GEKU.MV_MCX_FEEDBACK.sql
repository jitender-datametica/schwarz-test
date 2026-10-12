CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_feedback (feedback_id, umfrage_id, befragter_id, scale_id
, antwort_id, kmr_quelle_id, datzeit_abschluss, dat_feedback, abschluss_id, mandant_id, wup_id, nb_id, dat,
zeitspanne_id, zeitspanne, bonwertspanne, ok_fg) AS SELECT v01.feedback_id,
 v01.umfrage_id,
 v01.befragter_id,
 v01.scale_id,
 v01.antwort_id,
 2 AS kmr_quelle_id,
 v01.datzeit_abschluss,
 v01.dat_feedback,
 v01.abschluss_id,
 v01.mandant_id,
 v04.aktuell_wup_id AS wup_id,
 v01.nb_id,
 v01.dat,
 v01.zeitspanne_id,
 v01.zeitspanne,
 v01.bonwertspanne,
 v02.ok_fg
FROM kfl_production_dbp_view.v_mcx_feedback AS v01
 INNER JOIN kfl_production_dbp_view.v_mcx_l_antwort_ok_fg AS v02 ON v01.antwort_id = v02.antwort_id AND v01.umfrage_id =
   v02.umfrage_id
 INNER JOIN kfl_production_dbp_view.v_mcx_antwort_kategorie_zu AS v03 ON v01.antwort_id = v03.antwort_id AND v01.umfrage_id
     = v03.umfrage_id AND v03.kat_id <> - 1
 INNER JOIN kfl_production_dbp_view.v_wup AS v04 ON v01.wup_id = v04.wup_id AND v01.mandant_id = v04.mandant_id;