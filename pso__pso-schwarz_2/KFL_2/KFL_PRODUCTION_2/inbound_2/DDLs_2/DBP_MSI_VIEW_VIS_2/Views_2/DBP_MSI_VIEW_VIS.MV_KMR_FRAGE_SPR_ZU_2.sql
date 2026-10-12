CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_FRAGE_SPR_ZU_2
-- 20180528 twie: SPEC0038139 Neuanlage Sprachview übergreifende Frage in KMR
-- 20180625 ttod     wird aus Fragen der 4 Quellsysteme zusammengesetzt. Durch die kmr_quelle_id als Schlüsselfeld keine Überschneidung der ID
-- 20190409 twie: SPEC0053317: umfrage_id im Schlüssel bei Maritz

(
kmr_frage_id
,kmr_quelle_id
,kmr_frage_bez
,kmr_frage_bez_cz
,kmr_frage_bez_pl
,kmr_frage_bez_sk
,kmr_frage_bez_hr
,kmr_frage_bez_ro
,kmr_frage_bez_bg
)
AS

   --Audimex (Quelle 1) keine Übersetzung, dt. Bez. für alle Sprachen ausgeben
   SELECT
   v02.kmr_agm_id AS kmr_frage_id, v02.kmr_quelle_id, v01.amx_frage_bez AS kmr_frage_bez   --standard=deutsch
   , v01.amx_frage_bez AS kmr_frage_bez_cz, v01.amx_frage_bez AS kmr_frage_bez_pl, v01.amx_frage_bez AS kmr_frage_bez_sk, v01.amx_frage_bez AS kmr_frage_bez_hr, v01.amx_frage_bez AS kmr_frage_bez_ro, v01.amx_frage_bez AS kmr_frage_bez_bg
   FROM dbp_view.v_amx_frage_katalog_2 v01
   INNER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_2 v02
   ON  v01.amx_frage_katalog_id = v02.kmr_agm_id
   AND v02.kmr_quelle_id = 1


   UNION ALL

   --Maritz (Quelle 2) wenn gesamt_fg für die Antwort 0 ist, die Bez. der Antwort ausgeben, bei gesamt_fg =1 die Bez. der Frage
   SELECT
   v04.kmr_agm_id AS kmr_frage_id, v04.kmr_quelle_id, MAX(CASE WHEN  v06.gesamt_fg = 1 THEN (CASE WHEN v07.spr_id =     22 THEN v07.frage_bez ELSE NULL END) ELSE (CASE WHEN v03.spr_id =     22 THEN v03.antwort_bez ELSE NULL END) END ) AS kmr_frage_bez, MAX(CASE WHEN  v06.gesamt_fg = 1 THEN (CASE WHEN v07.spr_id =   124 THEN v07.frage_bez ELSE NULL END) ELSE (CASE WHEN v03.spr_id =   124 THEN v03.antwort_bez ELSE NULL END) END ) AS kmr_frage_bez_cz, MAX(CASE WHEN  v06.gesamt_fg = 1 THEN (CASE WHEN v07.spr_id =     90 THEN v07.frage_bez ELSE NULL END) ELSE (CASE WHEN v03.spr_id =     90 THEN v03.antwort_bez ELSE NULL END) END ) AS kmr_frage_bez_pl, MAX(CASE WHEN  v06.gesamt_fg = 1 THEN (CASE WHEN v07.spr_id =   108 THEN v07.frage_bez ELSE NULL END) ELSE (CASE WHEN v03.spr_id =   108 THEN v03.antwort_bez ELSE NULL END) END ) AS kmr_frage_bez_sk, MAX(CASE WHEN  v06.gesamt_fg = 1 THEN (CASE WHEN v07.spr_id =     65 THEN v07.frage_bez ELSE NULL END) ELSE (CASE WHEN v03.spr_id =     65 THEN v03.antwort_bez ELSE NULL END) END ) AS kmr_frage_bez_hr, MAX(CASE WHEN  v06.gesamt_fg = 1 THEN (CASE WHEN v07.spr_id =     95 THEN v07.frage_bez ELSE NULL END) ELSE (CASE WHEN v03.spr_id =     95 THEN v03.antwort_bez ELSE NULL END) END ) AS kmr_frage_bez_ro, MAX(CASE WHEN  v06.gesamt_fg = 1 THEN (CASE WHEN v07.spr_id =     18 THEN v07.frage_bez ELSE NULL END) ELSE (CASE WHEN v03.spr_id =     18 THEN v03.antwort_bez ELSE NULL END) END ) AS kmr_frage_bez_bg
   FROM dbp_view.v_mcx_antwort_spr_zu_2 v03
   INNER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_2 v04
   ON  v03.antwort_id = v04.kmr_agm_id
   AND v03.umfrage_id = v04.umfrage_id
   AND v04.kmr_quelle_id = 2
   INNER JOIN dbp_view.v_mcx_l_antwort_2 v05
   ON v03.antwort_id = v05.antwort_id
   AND v03.umfrage_id = v05.umfrage_id
   INNER JOIN dbp_view.v_mcx_antwort_kategorie_zu_2 v06
   ON v05.antwort_id = v06.antwort_id
   AND v05.umfrage_id = v06.umfrage_id
   INNER JOIN dbp_view.v_mcx_frage_spr_zu_2 v07
   ON v05.frage_id = v07.frage_id
   AND v05.umfrage_id = v07.umfrage_id
   GROUP BY 1,2


   UNION ALL

   --Geku Portal (Quelle 3)
   SELECT
   v06.kmr_agm_id AS kmr_frage_id, v06.kmr_quelle_id, MAX(CASE WHEN v05.spr_id =   22 THEN v05.geku_dwh_artikel_bez ELSE NULL END)  AS kmr_frage_bez   --standard=deutsch
   , MAX(CASE WHEN v05.spr_id = 124 THEN v05.geku_dwh_artikel_bez ELSE NULL END)  AS kmr_frage_bez_cz, MAX(CASE WHEN v05.spr_id =   90 THEN v05.geku_dwh_artikel_bez ELSE NULL END)  AS kmr_frage_bez_pl, MAX(CASE WHEN v05.spr_id = 108 THEN v05.geku_dwh_artikel_bez ELSE NULL END)  AS kmr_frage_bez_sk, MAX(CASE WHEN v05.spr_id =   65 THEN v05.geku_dwh_artikel_bez ELSE NULL END)  AS kmr_frage_bez_hr, MAX(CASE WHEN v05.spr_id =   95 THEN v05.geku_dwh_artikel_bez ELSE NULL END)  AS kmr_frage_bez_ro, MAX(CASE WHEN v05.spr_id =   18 THEN v05.geku_dwh_artikel_bez ELSE NULL END)  AS kmr_frage_bez_bg
   FROM dbp_view.v_geku_dwh_artikel_spr_zu_2 v05
   INNER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_2 v06
   ON  v05.geku_dwh_artikel_id = v06.kmr_agm_id
   AND v06.kmr_quelle_id = 3
   --Filterung auf relevante Elemente laut Sprachview DWH Artikel_2
   WHERE v05.geku_dwh_artikel_id IN
   (SELECT geku_dwh_artikel_id FROM dbp_view.v_l_geku_artikel_2)
   GROUP BY 1,2


   UNION ALL

   --K-VISIT (Quelle 4) wenn keine Übersetzung vorhanden ist, die dt. Bez. ausgeben
   SELECT
   v08.kmr_agm_id AS kmr_frage_id, v08.kmr_quelle_id, MAX(CASE WHEN spr_id =   22 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)    AS kmr_frage_bez   --standard=deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN v07.fipo_pruefpunkt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   END  AS kmr_frage_bez_cz, CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN v07.fipo_pruefpunkt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   END  AS kmr_frage_bez_pl, CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN v07.fipo_pruefpunkt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   END  AS kmr_frage_bez_sk, CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN v07.fipo_pruefpunkt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   END  AS kmr_frage_bez_hr, CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN v07.fipo_pruefpunkt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   END  AS kmr_frage_bez_ro, CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN v07.fipo_pruefpunkt_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v07.fipo_pruefpunkt_bez ELSE NULL END)
   END  AS kmr_frage_bez_bg
   FROM dbp_view.v_fipo_pruefpunkt_spr_zu_2 v07
   INNER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_2 v08
   ON  v07.fipo_pruefpunkt_id = v08.kmr_agm_id
   AND v08.kmr_quelle_id = 4
   GROUP BY 1,2
   ;