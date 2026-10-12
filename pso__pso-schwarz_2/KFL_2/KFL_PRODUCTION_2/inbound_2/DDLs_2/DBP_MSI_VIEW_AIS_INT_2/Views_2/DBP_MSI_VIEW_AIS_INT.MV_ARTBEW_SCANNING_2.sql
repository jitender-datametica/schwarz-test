CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTBEW_SCANNING_2
(
 wup_id
,mandant_id
,bewart_id
,gp_id
,nb_id
,art_id
,dat
,aktion_id
,promo_fg
,ean_id
,vorgang_scanned
,vorgang_keyed
,vorgang_scanned_einzeln
,vorgang_keyed_einzeln
,anzahl_bon
,anzahl_registriert
)
AS
   SELECT
    wup_id
   ,mandant_id
   ,bewart_id
   ,gp_id
   ,nb_id
   ,art_id
   ,dat
   ,aktion_id
   ,promo_fg
   ,gtin_kasse AS ean_id
   ,vorgang_scanned
   ,vorgang_keyed
   ,vorgang_scanned_einzeln
   ,vorgang_keyed_einzeln
   ,anzahl_bon
   ,anzahl_registriert

   FROM DBP_DATA.ARTBEW_SCANNING_2
   --AP0190987/SPEC0225041 Filter E-Loading Artikel_2 / sschuecke 17.11.2023
   WHERE NOT (mandant_id = 5 AND art_id = 206731500)
      --AP0227085/SPEC0284781 Filter E-Loading Artikel_2 / sschuecke 25.02.2025
   AND NOT (mandant_id = 2 AND art_id = 208124500)
   AND NOT (mandant_id = 3 AND art_id = 208113690)
   AND NOT (mandant_id = 6 AND art_id = 208131570)
   AND NOT (mandant_id IN (4,7) AND art_id = 208114740)
   AND NOT (mandant_id = 8 AND art_id = 208131640);