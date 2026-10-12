CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_l_antwort_1 (antwort_id, umfrage_id, kmr_quelle_id,
kmr_quelle_umf_id, frage_id, scale_id, antwort_gewichtung, datzeit_aend, ok_fg, kat_id, gesamt_fg, sec_kz) AS SELECT V01
 .antwort_id,
 V01.umfrage_id,
 2 AS kmr_quelle_id,
 ROUND(CAST(LTRIM('2') || LTRIM(CAST(V01.umfrage_id AS STRING)) AS BIGNUMERIC), 0) AS kmr_quelle_umf_id,
 V01.frage_id,
 V01.scale_id,
 V01.antwort_gewichtung,
 V01.datzeit_aend,
 V02.ok_fg,
 V03.kat_id,
 V03.gesamt_fg,
 1 AS sec_kz
FROM kfl_production_dbp_view.v_mcx_l_antwort_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mcx_l_antwort_ok_fg_1 AS V02 ON V01.antwort_id = V02.antwort_id AND V01.umfrage_id =
   V02.umfrage_id
 INNER JOIN kfl_production_dbp_view.v_mcx_antwort_kategorie_zu_1 AS V03 ON V01.antwort_id = V03.antwort_id AND V01.umfrage_id
    = V03.umfrage_id;