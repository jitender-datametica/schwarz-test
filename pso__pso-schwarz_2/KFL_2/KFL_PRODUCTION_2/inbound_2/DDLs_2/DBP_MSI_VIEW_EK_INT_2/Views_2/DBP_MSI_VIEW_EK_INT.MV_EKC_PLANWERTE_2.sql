CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_EKC_PLANWERTE_2
(
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
)
AS 
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
FROM DBP_VIEW.v_ekc_planwerte_2 v01;