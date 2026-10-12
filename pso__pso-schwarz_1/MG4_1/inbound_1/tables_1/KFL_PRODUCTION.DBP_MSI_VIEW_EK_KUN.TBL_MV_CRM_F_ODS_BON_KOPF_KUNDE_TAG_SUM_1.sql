create or replace dynamic table KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.TBL_MV_CRM_F_ODS_BON_KOPF_KUNDE_TAG_SUM_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	WRG_ID,
	KUNDENKARTE_ID,
	CRM_KUNDENKARTE_ART_ID,
	CRM_KONTO_ID,
	CRM_KONTO_TYP_ID,
	DAT,
	UMSATZ_NETTO_SA,
	UMSATZ_NETTO_AF,
	UMSATZ_BRUTTO_SA,
	UMSATZ_BRUTTO_AF,
	ANZ_BONS
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_P_DYNAMIC_TABLE_EK_KUN
 as
SELECT 
   k.mandant_id                
   ,k.wup_id  
   ,k.nb_id
   ,k.wrg_id
   ,k.kundenkarte_id
   ,kar.crm_kundenkarte_art_id
   ,kon.crm_konto_id  
   ,kon.crm_konto_typ_id
   ,k.dat 
   ,k.umsatz_netto_sa
   ,k.umsatz_netto_af
   ,k.umsatz_brutto_sa
   ,k.umsatz_brutto_af
   ,k.anz_bons

FROM dbp_view.v_crm_kartebew_1 k

/* Erweiterung Logik um Subselect, um doppelte Karten_ids bei falscher Beladung auszuschließen / sschuecke 07.06.2024 */
JOIN 
(SELECT kundenkarte_id, mandant_id, crm_kundenkarte_art_id, crm_kundenkarte_nr, crm_konto_id, gesperrt_fg, zeit_von, zeit_bis, geloescht_fg
 FROM dbp_view.v_crm_l_kundenkarte_1 GROUP BY ALL) kar
 ON kar.kundenkarte_id = k.kundenkarte_id
 AND kar.mandant_id=k.mandant_id

LEFT OUTER JOIN dbp_view.v_crm_l_konto_1 kon
 ON kon.crm_konto_id = kar.crm_konto_id
;