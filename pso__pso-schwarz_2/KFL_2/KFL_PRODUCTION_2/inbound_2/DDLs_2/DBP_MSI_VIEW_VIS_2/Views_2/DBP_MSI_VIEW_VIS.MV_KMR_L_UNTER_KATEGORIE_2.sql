CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_L_UNTER_KATEGORIE_2
-- 20180628 twie: SPEC0038139 Neuanlage Lookup übergreifende Unterkategorie in KMR
--                           Unterkategorie wird in DWH generiert, existiert nicht im Quellsystem
-- 20180926 twie: SPEC0043226
-- 20181018 twie: Quelle wird pro Unterkategorie benötigt. Da das Datenmodell geändert werden muss, wird übergangsweise die Quelle über die Frage ermittelt.
-- 20181026 AP0034666 - KMR added uk_sw

(
kmr_unter_kategorie_id
,kmr_kategorie_id
,kmr_teilbereich_uk_id
,uk_sw
,kmr_quelle_id

)
AS
   SELECT

   v01.kmr_unter_kategorie_id, v01.kmr_kategorie_id, v01.kmr_teilbereich_uk_id, v01.uk_sw, MIN(v02.kmr_quelle_id) --bei mehreren wird die niedrigste genommen, keine endgültige Lösung


   FROM dbp_view.v_kmr_l_unter_kategorie_2 v01

   JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_2 v02
   ON  v01.kmr_unter_kategorie_id = v02.kmr_unter_kategorie_id

   GROUP BY 1,2,3,4;