CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_CRM_ODS_BON_VERKAUF_OHNE_PROMO_TAG_WW_1(
	ANZ_AKTIVE_LOYALTY_KUNDEN_DIGITAL,
	ANZ_AKTIVE_LOYALTY_KUNDEN_PHYSISCH,
	CRM_KONTO_ID,
	ART_ID,
	WG_ID,
	MANDANT_ID,
	BON_DAT,
	KJWO_WW
) AS
SELECT 
CASE WHEN v08.crm_konto_typ_id = 1 THEN v08.crm_konto_id END AS anz_aktive_loyalty_kunden_digital
,CASE WHEN v08.crm_konto_typ_id = 2 THEN v08.crm_konto_id END AS anz_aktive_loyalty_kunden_physisch
,v08.crm_konto_id 
,v05.art_id
,v01.wg_id
,v01.mandant_id
,v01.bon_dat
,v09.kjwo_ww
FROM dbp_v_ods.v_ods_bon_verkauf_1 v01
JOIN dbp_v_ods.v_ods_bon_kopf_1 v02
ON  v01.mandant_id = v02.mandant_id
AND v01.bon_id = v02.bon_id
AND v01.bon_dat = v02.bon_dat
AND v01.wup_id = v02.wup_id
AND v02.kundenkarte_id IS NOT NULL
-- kundenkarte_typ_id = 1 entfällt wegen Wegfall Payback PL
AND v02.kundenkarte_typ_id = 2
LEFT JOIN dbp_view.v_bewart_det_ecommerce_1 v03
ON  v02.mandant_id = v03.mandant_id
AND v02.kundenkarte_id = v03.kundenkarte_id
AND v03.kundenkarte_id IS NULL
JOIN dbp_view.v_art_1 v05
ON  v01.kl_art_id = v05.kl_art_id
AND v01.mandant_id = v05.mandant_id
JOIN dbp_view.v_crm_l_kundenkarte_1  v07
ON  v02.kundenkarte_id = v07.kundenkarte_id
AND v02.mandant_id= v07.mandant_id
LEFT OUTER JOIN dbp_view.v_crm_l_konto_1 v08
ON  v07.crm_konto_id = v08.crm_konto_id
LEFT OUTER JOIN dbp_view.v_werbewoche_kl_1 v09
ON  v01.bon_dat = v09.dat 
AND v01.mandant_id = v09.mandant_id
WHERE v02.turnover_fg = 1 
AND v02.kasse_typ_id <>5 AND v02.umsatz_brutto > 0
AND  ((v01.mandant_id IN (1,4,6)) OR (v01.mandant_id IN (2,5,7,8) 
AND v02.kassierer_nr NOT BETWEEN 800 AND 900) OR (v01.mandant_id = 3 AND (v02.kassierer_nr NOT BETWEEN 700 AND 900)))
AND (v02.mandant_id,v01.bon_dat,v01.bon_id, v01.bon_zeile) 
NOT IN 
(SELECT mandant_id, bon_dat, bon_id, bon_zeile FROM dbp_ods.ods_bon_retoure_1)
AND akt_kjwo_ww BETWEEN -52 AND 0
AND v02.kunde_fg = 1 AND v02.suspended_fg = 0
--AP0242994/SPEC0276113 Filtern von wg_id = 961 / sschuecke 18.10.2024
AND v01.wg_id <> 961
GROUP BY
 v08.crm_konto_id
,v05.art_id
,v01.wg_id
,v01.mandant_id
,v08.crm_konto_typ_id
,v01.bon_dat
,v09.kjwo_ww
;