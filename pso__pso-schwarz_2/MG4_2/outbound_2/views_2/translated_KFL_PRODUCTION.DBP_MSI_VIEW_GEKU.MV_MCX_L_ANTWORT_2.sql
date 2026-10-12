-- 20180502 twie: SPEC0037245 Neuanlage Lookup Antwort in Maritz

-- 20180529 twie: SPEC0038139 PK um kmr_quelle_id ergänzt für Zusammenführung Hierarchie

-- 20221012 twie: SPEC0167837 sek_kz von 51 auf 1 geändert

-- 20190404 twie: SPEC0053317 Umfrage im Schlüssel für Maritz; für Verbindung in KMR Hiearchie die Quelle erweitern um die Umfrage, damit kein neues Schlüsselfeld nötig ist (andere Quellen haben keine umfrage_id)

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_l_antwort_2 (antwort_id, umfrage_id, kmr_quelle_id,
kmr_quelle_umf_id, frage_id, scale_id, antwort_gewichtung, datzeit_aend, ok_fg, kat_id, gesamt_fg, sec_kz) AS
-- für KMR Hierarchie Feld zusammensetzen aus kmr_quelle_id und umfrage_id (bspw. Quelle 2 und Umfrage 20 ergibt 220)

SELECT v01.antwort_id,
 v01.umfrage_id,
 2 AS kmr_quelle_id,
 ROUND(CAST(LTRIM('2') || LTRIM(CAST(v01.umfrage_id AS STRING)) AS BIGNUMERIC), 0) AS kmr_quelle_umf_id,
 v01.frage_id,
 v01.scale_id,
 v01.antwort_gewichtung,
 v01.datzeit_aend,
 v02.ok_fg,
 v03.kat_id,
 v03.gesamt_fg,
 1 AS sec_kz
FROM kfl_production_dbp_view.v_mcx_l_antwort_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_mcx_l_antwort_ok_fg_2 AS v02 ON v01.antwort_id = v02.antwort_id AND v01.umfrage_id =
   v02.umfrage_id
 INNER JOIN kfl_production_dbp_view.v_mcx_antwort_kategorie_zu_2 AS v03 ON v01.antwort_id = v03.antwort_id AND v01.umfrage_id
    = v03.umfrage_id;