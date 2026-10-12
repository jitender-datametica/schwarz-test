CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_FEEDBACK_2
AS
-- FAKT : KMR/MCX Feedback/Antwort
-- 20180502 twie: SPEC0037245 Neuanlage Bewegungsdaten Maritz, ohne GF_2, wird über WUP_2 ermittelt, in DE ein Dummy_2 WUP_2 pro GF_2,
-- Frage ist Elternattribut zu Antwort, deshalb FK in mcx_l_antwort_2 benutzen, nicht die frage_id aus dieser Tabelle
-- 20190409 twie: SPEC0053317: umfrage_id im Schlüssel, für VIS aber nur 20 relevant
-- 2019.0805 ssch0611 VTC-KMR Redesign (Umfrage Filter entfern)
-- 20200624 snik1809 Added zeitspanne_id

SELECT
  v01.feedback_id
, v01.umfrage_id
, v01.befragter_id
, v01.scale_id
, v01.antwort_id
, 2 ::BYTEINT AS kmr_quelle_id
, v01.datzeit_abschluss
, v01.dat_feedback
, v01.abschluss_id
, v01.mandant_id
, v01.wup_id
, v01.nb_id
, v01.dat
, v01.zeitspanne
, v01.zeitspanne_id
, v01.bonwertspanne
, v02.ok_fg
FROM dbp_data.mcx_feedback_2 v01

INNER JOIN dbp_data.mcx_l_antwort_ok_fg_2 v02
ON v01.antwort_id = v02.antwort_id AND v01.umfrage_id = v02.umfrage_id
  -- nur Daten mit zugeordneter Kategorie sind relevant
INNER JOIN dbp_data.mcx_antwort_kategorie_zu_2 v03
ON v01.antwort_id = v03.antwort_id AND v01.umfrage_id = v03.umfrage_id
AND v03.kat_id <> -1;