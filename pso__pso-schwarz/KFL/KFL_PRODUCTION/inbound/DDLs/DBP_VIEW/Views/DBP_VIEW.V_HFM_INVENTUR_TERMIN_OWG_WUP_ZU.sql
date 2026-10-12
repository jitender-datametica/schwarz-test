create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_HFM_INVENTUR_TERMIN_OWG_WUP_ZU(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	OWG_ID,
	ARTHIERTYP_ID,
	DAT_PLAN_ZAEHLUNG,
	INVENTURART_INT_ID,
	WRG_ID,
	DAT_VORLETZTE_ZAEHLUNG,
	UMSATZ_VK_NETTO_SUM,
	INVENTUR_WERT_VK_NETTO,
	BETRAG_NETTO_DIEBSTAHL_ABSCHRIFT,
	BETRAG_NETTO_PREIS_ABSCHRIFT,
	BETRAG_NETTO_TOTAL_ABSCHRIFT,
	BETRAG_KALK_INVENTUR_DIFF
) as 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        owg_id,
        arthiertyp_id,
        dat_plan_zaehlung,
        inventurart_int_id,
        wrg_id,
        dat_vorletzte_zaehlung,
        umsatz_vk_netto_sum,
        inventur_wert_vk_netto,
        betrag_netto_diebstahl_abschrift,
        betrag_netto_preis_abschrift,
        betrag_netto_total_abschrift,
        betrag_kalk_inventur_diff
FROM DBP_DATA.HFM_INVENTUR_TERMIN_OWG_WUP_ZU ;
