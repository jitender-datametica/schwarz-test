CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_feedback AS SELECT V01.feedback_id,
 V01.umfrage_id,
 V01.befragter_id,
 V01.scale_id,
 V01.antwort_id,
 2 AS kmr_quelle_id,
 V01.datzeit_abschluss,
 V01.dat_feedback,
 V01.abschluss_id,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat,
 V01.zeitspanne,
 V01.zeitspanne_id,
 V01.bonwertspanne,
 V02.ok_fg
FROM kfl_production_dbp_data.mcx_feedback AS V01
 INNER JOIN kfl_production_dbp_data.mcx_l_antwort_ok_fg AS V02 ON V01.antwort_id = V02.antwort_id AND V01.umfrage_id =
   V02.umfrage_id
 INNER JOIN kfl_production_dbp_data.mcx_antwort_kategorie_zu AS V03 ON V01.antwort_id = V03.antwort_id AND V01.umfrage_id
     = V03.umfrage_id AND V03.kat_id <> - 1;