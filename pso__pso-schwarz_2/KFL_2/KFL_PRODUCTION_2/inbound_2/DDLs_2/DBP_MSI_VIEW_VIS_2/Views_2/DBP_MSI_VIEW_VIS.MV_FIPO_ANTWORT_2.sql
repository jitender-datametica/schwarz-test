CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_ANTWORT_2 as

   SELECT
   v01.fipo_antwort_id, v01.fipo_bericht_id, v01.fipo_pruefpunkt_id, 4 AS kmr_quelle_id, v02.fipo_pruefpunkt_nr, v01.fipo_antwort_bwz, v01.fipo_antwort_text, CASE WHEN v02.fipo_pruefpunkt_typ = 'NUMERISCH_OHNE_DEZIMALSTELLEN' OR  v02.fipo_pruefpunkt_typ = 'OK_NOTOK_MIT_GANZZAHL' THEN CAST(v01.fipo_antwort_num AS BIGINT) END AS fipo_antwort_num, CASE WHEN v02.fipo_pruefpunkt_typ = 'NUMERISCH_MIT_DEZIMALSTELLEN' THEN v01.fipo_antwort_num END AS fipo_antwort_num_nk, v02.fipo_bereich_id, v02.fipo_kriterium_id

   FROM dbp_view.v_fipo_antwort_2 v01
   INNER JOIN dbp_view.v_fipo_pruefpunkt_2 v02
   ON v01.fipo_pruefpunkt_id = v02.fipo_pruefpunkt_id
   ;