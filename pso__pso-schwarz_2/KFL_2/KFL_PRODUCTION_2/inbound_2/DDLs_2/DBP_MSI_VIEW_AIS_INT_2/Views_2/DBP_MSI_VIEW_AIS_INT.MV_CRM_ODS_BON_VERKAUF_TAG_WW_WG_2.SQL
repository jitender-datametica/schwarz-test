CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_CRM_ODS_BON_VERKAUF_TAG_WW_WG_2
(
 ANZ_SHOPPING_TRIPS_KDN_WG
,WG_ID
,MANDANT_ID
,BON_DAT
,KJWO_WW
)
AS
SELECT SUM (anz_shopping_trips_kdn_wg) AS anz_shopping_trips_kdn_wg
,v99.wg_id
,v99.mandant_id
,v99.bon_dat
,v99.kjwo_ww
FROM (
SELECT 
 COUNT (DISTINCT v01.wg_id) OVER (PARTITION BY v01.mandant_id, v01.bon_id, v01.wg_id, v01.bon_dat) AS anz_shopping_trips_kdn_wg
,v01.wg_id
,v01.mandant_id
,v01.bon_dat
,v09.kjwo_ww
FROM dbp_v_ods.v_ods_bon_verkauf_2 v01

JOIN dbp_v_ods.v_ods_bon_kopf_2 v02
ON  v01.mandant_id = v02.mandant_id
AND v01.bon_id = v02.bon_id
AND v01.bon_dat = v02.bon_dat
AND v01.wup_id = v02.wup_id
AND v02.kundenkarte_id IS NOT NULL
-- kundenkarte_typ_id = 1 entfällt wegen Wegfall Payback PL
AND v02.kundenkarte_typ_id IN (2)

LEFT JOIN dbp_view.v_bewart_det_ecommerce_2 v03
ON  v02.mandant_id = v03.mandant_id
AND v02.kundenkarte_id = v03.kundenkarte_id
AND v03.kundenkarte_id IS NULL

JOIN dbp_v_ods.v_ods_promotion_2 v04
ON  v01.mandant_id = v04.mandant_id
AND v01.bon_id = v04.bon_id
AND v01.bon_dat = v04.bon_dat
AND v01.kl_art_id = v04.kl_art_id
AND v04.promotion_art = 'CUSTOMER'
AND v04.customer_promotion_fg =1

JOIN dbp_view.v_art_2 v05
ON  v01.kl_art_id = v05.kl_art_id
AND v01.mandant_id = v05.mandant_id

JOIN dbp_view.v_crm_l_kundenkarte_2  v07
ON  v02.kundenkarte_id = v07.kundenkarte_id
AND v02.mandant_id= v07.mandant_id

LEFT OUTER JOIN dbp_view.v_werbewoche_kl_2 v09
ON  v01.bon_dat = v09.dat 
AND v01.mandant_id = v09.mandant_id

WHERE v02.turnover_fg = 1 
AND v02.kasse_typ_id <>5 AND v02.umsatz_brutto > 0
AND  ((v01.mandant_id IN (1,4,6)) OR (v01.mandant_id IN (2,5,7,8) 
AND v02.kassierer_nr NOT BETWEEN 800 AND 900) OR (v01.mandant_id = 3 AND (v02.kassierer_nr NOT BETWEEN 700 AND 900)))
AND (v02.mandant_id,v01.bon_dat,v01.bon_id, v01.bon_zeile) 
NOT IN 
(SELECT mandant_id, bon_dat, bon_id, bon_zeile FROM dbp_ods.ods_bon_retoure_2)
AND akt_kjwo_ww BETWEEN -156 AND 0
--AP0242994/SPEC0276113 Filtern von wg_id = 961 / sschuecke 18.10.2024
AND v01.wg_id <> 961

GROUP BY
 v01.wg_id
,v01.mandant_id
,v01.bon_id
,v01.bon_dat
,v09.kjwo_ww) v99
GROUP BY v99.wg_id
,v99.mandant_id
,v99.bon_dat
,v99.kjwo_ww;