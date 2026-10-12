CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_ARTBEW_VW_SUM_1 
(
umsatz_mwst_betrag,
DIFF_UMSATZ_MWST_BETRAG_KONZ,
UMSATZ_NETTO,
DIFF_UMSATZ_NETTO_KONZ,
MENGE,
EK_NETTONETTO,
DIFF_EK_NETTONETTO_KONZ,
EK_MEP,
DIFF_EK_MEP_KONZ,
EINSTANDSPREIS,
DIFF_EINSTANDSPREIS_KONZ,
BEWART_ID,
BEWART_DET_ID,
POSTEN_ID,
WUP_BEREINIGT_FG,
PV_AKTION,
PV_AKTION_KONZ,
PV_AKTION_BBY,
PV_AKTION_BBY_KONZ,
PV_AKTION_KDN_BBY,
PV_AKTION_KDN_BBY_KONZ,
PV_AKTION_KDP_BBY,
PV_AKTION_KDP_BBY_KONZ,
PV_BBY,
PV_BBY_KONZ,
PV_KDN_BBY,
PV_KDN_BBY_KONZ,
PV_KDP_BBY,
PV_KDP_BBY_KONZ,
DAT,
ART_ID,
MANDANT_ID,
GP_ID,
HERST_ID,
EAN_KASSE,
VW_ID,
BEZUGSWEG_ID,
WRG_ID,
EK_BRUTTO,
DIFF_EK_BRUTTO_KONZ,
EK_GLD,
DIFF_EK_GLD_KONZ,
EK_NETTO,
DIFF_EK_NETTO_KONZ,
EK_NETTO_BNK,
DIFF_EK_NETTO_BNK_KONZ,
BONUSBASIS,
BONUSBASIS_KONZ,
EK_MEP_VOR_FWU,
EK_MEP_VOR_FWU_KONZ,
EK_KAL_BASIS,
DIFF_EK_KAL_BASIS_KONZ,
PV_BONRABATT_BBY,
PV_BONRABATT_BBY_KONZ,
UMRECHNUNGSKURS_HIST
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
SELECT
--SPEC0068483 - adding bewart_1 1010 to the AF columns
--AP0077097, SPEC0094265 - new umsatz and absatz metrics
--AP0077097, SPEC0094266 - new PV metrics
 v01.umsatz_mwst_betrag
--AP0180589/SPEC0239966 Kurskorrektur, Umstellung auf KONZ Spalten zwecks Performance, Aufnahme KONZ Spalten / sschuecke 29.02.2024
,v01.diff_umsatz_mwst_betrag_konz
,v01.umsatz_netto
,v01.diff_umsatz_netto_konz
,v01.menge
,v01.ek_nettonetto
,v01.diff_ek_nettonetto_konz
,v01.ek_mep
,v01.diff_ek_mep_konz
,v01.einstandspreis
,v01.diff_einstandspreis_konz
,v01.bewart_id
,v01.bewart_det_id
,v02.posten_id
,v01.wup_bereinigt_fg
,v01.pv_aktion
,v01.pv_aktion_konz
,v01.pv_aktion_bby
,v01.pv_aktion_bby_konz
,v01.pv_aktion_kdn_bby
,v01.pv_aktion_kdn_bby_konz
,v01.pv_aktion_kdp_bby
,v01.pv_aktion_kdp_bby_konz
,v01.pv_bby
,v01.pv_bby_konz
,v01.pv_kdn_bby
,v01.pv_kdn_bby_konz
,v01.pv_kdp_bby
,v01.pv_kdp_bby_konz
,v01.dat
,v01.art_id
,v01.mandant_id
,v01.gp_id
,v01.herst_id
,v01.ean_kasse
,v01.vw_id
,v01.bezugsweg_id
,v01.wrg_id
,v01.ek_brutto
,v01.diff_ek_brutto_konz
,v01.ek_gld
,v01.diff_ek_gld_konz
,v01.ek_netto
,v01.diff_ek_netto_konz
,v01.ek_netto_bnk
,v01.diff_ek_netto_bnk_konz
,v01.bonusbasis
,v01.bonusbasis_konz
,v01.ek_mep_vor_fwu
,v01.ek_mep_vor_fwu_konz
,v01.ek_kal_basis
,v01.diff_ek_kal_basis_konz
,v01.pv_bonrabatt_bby
,v01.pv_bonrabatt_bby_konz
,v01.umrechnungskurs_hist

FROM DBP_DATA.ARTBEW_VW_SUM_1 v01

LEFT JOIN DBP_DATA.ART_PER_1 v02
ON v01.art_id = v02.art_id
AND v01.mandant_id = v02.mandant_id
AND v01.dat BETWEEN v02.dat_von-1 AND v02.dat_bis-1

WHERE v01.mandant_id <> 1
--AP0190987/SPEC0225041 Filter E-Loading Artikel_1 / sschuecke 17.11.2023
AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
--AP0227085/SPEC0284781 Filter E-Loading Artikel_1 / sschuecke 25.02.2025
AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640);