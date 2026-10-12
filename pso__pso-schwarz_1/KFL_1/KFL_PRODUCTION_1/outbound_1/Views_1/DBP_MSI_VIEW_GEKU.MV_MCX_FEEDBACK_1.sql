CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_feedback_1 (feedback_id, umfrage_id, befragter_id, scale_id
, antwort_id, kmr_quelle_id, datzeit_abschluss, dat_feedback, abschluss_id, mandant_id, wup_id, nb_id, dat,
zeitspanne_id, zeitspanne, bonwertspanne, ok_fg) AS SELECT V01.feedback_id,
 V01.umfrage_id,
 V01.befragter_id,
 V01.scale_id,
 V01.antwort_id,
 2 AS kmr_quelle_id,
 V01.datzeit_abschluss,
 V01.dat_feedback,
 V01.abschluss_id,
 V01.mandant_id,
 V04.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.dat,
 V01.zeitspanne_id,
 V01.zeitspanne,
 V01.bonwertspanne,
 V02.ok_fg
FROM kfl_production_dbp_view.v_mcx_feedback_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mcx_l_antwort_ok_fg_1 AS V02 ON V01.antwort_id = V02.antwort_id AND V01.umfrage_id =
   V02.umfrage_id
 INNER JOIN kfl_production_dbp_view.v_mcx_antwort_kategorie_zu_1 AS V03 ON V01.antwort_id = V03.antwort_id AND V01.umfrage_id
     = V03.umfrage_id AND V03.kat_id <> - 1
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V04 ON V01.wup_id = V04.wup_id AND V01.mandant_id = V04.mandant_id;