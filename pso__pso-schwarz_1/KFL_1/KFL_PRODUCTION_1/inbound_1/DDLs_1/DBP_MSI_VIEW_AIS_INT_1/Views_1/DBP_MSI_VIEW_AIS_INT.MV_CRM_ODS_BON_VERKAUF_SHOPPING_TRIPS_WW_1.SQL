CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_CRM_ODS_BON_VERKAUF_SHOPPING_TRIPS_WW_1
(
 ANZ_SHOPPING_TRIPS_LOYALTY
,ANZ_SHOPPING_TRIPS_NICHT_LOYALTY
,ART_ID
,WG_ID
,MANDANT_ID
,BON_ID
,BON_DAT
,KJWO_WW
)
AS
SELECT
-- COUNT (DISTINCT v05.art_id) OVER (PARTITION BY v01.mandant_id, v01.bon_id, v05.art_id, v04.kjwo_ww)  AS anz_shopping_trips
CASE WHEN v01.kundenkarte_id IS NOT NULL AND v01.kundenkarte_typ_id = 2 THEN v01.bon_id END AS anz_shopping_trips_loyalty
,CASE WHEN v01.kundenkarte_id IS NULL AND v01.kundenkarte_typ_id = 0 THEN v01.bon_id END AS anz_shopping_trips_nicht_loyalty
,v05.art_id
,v02.wg_id
,v01.mandant_id
,v01.bon_id 
,v01.bon_dat
,v04.kjwo_ww
FROM dbp_v_ods.v_ods_bon_kopf_1 v01

JOIN dbp_v_ods.v_ods_bon_verkauf_1 v02
ON  v01.mandant_id = v02.mandant_id 
AND v01.bon_dat = v02.bon_dat 
AND v01.bon_id = v02.bon_id 
AND v01.wup_id = v02.wup_id

LEFT JOIN dbp_data.bewart_det_ecommerce_1 v03
ON  v01.mandant_id = v03.mandant_id 
AND v01.kundenkarte_id = v03.kundenkarte_id

LEFT OUTER JOIN dbp_view.v_werbewoche_kl_1 v04
ON  v01.bon_dat = v04.dat 
AND v01.mandant_id = v04.mandant_id

JOIN dbp_view.v_art_1 v05
ON  v02.kl_art_id = v05.kl_art_id
AND v02.mandant_id = v05.mandant_id

WHERE v01.turnover_fg = 1 
AND v01.kasse_typ_id <>5 AND v01.umsatz_brutto > 0
AND  ((v01.mandant_id IN (1,4,6)) OR (v01.mandant_id IN (2,5,7,8) 
AND v01.kassierer_nr NOT BETWEEN 800 AND 900) OR (v01.mandant_id = 3 AND (v01.kassierer_nr NOT BETWEEN 700 AND 900)))
AND v03.kundenkarte_id IS NULL
AND (v02.mandant_id,v02.bon_dat,v02.bon_id, v02.bon_zeile) 
NOT IN 
(SELECT mandant_id, bon_dat, bon_id, bon_zeile FROM dbp_ods.ods_bon_retoure_1)
AND akt_kjwo_ww BETWEEN -52 AND 0
AND v01.kunde_fg = 1 AND v01.suspended_fg = 0
--AP0242994/SPEC0276113 Filtern von wg_id = 961 / sschuecke 18.10.2024
AND v02.wg_id <> 961
GROUP BY
 -- NEU für COI Report Anzahl transaktionen Loyalty bzw Anzahl Transaktionen Nicht Loyalty
 v01.kundenkarte_id
,v01.kundenkarte_typ_id
,v05.art_id
,v02.wg_id
,v01.mandant_id
,v01.bon_id
,v01.bon_dat
,v04.kjwo_ww
;