CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_L_FRAGE_1
-- 20180528 twie: SPEC0038139 Neuanlage Lookup übergreifende Frage in KMR
--                           wird aus Fragen der 4 Quellsysteme zusammengesetzt
-- 20181026 AP0034666 - KMR added agm_sw
-- 20190409 twie: SPEC0053317: umfrage_id im Schlüssel bei Maritz

(
kmr_frage_id
,kmr_quelle_id
,kmr_unter_kategorie_id
,kmr_teilbereich_frage_id
,agm_sw
)
AS

   --Audimex
   SELECT
   v02.kmr_agm_id AS kmr_frage_id, v02.kmr_quelle_id, v02.kmr_unter_kategorie_id, v02.kmr_teilbereich_frage_id, v02.agm_sw
   FROM dbp_view.v_amx_frage_katalog_1 v01
   INNER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_1 v02
   ON  v01.amx_frage_katalog_id = v02.kmr_agm_id
   AND v02.kmr_quelle_id = 1


   UNION ALL

   --Maritz
   SELECT
   v04.kmr_agm_id AS kmr_frage_id, v04.kmr_quelle_id, v04.kmr_unter_kategorie_id, v04.kmr_teilbereich_frage_id, v04.agm_sw
   FROM dbp_view.v_mcx_l_antwort_1 v03
   INNER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_1 v04
   ON  v03.antwort_id = v04.kmr_agm_id
   AND v03.umfrage_id = v04.umfrage_id
   AND v04.kmr_quelle_id = 2


   UNION ALL

   --Geku Portal
   SELECT
   v06.kmr_agm_id AS kmr_frage_id, v06.kmr_quelle_id, v06.kmr_unter_kategorie_id, v06.kmr_teilbereich_frage_id, v06.agm_sw
   FROM dbp_view.v_l_geku_dwh_artikel_1 v05
   INNER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_1 v06
   ON  v05.geku_dwh_artikel_id = v06.kmr_agm_id
   AND v06.kmr_quelle_id = 3
   --Filterung auf relevante Elemente laut Lookupview DWH Artikel_1
   WHERE geku_dwh_artikel_id IN
   (SELECT geku_dwh_artikel_id FROM dbp_view.v_l_geku_artikel_1)


   UNION ALL

   --K-VISIT
   SELECT
   v08.kmr_agm_id AS kmr_frage_id, v08.kmr_quelle_id, v08.kmr_unter_kategorie_id, v08.kmr_teilbereich_frage_id, v08.agm_sw
   FROM dbp_view.v_fipo_pruefpunkt_1 v07
   INNER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_1 v08
   ON  v07.fipo_pruefpunkt_id = v08.kmr_agm_id
   AND v08.kmr_quelle_id = 4;