CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_U_GEWERK_SUMME_SPR_ZU_1 as
   -- 180613 nfis0811 - Internationalisierung - Einführung spr_zu

   SELECT DISTINCT
   --v01.bvv_leist_id  --AS bvv_u_gewerk_summe_sort
   /*, bvv_gewerk_bez*/
   CASE WHEN v01.bvv_leist_id BETWEEN 7 AND 17 THEN 1
   WHEN v01.bvv_leist_id BETWEEN 18 AND 85 THEN 2
   WHEN v01.bvv_leist_id BETWEEN 87 AND 123 THEN 3
   WHEN v01.bvv_leist_id BETWEEN 125 AND 158 THEN 4
   WHEN v01.bvv_leist_id = 5 THEN 5
   WHEN v01.bvv_leist_id BETWEEN 1 AND 3 THEN 6
   WHEN v01.bvv_leist_id BETWEEN 159 AND 162 THEN 7
   WHEN v01.bvv_leist_id BETWEEN 163 AND 165 THEN 8
   ELSE v01.bvv_leist_id END bvv_u_gewerk_summe_id, CASE WHEN bvv_u_gewerk_summe_id = 1 THEN 'Infrastruktur'
   WHEN bvv_u_gewerk_summe_id = 2 THEN 'Baukosten/Gebaeude'
   ELSE bvv_gewerk_bez END AS bvv_u_gewerk_summe_bez


   /*, CASE
   WHEN bvv_u_gewerk_bez IN ('Infrastrukturmassnahmen', 'Infrastrukturmaßnahmen', 'Erschliessungsmassnahmen / Anschlusskosten', 'Erschließungsmaßnahmen / Anschlusskosten') THEN 'Infrastruktur'
   WHEN bvv_u_gewerk_bez IN ('Baukosten / Gebaeude') THEN 'Baukosten/Gebaeude'
   ELSE bvv_gewerk_bez
   END AS bvv_u_gewerk_summe_bez

   -- temporaer
   , MAX(CASE
   WHEN bvv_u_gewerk_summe_bez = 'Infrastruktur'                                                 THEN 1
   WHEN bvv_u_gewerk_summe_bez = 'Baukosten/Gebaeude'                               THEN 2
   WHEN bvv_u_gewerk_summe_bez = 'Baunebenkosten'                                        THEN 3
   WHEN bvv_u_gewerk_summe_bez = 'Einrichtung Ladenbau'                                THEN 4
   WHEN bvv_u_gewerk_summe_bez = 'Erwerbskosten Grundstueck/Gebaeude'  THEN 5
   WHEN bvv_u_gewerk_summe_bez = 'Entwicklungs-/Beratungskosten'                THEN 6
   END) AS sort_kostenuebersicht*/

   FROM
   dbp_view.v_l_bvv_leistung_1 v01
   JOIN dbp_view.v_bvv_leistung_spr_zu_1 v02
   ON v01.bvv_leist_id = v02.bvv_leist_id
   WHERE spr_id = 22
   --GROUP BY 1;;
   ;