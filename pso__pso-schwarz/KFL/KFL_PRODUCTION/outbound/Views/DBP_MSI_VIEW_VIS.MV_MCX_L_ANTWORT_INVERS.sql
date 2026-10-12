CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_l_antwort_invers AS SELECT V01.antwort_id,
 V01.umfrage_id,
 2 AS kmr_quelle_id,
 V01.frage_id,
 V01.scale_id,
 V01.antwort_gewichtung,
 V01.datzeit_aend,
 V02.ok_fg,
 V03.invers_ber_id
FROM kfl_production_dbp_view.v_mcx_l_antwort AS V01
 INNER JOIN kfl_production_dbp_view.v_mcx_l_antwort_ok_fg AS V02 ON V01.antwort_id = V02.antwort_id AND V01.umfrage_id =
   V02.umfrage_id
 INNER JOIN kfl_production_dbp_view.v_mcx_invers_antwort_bereich_zu AS V03 ON V01.antwort_id = V03.antwort_id AND V01.umfrage_id
    = V03.umfrage_id;