CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LADUNGSTRAEGER_PREIS_FAKTOR
(
mandant_id
,art_id
,vk_brutto
)
AS

   SELECT
   v01.mandant_id, v01.art_id, MAX(vk_brutto) AS vk_brutto
   FROM dbp_view.v_art_pm_vw_zu_per v01


   WHERE  v01.dat_bis = '9999-12-31'
   AND  (v01.art_id / 100  IN (9840018,9840133,9840042,9840059,9802554)  )

   AND (
   (v01.mandant_id  = 1 AND preistyp_id = 0 AND pm_id IN (1,10) AND v01.vw_id IN (1,2,3)) OR
   (v01.mandant_id <> 1 AND preistyp_id = 0 AND pm_id IN (1,10) AND v01.vw_id IN (10,90))
   )
   GROUP BY 1,2;