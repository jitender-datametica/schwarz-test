CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_BESCH_BEST_MATERIALTYP_2
-- AL 22.10.2011 ersetzen nicht mehr gueltige Tabellen Join zu der Tabelle flw_prod-hier_denorm
-- 11.05.2012 twie: materialtyp_id  in ORDER BY aufgenommen, da die Anweisung sonst nicht deterministisch ist
--  falls es mehrere Materialypyen mit der gleichen anz gibt, wird der hoechste genommen.
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 12.12.2012 twie: Filterung auf ekorg_id 5000 und 5013 da Filterung in EKKO_2 beim Beladen entfaellt
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014
(
mandant_id
,best_beleg_id
,materialtyp_id

)
AS
   SELECT
   mandant_id, best_beleg_id, materialtyp_id
   FROM
   (SELECT
   v010.mandant_id, v010.best_beleg_id, CASE WHEN  v012.hauptgruppe_id ='HAWA' THEN 1
   WHEN  v012.hauptgruppe_id ='HISTO' THEN 2
   ELSE 3
   END materialtyp_id, COUNT(*) anz

   FROM dbp_view.v_flw_besch_best_det_2 v010
   INNER JOIN dbp_view.v_flw_art_2 v011
   ON v010.mandant_id = v011.mandant_id
   AND v010.flw_art_id = v011.flw_art_id
   INNER JOIN dbp_view.v_flw_produktgruppe_2 v012
   ON  v011.produktgruppe_id   =  v012.produktgruppe_id
   AND v011.mandant_id =  v012.mandant_id
   INNER JOIN dbp_view.v_flw_besch_best_2 v013
   ON v010.best_beleg_id = v013.best_beleg_id
   AND v010.mandant_id = v013.mandant_id


   WHERE v010.mandant_id IN (1,2)
   AND v013.einkaufsorganisation_id IN (5000,5013,5014)

   GROUP BY v010.mandant_id, v010.best_beleg_id, materialtyp_id
   )  v01

   QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id,best_beleg_id ORDER BY anz DESC NULLS LAST, materialtyp_id DESC NULLS LAST) = 1;