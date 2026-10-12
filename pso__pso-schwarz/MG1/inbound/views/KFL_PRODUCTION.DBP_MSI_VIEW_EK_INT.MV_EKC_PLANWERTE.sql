create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_EKC_PLANWERTE(
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
-- 01.06.2021 AP0032683_SPEC0069782 - Erstellung der View auf SF
SELECT 
 v01.mandant_id
,v01.hwg_id
,v01.arthiertyp_id
,v01.dat
,v01.wrg_id
,v01.abschriftsbetrag_werbung_netto
,v01.umsatz_netto_sa
,v01.umsatz_netto_af
,v01.abschriftsbetrag_ohne_werbung_netto
,v01.wa_kalk_netto
-- 02.05.2022 AP0125312/SPEC0150218 - Erweiterung um AF/SA / sschuecke
,v01.wa_kalk_netto_af
,v01.wa_kalk_netto_sa
FROM DBP_VIEW.v_ekc_planwerte v01;