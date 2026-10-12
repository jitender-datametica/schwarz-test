create or replace view KFL_PRODUCTION.DBP_VIEW.V_EKC_PLANWERTE(
	MANDANT_ID,
	HWG_ID,
	ARTHIERTYP_ID,
	DAT,
	WRG_ID,
	ABSCHRIFTSBETRAG_WERBUNG_NETTO,
	UMSATZ_NETTO_SA,
	UMSATZ_NETTO_AF,
	ABSCHRIFTSBETRAG_OHNE_WERBUNG_NETTO,
	WA_KALK_NETTO,
	WA_KALK_NETTO_AF,
	WA_KALK_NETTO_SA
) as 
    SELECT 
        mandant_id
        ,hwg_id
        ,arthiertyp_id
        ,dat
        ,wrg_id
        ,abschriftsbetrag_werbung_netto
        ,umsatz_netto_sa
        ,umsatz_netto_af
        ,abschriftsbetrag_ohne_werbung_netto
        ,wa_kalk_netto
        ,wa_kalk_netto_af
        ,wa_kalk_netto_sa


FROM DBP_DATA.ekc_planwerte ;