CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_DISPLAY_1
(
  mandant_id
 ,art_id
 ,display_art_id
 ,display_bez
)
AS
   --10.06.2025, SPEC0325089, prescherad, Umbau auf Stücklistentabelle. 
   SELECT 
   v01.mandant_id,
   v01.art_id, 
   v02.art_id AS Art_id_display,
   CASE WHEN v02.art_id IS NULL
   THEN 'kein Displayartikel' 
   ELSE 'Displayartikel'
   END AS display_bez
   FROM dbp_data.art_1 v01
   LEFT JOIN dbp_data.stueckliste_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id=v02.art_id
   ;